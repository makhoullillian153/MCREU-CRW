# Code authored by Bram Silbert in Python and translated to R by Lillian Makhoul

# give first ten values for first graph
# fix axis labels for T_N

library(ggplot2)

# --- --- #

# returns the time it takes for a cycle to fully coalesce for s observations
coalescence <- function(N,s){
  times <- numeric(s)
  
  if(N == 1){
    return(times)
  }
  
  if(N == 2){
    return(replicate(s,1))
  }

  for(i in 1:s){
    RW <- c(1:N)
    while(TRUE){
      # randomly sample from RW
      vertex <- sample(which(RW != 0), 1)
      times[i] <- times[i] + 1
      
      if(vertex == length(RW)){
        RW[1] <- RW[vertex]
        RW[vertex] <- 0
      } else{
        RW[vertex + 1] <- RW[vertex]
        RW[vertex] <- 0
      }
      
      # only 1 particle remains
      if(sum(RW == 0) == N-1){
        break
      }
    }
  }
  
  return(times)
}

times <- coalescence(10,100000)

ggplot() + geom_histogram(mapping = aes(x = times, y = ..density..), bins = max(times), 
                          binwidth = 3, fill = "white", color = "black") +
  theme_bw() + 
  xlab("Time to Coalesce") +
  ylab("Density")

x <- table(times)
s <- sum(x)
xx <- (s - cumsum(x))/100000

ggplot() + geom_line(mapping = aes(x = c(1:length(xx)),y = xx)) + 
  xlab("Index") + 
  ylab("P(T > t)") +
  theme_bw()

# --- --- #

# runs the coalescence function for multiple values of N
# returns each value of N with its corresponding average time to,
# variance, and second moments of coalescence
coal_func <- function(k){
  n_vals <- c(1:k)
  t_avg <- numeric()
  t_var <- numeric()
  t_sec <- numeric()
  for(i in 1:k){
    print(i)
    c <- coalescence(i, 100000)
    t_avg[i] <- mean(c)
    t_var[i] <- var(c)
    t_sec[i] <- mean(c^2)
  }
  
  return(c(n_vals, t_avg, t_sec, t_var))
}

k <- 30

lst <- coal_func(k)

n <- lst[1:k] # n_val
m <- lst[(k+1):(2*k)] # t_avg
s <- lst[(2*k+1):(3*k)] # t_sec
v <- lst[(3*k+1):(4*k)] # t_sec

lm(m ~ poly(n,2,raw = T))
lm(v ~ poly(n,4,raw = T))
lm(s ~ poly(n,4,raw = T))

ggplot(mapping = aes(n,m)) + 
  geom_smooth(method = 'lm',formula = y~poly(x,2, raw=TRUE), color = "black") +
  geom_point(color = "blue") +
  theme_bw() +
  xlab("N") +
  ylab("Mean Time to Coalescence")


df <- data.frame(n,s)

ggplot(df, mapping = aes(n,s)) + 
  geom_smooth(method = 'lm', formula = y~poly(x,3, raw=TRUE), color = "black") +
  # stat_function(fun=function(x) 3*x^4/10 - x^3/2 + 1/5) +
  geom_point(color = "blue") +
  theme_bw() + 
  xlab("N") + 
  ylab("Second Moment of Time to Coalescence")

df <- data.frame(n,v)

ggplot(df, mapping = aes(n,v)) + 
  geom_smooth(method = 'lm', formula = y~poly(x,4, raw=TRUE), color = "black") + 
  # stat_function(fun=function(x) x^4/20 - x^2/4 + 1/5) +
  geom_point(color = "blue") +
  theme_bw() +
  xlab("N") +
  ylab("Variance of Time to Coalescence")

# --- --- #

# returns the time it takes for a cycle to fully coalesce for s observations
annihilation <- function(N,s){
  times <- numeric(s)
  
  if(N == 1){
    return(times)
  }
  if(N == 2){
    return(replicate(s,1))
  }
  
  for(i in 1:s){
    RW <- c(1:N)
    while(TRUE){
      # randomly sample from RW
      vertex <- sample(which(RW != 0), 1)
      times[i] <- times[i] + 1
      
      if(vertex == length(RW)){
        if(RW[1] == 0){
          # shift 1 over
          RW[1] <- RW[vertex]
          RW[vertex] <- 0
        } else{ 
          # annihilation
          RW[vertex] <- 0
          RW[1] <- 0
        }
      } else{
        if(RW[vertex + 1] == 0){
          # shift 1 over
          RW[vertex + 1] <- RW[vertex]
          RW[vertex] <- 0
        } else{ 
          # annihilation
          RW[vertex] <- 0
          RW[vertex + 1] <- 0
        }
      }
      
      # stop at 1 particle if started with an odd N
      if(length(RW) %% 2 == 1){
        if(sum(RW == 0) == N-1){
          break
        }
      }
      
      # stop at 0 particles if started with an even N
      if(sum(RW == 0) == N){
        break
      }
    }
  }
  
  return(times)
}

times <- annihilation(10,100000)

ggplot() + geom_histogram(mapping = aes(x = times, y = ..density..), bins = max(times), 
                          fill = "white", color = "black", binwidth = 2) +
  xlab("Time to Annihilation") +
  ylab("Density") +
  theme_bw()

x <- table(times)
s <- sum(x)
xx <- (s - cumsum(x))/100000

ggplot() + geom_line(mapping = aes(x = c(1:length(xx)), y = xx)) +
  xlab("t") +
  ylab("P(T > t)") +
  theme_bw()

ggplot() + geom_line(mapping = aes(x = c(1:length(xx)), y = log(xx))) +
  xlab("t") +
  ylab("log(P(T > t))") +
  theme_bw()

# --- --- #

# Runs the annihilation function for multiple values of N
# Returns each value of N with its corresponding average time to and
# variance of annihilation
ann_func <- function(k){
  n_val <- c(1:k)
  t_avg <- numeric()
  t_var <- numeric()
  
  for(i in 1:k){
    c <- annihilation(i, 10000)
    t_avg[i] <- mean(c)
    t_var[i] <- var(c)
  }
  
  return(c(n_val, t_avg, t_var))
}

k <- 20

lst <- ann_func(k)

n <- lst[1:k] # n_val
m <- lst[(k+1):(2*k)] # t_avg
v <- lst[(2*k+1):(3*k)] # t_var

# Split values by even N's and odd N's
n_even <- n[n %% 2 == 0]
n_odd <- n[n %% 2 != 0]

m_even <- m[n_even]
m_odd <- m[n_odd]

v_even <- v[n_even]
v_odd <- v[n_odd]

# Averages
ggplot() + geom_smooth(method = "lm", formula = y ~ poly(x,2,raw = TRUE), 
                       mapping = aes(x = n_even, y = m_even)) +
  geom_point(mapping = aes(x = n_even,y = m_even), color = "green") +
  geom_smooth(method = "lm", formula = y ~ poly(x,2,raw = TRUE), 
              mapping = aes(x = n_odd, y = m_odd), color = "red") +
  geom_point(mapping = aes(x = n_odd, y = m_odd), color = "blue") +
  xlab("N") + 
  ylab("Mean Time to Annihilation") +
  theme_bw()

# Variances
ggplot() + geom_smooth(method = 'lm', formula = y ~ poly(x, 3, raw=TRUE), 
                       mapping = aes(x = n_even, y = v_even)) +
  geom_point(mapping = aes(x = n_even,y = v_even), color = "green") +
  geom_smooth(method = 'lm', formula = y ~ poly(x, 3, raw=TRUE), 
              mapping = aes(x = n_odd, y = v_odd), color = "red") +
  geom_point(mapping = aes(x = n_odd, y = v_odd), color = "blue") +
  xlab("N") + 
  ylab("Variance of Time to Annihilation") +
  theme_bw()

# --- --- #

# Returns the amount of steps the last surviving particle took in
# the coalescence model for s observations
survivor_steps <- function(N,s){
  max_steps <- numeric(s)
  
  if(N == 1){
    return(max_steps)
  }
  if(N == 2){
    return(replicate(s, 1))
  }
  
  for(i in 1:s){
    RW <- c(1:N)
    steps <- numeric(N)
    while(TRUE){
      # randomly sample from RW
      vertex <- sample(which(RW != 0), 1)
      steps[RW[vertex]] <- steps[RW[vertex]] + 1
      
      if(vertex == length(RW)){
        RW[1] <- RW[vertex]
        RW[vertex] <- 0
      } else{
        RW[vertex + 1] <- RW[vertex]
        RW[vertex] <- 0
      }
      
      if(sum(RW == 0) == N-1){
        break
      }
    }
    max_steps[i] <- max(steps)
  }
  
  return(max_steps)
}

steps <- survivor_steps(6,100000)

ggplot() + geom_histogram(mapping = aes(x = steps, y = ..density..), bins = max(steps), 
                          color = "black", fill = "white") +
  xlab("Steps Taken by Last Surviving Particle") +
  ylab("Density") +
  theme_bw()

x <- table(steps)
s <- sum(x)
xx <- (s - cumsum(x))/100000

ggplot() + geom_line(mapping = aes(x = c(1:length(xx)), y = xx)) +
  xlab("t") + 
  ylab("P(T >t)") +
  theme_bw()

ggplot() + geom_line(mapping = aes(x = c(1:length(xx)), y = log(xx))) +
  xlab("t") + 
  ylab("log(P(T >t))") +
  theme_bw()

# --- --- #

# Runs the survivor_steps for several values of N
# Returns each value of N with its corresponding average and
# variance of the steps taken by the last surviving particle
surv_func <- function(k){
  n_vals <- c(1:k)
  t_avg <- numeric()
  t_var <- numeric()
  t_sec <- numeric()
  
  for(i in 1:k){
    c <- survivor_steps(i,100000)
    t_avg[i] <- mean(c)
    t_var[i] <- var(c)
    t_sec[i] <- mean(c^2)
  }
  
  return(c(n_vals,t_avg,t_var,t_sec))
}

k <- 30

lst <- surv_func(k)

n <- lst[1:k] # n_val
m <- lst[(k+1):(2*k)] # t_avg
v <- lst[(2*k+1):(3*k)] # t_var
s <- lst[(3*k+1):(4*k)] # t_sec

ggplot(mapping = aes(x = n, y = m)) + 
  geom_smooth(method = "lm", formula = y ~ poly(x,2,raw = TRUE), 
                                                  color = "black") +
  geom_point(color = "blue") + 
  xlab("N") + 
  ylab("Mean Steps Taken by Surviving Particle") +
  theme_bw()

# y = 0.1666x^2 + 0.5058x - 0.7037

ggplot(mapping = aes(x = n, y = v)) + 
  geom_smooth(method = "lm", formula = y ~ poly(x,4, raw = TRUE),
                                                  color = "black") +
  geom_point(color = "blue") + 
  xlab("N") +
  ylab("Variance of Steps Taken by Surviving Particle") + 
  theme_bw()

lm(v ~ poly(n,4,raw=TRUE))

# y = 0.0149x^4 - 0.2059x^3 + 3.4974x^2 -21.3330x + 31.6806

ggplot(mapping = aes(x = n, y = s)) + 
  geom_smooth(method = "lm", formula = y ~ poly(x,4, raw = TRUE),
              color = "black") +
  geom_point(color = "blue") + 
  xlab("N") +
  ylab("Second Moment of Steps Taken by Surviving Particle") + 
  theme_bw()

lm(s ~ poly(n,4,raw=TRUE))

# y = 0.0462x^4 - 0.2260x^3 + 6.6775x^2 -40.4179x +58.5697

# --- --- #

# Begins simulation with 2 particles and N nodes
# Returns the amount of steps that the last surviving particle takes for
# s observations
pair_steps <- function(N, s){
  max_steps <- numeric(s)
  
  if(N == 1){
    return(max_steps)
  }
  if(N == 2){
    return(replicate(s, 1))
  }
  
  for(i in 1:s){
      RW <- c(1,2,replicate(N-2,0))
      steps <- numeric(2)
      
      while(TRUE){
        vertex <- sample(which(RW != 0), 1)
        steps[RW[vertex]] <- steps[RW[vertex]] + 1
        
        if(vertex == length(RW)){
          RW[1] <- RW[vertex]
          RW[vertex] <- 0
        } else{
          RW[vertex + 1] <- RW[vertex]
          RW[vertex] <- 0
        }
        
        if(sum(RW == 0) == N-1){
          break
        }
      }
    if(max(steps) == steps[1]){
      max_steps[i] <- 0
    } else {
      max_steps[i] <- max(steps)
    }
  }
  
  return(max_steps)
}

# Runs the pair_steps for several values of N
# Returns each value of N with its corresponding average 
# number of the steps taken by the last surviving particle
pair_func <- function(k){
  n_vals <- c(1:k)
  m_vals <- numeric(k)
  
  for(i in 1:k){
    m_vals[i] <- mean(pair_steps(i,50000))*i
  }
  
  return(c(n_vals, m_vals))
}

k <- 50

list1 <- pair_func(k)
list2 <- surv_func(k)

n1 <- list1[1:k] # n_val
m1 <- list1[(k+1):(2*k)] # m_vals

n2 <- list2[1:k] # n_val
m2 <- list2[(k+1):(2*k)] # t_avg

# Compare the results of pair_func with surv_func
ggplot() + geom_smooth(mapping = aes(n1,m1,color = "Start with Two"), method = "lm", 
                       formula = y ~ poly(x,2, raw = TRUE)) +
  geom_point(mapping = aes(n1, m1, color = "Start with Two")) +
  geom_smooth(mapping = aes(n2, m2, color = "Original"), method = "lm",
              formula = y ~ poly(x,2,raw = TRUE)) +
  geom_point(mapping = aes(n2,m2, color = "Original")) +
  xlab("N") +
  ylab("Mean Time to Coalescence") +
  theme_bw() + 
  scale_color_manual(name = "Legend", breaks = c("Start with Two","Original"), 
                     values = c("Start with Two" = "black", "Original" = "blue"))

# --- --- #

# Begins simulation with 2 particles and N nodes
# Returns the amount of steps that the second particle takes for
# s observations
pair_steps2 <- function(N,s){
  stepsOfSecond <- numeric(s)
  
  if(N == 1){
    return(stepsOfSecond)
  }
  if(N == 2){
    return(replicate(s, 1))
  }
  
  for(i in 1:s){
    RW <- c(1,2,replicate(N-2,0))
    steps <- numeric(2)
    
    while(TRUE){
      vertex <- sample(which(RW != 0), 1)
      steps[RW[vertex]] <- steps[RW[vertex]] + 1
      
      if(vertex == length(RW)){
        RW[1] <- RW[vertex]
        RW[vertex] <- 0
      } else{
        RW[vertex + 1] <- RW[vertex]
        RW[vertex] <- 0
      }
      
      if(sum(RW == 0) == N-1){
        break
      }
    }
    stepsOfSecond[i] <- steps[2]
  }
  
  return(stepsOfSecond)
}

# Runs the pair_steps2 for several values of N
# Returns each value of N with its corresponding average 
# number of the steps taken by the second particle
pair_func2 <- function(k){
  n_vals <- c(1:k)
  m_vals <- numeric(k)
  for(i in 1:k){
    m_vals[i] <- mean(pair_steps2(i,100000))*i
  }
  
  return(c(n_vals,m_vals))
}

k <- 30

lst <- pair_func2(k)

n <- lst[1:k] # n_vals
m <- lst[(k+1):(2*k)] # m_vals

ggplot(mapping = aes(x = n, y = m)) + geom_smooth(method = "lm", color = "black",
                                                  formula = y ~ poly(x,2,raw = TRUE)) +
  geom_point(color = "blue") +
  xlab("N") +
  ylab("Average Number of Steps Taken by Second Particle") +
  theme_bw()

# --- --- #

corr <- function(N,s){
  steps1 <- pair_steps2(N,s)
  steps2 <- pair_steps2(N,s)
  step_prod <- numeric()
  
  for(i in 1:s){
    step_prod[i] <- steps1[i]*steps2[i]
  }
  
  return(step_prod)
}

# Run the corr function for several values of N
corr_func <- function(k){
  n_vals <- c(1:k)
  m_vals <- numeric(k)
  
  for(i in 1:k){
    m_vals[i] <- mean(corr(i,10000))
  }
  
  return(c(n_vals, m_vals))
}

k <- 100
lst <- corr_func(k)

n <- lst[1:k] # n_vals
m1 <- lst[(k+1):(2*k)] # m_vals
m2 <- ((n-1)/2)^2

ggplot(mapping = aes(x = n)) +
  geom_smooth(mapping = aes(y = m1, color = "Empirical Results"), method = "lm", 
              formula = y ~ poly(x,2,raw = TRUE)) +
  geom_point(mapping = aes(y = m1)) +
  geom_line(mapping = aes(y = m2, color = "Calculated Results"), size = 1) +
  xlab("N") +
  ylab("Average Number of Steps") +
  theme_bw() +
  scale_color_manual(name = "Legend", 
                     breaks = c("Calculated Results","Empirical Results"), 
                     values = c("Calculated Results" = "red", "Empirical Results" = "blue"))


y <- numeric()

for(i in 1:length(n)){
  y[i] <- m1[i]/((n[i]-1)/2)^2
}

y <- y[-(1:2)]

ggplot() + geom_point(mapping = aes(x = c(1:length(y)), y = y))

# --- --- #

pair_steps3 <- function(N,s){
  stepsToAbsorb <- replicate(N,list(0))
  
  for(i in 1:s){
    RW <- c(1:N)
    steps <- numeric(N)
    
    while(TRUE){
      vertex <- sample(which(RW != 0), 1)
      steps[RW[vertex]] <- steps[RW[vertex]] + 1
      
      if(vertex == length(RW)){
        if(RW[1] != 0){ # absorbs a particle
          stepsToAbsorb[[RW[vertex]]][i] <- steps[RW[vertex]]
          RW[vertex] <- 0
        } else { # shift
          RW[1] <- RW[vertex]
          RW[vertex] <- 0
        }
      } else{
        if(RW[vertex + 1] != 0){ # absorbs a particle
          stepsToAbsorb[[RW[vertex]]][i] <- steps[RW[vertex]]
          RW[vertex] <- 0
        } else { # shift
          RW[vertex + 1] <- RW[vertex]
          RW[vertex] <- 0
        }
      }
      
      if(sum(RW == 0) == N-1){
        stepsToAbsorb[[RW[which(RW != 0)]]][i] <- steps[RW[which(RW != 0)]]
        break
      }
    }
    
  }
  
  return(stepsToAbsorb)
}

pair_exp <- function(N,s,m,n){
  steps <- pair_steps3(N,s)
  prod_exp <- numeric()
  
  for(k in 1:s){
    prod_exp[k] <- (steps[[m]][k])*(steps[[n]][k])
  }
  
  return(mean(prod_exp))
}

j_list <- c(2,5,10,15,20,25,30)

for(l in j_list){
  diff <- pair_exp(30, 100000, 1, l) - (29/2)^2
  print(paste("E[T0T",l,"] - E[T0]E[T",l,"] =", diff))
}

# --- --- #

j_list_2 <- c(2:30)
cov_list <- numeric()

for(w in j_list_2){
  cov_list[w-1] <- pair_exp(30, 100000, 1, w) - (29/2)^2
}


ggplot(mapping = aes(x = j_list_2, y = cov_list)) + 
  #geom_smooth(method = "lm", formula = y ~ poly(x,4, raw = TRUE), color = "black") +
  geom_point(color = "blue") +
  xlab("i") +
  ylab( expression("Cov["*S[0]*S[i]*"]") )  +
  theme_bw()

# --- --- #

lyons_line <- function(N,s){
  stepsToAbsorb <- replicate(N,list(0))
  
  for(i in 1:s){
    RW <- c(1:N)
    steps <- numeric(N)
    
    while(TRUE){
      vertex <- sample(which(RW != 0), 1)
      
      if(vertex != length(RW)){
        steps[RW[vertex]] <- steps[RW[vertex]] + 1
        if(RW[vertex + 1] != 0){ # absorbs a particle
          stepsToAbsorb[[RW[vertex]]][i] <- steps[RW[vertex]]
          RW[vertex] <- 0
        } else { # shift
          RW[vertex + 1] <- RW[vertex]
          RW[vertex] <- 0
        }
      }
      
      if(sum(RW == 0) == N-1){
        stepsToAbsorb[[RW[which(RW != 0)]]][i] <- steps[RW[which(RW != 0)]]
        break
      }
    }
    if(i %% 10000 == 0){
      print(i)
    }
  }
  
  return(stepsToAbsorb)
}

lyons_exp <- function(i, j, lyst){
  prod_exp <- numeric()
  for(k in 1:length(lyst)){
    prod_exp[k] <- lyst[[i]][k]*lyst[[j]][k]
  }
  
  return(mean(prod_exp))
}

# --- --- #

lyst <- lyons_line(30,1000000)
cov_list_2 <- numeric()

j_list_3 <- c(1:30)

for(w in 30:1){
  cov_list_2[w] <- lyons_exp(30, w, lyst) - (mean(lyst[[w]])*mean(lyst[[29]]))
}

ggplot() + geom_point(mapping = aes(j_list_3,cov_list_2)) +
  xlab("i") +
  ylab( expression("Cov["*tau[0]*tau[i]*"]") )  +
  theme_bw()

# --- --- #

pair_time <- function(N,s){
  t <- numeric(s)
  
  for(i in 1:s){
    RW <- c(1:N)
    steps <- numeric(N)
    while(TRUE){
      # randomly sample from RW
      vertex <- sample(which(RW != 0), 1)
      
      if(vertex == length(RW)){
        steps[RW[vertex]] <- steps[RW[vertex]] + 1
        RW[1] <- RW[vertex]
        RW[vertex] <- 0
      } else{
        steps[RW[vertex]] <- steps[RW[vertex]] + 1
        RW[vertex + 1] <- RW[vertex]
        RW[vertex] <- 0
      }
      
      if(sum(RW == 0) == N-1){
        break
      }
    }
    t[i] <- max(steps)
  }
  
  return(t)
}

s <- 100000
n <- 10

t <- pair_time(n,s)

calcDelta <- function(lambda){
  return(sqrt(1-exp(-lambda)))
}

calcX <- function(delta){
  return((1-delta)/(1+delta))
}

f1 <- function(lambda, t, s){
  val <- 0
  for(i in 1:s){
    val <- val + exp(-lambda*t[i])
  }
  val <- val*(1/s)
  return(val)
}

f2 <- function(n,x,lambda){
  val <- (n*(sinh(0.5*log(x))/sinh((n/2)*log(x))))*exp(-lambda*(n-1)/2)
  val[1] <- 1
  return(val)
}

lambda <- seq(0,1,0.05)
delta <- calcDelta(lambda)
x <- calcX(delta)

val1 <- f1(lambda, t, s)
val2 <- f2(n,x,lambda)

ggplot(mapping = aes(x = lambda)) + 
  geom_line(mapping = aes(y = val2, color = "Calculated Results")) + 
  geom_point(mapping = aes(y = val1, color = "Empirical Results")) + 
  xlab(expression(lambda)) +
  ylab(expression(paste("f(",lambda,")"))) + 
  scale_color_manual(name = "Legend",breaks = c("Calculated Results","Empirical Results"), 
                     values = c("Calculated Results" = "black", "Empirical Results" = "blue")) +
  theme_bw()

ggplot(mapping = aes(x = lambda)) + 
  geom_line(mapping = aes(y = log(val2), color = "Calculated Results")) + 
  geom_point(mapping = aes(y = log(val1), color = "Empirical Results")) + 
  xlab(expression(lambda)) +
  ylab(expression(paste("log(f(",lambda,"))"))) + 
  scale_color_manual(name = "Legend",breaks = c("Calculated Results","Empirical Results"), 
                     values = c("Calculated Results" = "black", "Empirical Results" = "blue")) +
  theme_bw()

# --- --- #

# Runs coalescence model with the following conditions:
#if particle moves into occupied node
  #if the absorber is 0, resets the whole system
  #else
    #if the absorbee is 0, removes absorber and counts its steps
    #if absorbee is not 0, removes absorbee and counts its steps
# Returns the amount of steps each particle took until absorbed and
# Total time spent to coalescence, for s observations
taus <- function(N,s){
  
  stepsToAbsorb <- replicate(N,list(0))
  times <- numeric(s)
  
  removeAbsorbee <- function(RW, vertex){
    if(vertex == length(RW)){
      RW[1] <- RW[vertex]
      RW[vertex] <- 0
    } else{
      RW[vertex + 1] <- RW[vertex]
      RW[vertex] <- 0
    }
    
    return(RW)
  }
  
  for(i in 1:s){
    RW <- c(1:N)
    steps <- numeric(N)
    
    while(TRUE){
      times[i] <- times[i] + 1
      vertex <- sample(which(RW != 0), 1)
      steps[RW[vertex]] <- steps[RW[vertex]] + 1
      absorption <- FALSE
      absorber <- RW[vertex]
      absorbee <- 0
      
      # determine if absorption occurs and record absorbee
      if(vertex == length(RW)){
        if(RW[1] != 0){ # absorbs a particle
          absorbee <- RW[1]
          absorption <- TRUE
        }
      } else{
        if(RW[vertex + 1] != 0){ # absorbs a particle
          absorption <- TRUE
        }
      }
      
      if(absorption){
        if(absorber == 1){ # reset the system
          RW <- c(1:N)
          steps <- numeric(N)
          times[i] <- 0
        } else {
          if(absorbee == 1){ # remove absorber
            RW[vertex] <- 0
          } else {
            RW <- removeAbsorbee(RW, vertex)
          }
        }
      } else { # shift
        if(vertex == length(RW)){
          RW[1] <- RW[vertex]
          RW[vertex] <- 0
        } else {
          RW[vertex + 1] <- RW[vertex]
          RW[vertex] <- 0
        }
      }
      
      if(sum(RW == 0) == N-1){
        for(j in 1:N){
          stepsToAbsorb[[j]][i] <- steps[j]
        }
        break
      }
    }
    if(i %% 1000 == 0){
      print(i)
    }
  }
  
  return(c(stepsToAbsorb, times))
}

tau_exp <- function(N,s){
  E_taus <- numeric()
  list <- taus(N,s)
  
  steps <- list[1:N]
  times <- as.numeric(list[(N+1):length(list)])
  E_time <- mean(times)
  
  for(i in 1:N){
    E_taus[i] <- mean(steps[[i]])
  }
  
  return(c(E_taus,E_time))
}

N <- 50
s <- 100000

list <- tau_exp(N,s)

E_tau_lst <- list[1:N]
E_time <- list[(N+1)]
total <- 0

for(i in 1:N){
  total <- total + E_tau_lst[i]
  print(E_tau_lst[i])
}

print(total)
print(E_time)

# --- --- #

# REVISIT
# might just be double counting
# missing a condition in taus function that i need to account for?

ggplot(mapping = aes(c(3:N), y = E_tau_lst[3:N])) +
  geom_point() +
  xlab("i") + 
  ylab("E[tau_i]") +
  theme_bw()
