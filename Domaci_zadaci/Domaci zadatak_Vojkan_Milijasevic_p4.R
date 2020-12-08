library(ggplot2)

#A
ggplot2::ggplot(mpg, 
                aes(x = displ, y = hwy)) +
  geom_point() +
  geom_smooth(se = FALSE)

#B
ggplot2::ggplot(mpg, 
                aes(x = displ, y = hwy)) +
  geom_smooth(aes(group = drv),
              se = FALSE,
              show.legend = FALSE) +
  geom_point()

#C
ggplot(mpg, 
       aes(x = displ, y = hwy, colour = drv)) +
  geom_point() +
  geom_smooth(se = FALSE)

#D
ggplot(mpg, 
       aes(x = displ, y = hwy)) +
  geom_point(aes(colour = drv)) +
  geom_smooth(se = FALSE)

#E
ggplot(mpg, 
       aes(x = displ, y = hwy)) +
  geom_point(aes(colour = drv)) +
  geom_smooth(aes(linetype = drv),
              se = FALSE)

#F
ggplot(mpg, 
       aes(x = displ, y = hwy)) +
  geom_point(size = 5, 
             colour = "white") +
  geom_point(aes(colour = drv))