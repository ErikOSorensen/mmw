role_of_merit_table_l <- function(mmw2018) {
  tabledf <- mmw2018 |>
    mutate(all_to_winner = as.numeric(y2==e2),
           share_to_winner = y2/(y1+y2),
           winning_margin = x2-x1,
           republican = as.numeric(pol2==1),
           college = as.numeric(education>4),
           female = as.numeric(sex==2),
           above_median_age = as.numeric(age > median(age)),
           regionf = factor(area),
           treatmentf = relevel(factor(treatment), ref = "Base"),
           competition = as.numeric(treatment!="Base"))
  
  c1 <- tabledf |> feols(all_to_winner ~ competition, data=_, vcov="hetero")
  c2 <- tabledf |> feols(all_to_winner ~ competition + republican + college + female + above_median_age | regionf, data=_, vcov="hetero")
  c3 <- tabledf |> filter(treatment %in% c("Base","WTA")) |> feols(all_to_winner ~ competition + republican + college + female + above_median_age | regionf, data=_, vcov="hetero")
  c4 <- tabledf |> filter(winning_margin==1 | treatment=="Base") |> feols(all_to_winner ~ competition + republican + college + female + above_median_age | regionf, data=_, vcov="hetero")
  c5 <- tabledf |> feols(share_to_winner ~ competition, data=_, vcov="hetero")
  c6 <- tabledf |> feols(share_to_winner ~ competition + republican + college + female + above_median_age | regionf, data=_, vcov="hetero")
  c7 <- tabledf |> filter(treatment %in% c("Base","WTA")) |> feols(share_to_winner ~ competition + republican + college + female + above_median_age | regionf, data=_, vcov="hetero")
  c8 <- tabledf |> filter(winning_margin==1 | treatment=="Base") |> feols(share_to_winner ~ competition + republican + college + female + above_median_age | regionf, data=_, vcov="hetero")
  role_of_merit <- list(c1,c2,c3,c4,c5,c6,c7,c8)
  role_of_merit
}


role_of_winning_margin_l <- function(mmw2018) {
  tabledf <- mmw2018 |>
    filter(treatment!="Base") |>
    mutate(all_to_winner = as.numeric(y2==e2),
           share_to_winner = y2/(y1+y2),
           winning_margin = x2-x1,
           republican = as.numeric(pol2==1),
           college = as.numeric(education>4),
           female = as.numeric(sex==2),
           above_median_age = as.numeric(age > median(age)),
           regionf = factor(area),
           performance_winner = x2)
  
  d1 <- tabledf |> feols(all_to_winner ~ winning_margin, data=_, vcov="hetero")
  d2 <- tabledf |> feols(all_to_winner ~ winning_margin + republican + college + female + above_median_age | regionf, data=_, vcov="hetero")
  d3 <- tabledf |> feols(all_to_winner ~ winning_margin + republican + college + female + above_median_age + performance_winner | regionf, data=_, vcov="hetero")
  d4 <- tabledf |> feols(share_to_winner ~ winning_margin, data=_, vcov="hetero")
  d5 <- tabledf |> feols(share_to_winner ~ winning_margin + republican + college + female + above_median_age | regionf, data=_, vcov="hetero")
  d6 <- tabledf |> feols(share_to_winner ~ winning_margin + republican + college + female + above_median_age + performance_winner | regionf, data=_, vcov="hetero")
  
  role_of_margin <- list(d1,d2,d3,d4,d5,d6)
  role_of_margin
}

ass_giving_all_attitudes_l <- function(mmw2018) {
  tabledf <- mmw2018 |>
    filter(treatment!="Base") |>
    mutate(all_to_winner = as.numeric(y2==e2),
           share_to_winner = y2/(y1+y2),
           winning_margin = x2-x1,
           republican = as.numeric(pol2==1),
           college = as.numeric(education>4),
           female = as.numeric(sex==2),
           above_median_age = as.numeric(age > median(age)),
           regionf = factor(area),
           performance_winner = x2)
  
  t4_c1 <- tabledf |> fixest::feols(scale(8-att3) ~ all_to_winner, data=_, vcov="hetero")
  t4_c2 <- tabledf |> fixest::feols(scale(8-att3) ~ republican + college + female + above_median_age | regionf, data=_, vcov="hetero")
  t4_c3 <- tabledf |> fixest::feols(scale(8-att3) ~ all_to_winner + republican + college + female + above_median_age | regionf, data=_, vcov="hetero")
  
  t4_c4 <- tabledf |> fixest::feols(scale(8-att4) ~ all_to_winner, data=_, vcov="hetero")
  t4_c5 <- tabledf |> fixest::feols(scale(8-att4) ~ republican + college + female + above_median_age | regionf, data=_, vcov="hetero")
  t4_c6 <- tabledf |> fixest::feols(scale(8-att4) ~ all_to_winner + republican + college + female + above_median_age | regionf, data=_, vcov="hetero")
  
  t4_c7 <- tabledf |> fixest::feols(scale(att2) ~ all_to_winner, data=_, vcov="hetero")
  t4_c8 <- tabledf |> fixest::feols(scale(att2) ~ republican + college + female + above_median_age | regionf, data=_, vcov="hetero")
  t4_c9 <- tabledf |> fixest::feols(scale(att2) ~ all_to_winner + republican + college + female + above_median_age | regionf, data=_, vcov="hetero")
  
  all_to_winner <- list(t4_c1, t4_c2, t4_c3, t4_c4, t4_c5, t4_c6, t4_c7, t4_c8, t4_c9)
  
  u4_c1 <- tabledf |> fixest::feols(scale(8-att3) ~ share_to_winner, data=_, vcov="hetero")
  u4_c2 <- tabledf |> fixest::feols(scale(8-att3) ~ republican + college + female + above_median_age | regionf, data=_, vcov="hetero")
  u4_c3 <- tabledf |> fixest::feols(scale(8-att3) ~ share_to_winner + republican + college + female + above_median_age | regionf, data=_, vcov="hetero")
  
  u4_c4 <- tabledf |> fixest::feols(scale(8-att4) ~ share_to_winner, data=_, vcov="hetero")
  u4_c5 <- tabledf |> fixest::feols(scale(8-att4) ~ republican + college + female + above_median_age | regionf, data=_, vcov="hetero")
  u4_c6 <- tabledf |> fixest::feols(scale(8-att4) ~ share_to_winner + republican + college + female + above_median_age | regionf, data=_, vcov="hetero")
  
  u4_c7 <- tabledf |> fixest::feols(scale(att2) ~ share_to_winner, data=_, vcov="hetero")
  u4_c8 <- tabledf |> fixest::feols(scale(att2) ~ republican + college + female + above_median_age | regionf, data=_, vcov="hetero")
  u4_c9 <- tabledf |> fixest::feols(scale(att2) ~ share_to_winner + republican + college + female + above_median_age | regionf, data=_, vcov="hetero")
  
  share_to_winner <- list(u4_c1, u4_c2, u4_c3, u4_c4, u4_c5, u4_c6, u4_c7, u4_c8, u4_c9)
  
  list("all_to_winner"=all_to_winner, 
       "share_to_winner"=share_to_winner)
  
}




role_of_winning_margin_2025_ll <- function(mmw2025) {
  tabledf <- mmw2025 |>
    labelled::remove_labels() |>
    mutate(all_to_winner = as.numeric(y2==e2),
           share_to_winner = y2/(y1+y2),
           winning_margin = x2-x1,
           republican = as.numeric(pol2==1),
           college = as.numeric(education>4),
           female = as.numeric(sex==2),
           above_median_age = as.numeric(age > median(age)),
           regionf = factor(region),
           treatmentf = relevel(factor(treatment), ref = "baseline"))
  c1 <- tabledf |> lm(all_to_winner ~ winning_margin, data=_)
  c2 <- tabledf |> lm(all_to_winner ~ winning_margin + treatmentf*winning_margin , data=_)
  c3 <- tabledf |> lm(all_to_winner ~ winning_margin + treatmentf*winning_margin + republican + college + female + above_median_age + regionf , data=_)
  c4 <- tabledf |> lm(all_to_winner ~ winning_margin + treatmentf*winning_margin + x2 + republican + college + female + above_median_age + regionf , data=_)
  
  me_c2 <- slopes(c2, variables = "winning_margin", by = "treatmentf")
  me_c3 <- slopes(c3, variables = "winning_margin", by = "treatmentf")
  me_c4 <- slopes(c4, variables = "winning_margin", by = "treatmentf")
  
  
  d1 <- tabledf |> lm(share_to_winner ~ winning_margin, data=_)
  d2 <- tabledf |> lm(share_to_winner ~ winning_margin + treatmentf*winning_margin , data=_)
  d3 <- tabledf |> lm(share_to_winner ~ winning_margin + treatmentf*winning_margin + republican + college + female + above_median_age + regionf , data=_)
  d4 <- tabledf |> lm(share_to_winner ~ winning_margin + treatmentf*winning_margin + x2 + republican + college + female + above_median_age + regionf , data=_)
  me_d2 <- slopes(d2, variables = "winning_margin", by = "treatmentf")
  me_d3 <- slopes(d3, variables = "winning_margin", by = "treatmentf")
  me_d4 <- slopes(d4, variables = "winning_margin", by = "treatmentf")
  
  extra_rows <- tibble(
    row_names = c("M.E. W.M. attention", "", "M.E. W.M. show distribution", ""),
    
    c1 = rep(NA, 4),
    c2 = c(
      sprintf("%.3f", tidy(me_c2)$estimate[2]),
      sprintf("(%.3f)", tidy(me_c2)$std.error[2]),
      sprintf("%.3f", tidy(me_c2)$estimate[3]),
      sprintf("(%.3f)", tidy(me_c2)$std.error[3])
    ),
    c3 = c(
      sprintf("%.3f", tidy(me_c3)$estimate[2]),
      sprintf("(%.3f)", tidy(me_c3)$std.error[2]),
      sprintf("%.3f", tidy(me_c3)$estimate[3]),
      sprintf("(%.3f)", tidy(me_c3)$std.error[3])
    ),
    c4 = c(
      sprintf("%.3f", tidy(me_c4)$estimate[2]),
      sprintf("(%.3f)", tidy(me_c4)$std.error[2]),
      sprintf("%.3f", tidy(me_c4)$estimate[3]),
      sprintf("(%.3f)", tidy(me_c4)$std.error[3])
    ),
    d1 = rep(NA, 4),
    d2 = c(
      sprintf("%.3f", tidy(me_d2)$estimate[2]),
      sprintf("(%.3f)", tidy(me_d2)$std.error[2]),
      sprintf("%.3f", tidy(me_d2)$estimate[3]),
      sprintf("(%.3f)", tidy(me_d2)$std.error[3])
    ),
    d3 = c(
      sprintf("%.3f", tidy(me_d3)$estimate[2]),
      sprintf("(%.3f)", tidy(me_d3)$std.error[2]),
      sprintf("%.3f", tidy(me_d3)$estimate[3]),
      sprintf("(%.3f)", tidy(me_d3)$std.error[3])
    ),
    d4 = c(
      sprintf("%.3f", tidy(me_d4)$estimate[2]),
      sprintf("(%.3f)", tidy(me_d4)$std.error[2]),
      sprintf("%.3f", tidy(me_d4)$estimate[3]),
      sprintf("(%.3f)", tidy(me_d4)$std.error[3])
    )
  )
  
  # Replace all NAs with "" (empty string)
  extra_rows[is.na(extra_rows)] <- ""
  
  list("regressions" = list(c1,c2,c3,c4,d1,d2,d3,d4),
       "extra_rows" = extra_rows)
}


make_labels <- function(x) {
  x <- trimws(as.character(x))
  x <- gsub('^WTA:\\s*No\\s*Choice$', "WTA\u2013No Choice", x, perl = TRUE)
  x <- gsub('^WTA:\\s*No\\s*Exp(?:ectations?)?$', "WTA\u2013No Expectations", x, perl = TRUE)
  x <- gsub('^WTA:\\s*', "WTA\u2013", x, perl = TRUE)
  x
}


share_of_earnings_to_winner_g <- function(mmw2018) {
  mmw2018 |> 
    filter(treatment!="Base") |>
    mutate(share_to_winner = y2/e2,
           treatment = make_labels(treatment)) |>
    ggplot(aes(x = share_to_winner)) +
    geom_histogram(aes(x = share_to_winner, y = (..count..)/tapply(..count..,..PANEL..,sum)[..PANEL..]),
                   binwidth = 0.05,
                   boundary=0) +
    theme_minimal() +
    labs(x = "Share to winner",
         y = "Share of spectators") +
    scale_x_continuous(breaks = c(0, 0.5, 1)) +
    facet_wrap(~treatment)
}

winner_take_all_vs_luck_lg <- function(mmw2018) {
  t1 <- mmw2018 |> 
    mutate(share_to_winner = floor( (y2/e2) / 0.05) * 0.05) 
  t1_all_wta <-  t1 |> filter(treatment!="Base")
  all_wta <- t1_all_wta |> filter(treatment!="Base")|>
    group_by(share_to_winner) |> 
    summarize(fraction_wta = n()/nrow(t1_all_wta))
  t1_all_luck <-  t1 |> filter(treatment=="Base")
  all_luck <- t1_all_luck |> filter(treatment=="Base")|>
    group_by(share_to_winner) |> 
    summarize(fraction_luck = n()/nrow(t1_all_luck))
  left_df <- all_wta |> left_join(all_luck) 

  left <- left_df |>
    ggplot(aes(x = share_to_winner)) +
    geom_col(aes(y = fraction_wta, fill = "WTA"),
             width = 0.05, colour = NA) +
    geom_col(aes(y = fraction_luck, fill = "Luck"),
             width = 0.05, colour = "black") +
    scale_y_continuous(
      limits = c(0, 0.5),
      breaks = seq(0, 0.5, by = 0.1),
      labels = number_format(accuracy = 0.1, decimal.mark = ".")
    ) +
    theme_minimal() +
    scale_fill_manual(
      name   = "Treatments",
      values = c("WTA" = "grey", "Luck" = NA),
      breaks = c("WTA", "Luck")
    ) +
    guides(
      fill = guide_legend(
        override.aes = list(
          fill   = c("grey", NA),
          colour = c(NA, "black"),
          size   = c(NA, 0.6) 
        )
      )
    ) +
    labs(
      x = "Share to winner",
      y = "Share of spectators",
      title = "Full sample",
      subtitle = "All winning margins"
    )
  
  
  
  t2 <- t1 |> filter( x2-x1 == 1) 
  t2_all_wta <-  t2 |> filter(treatment!="Base")
  all_wta <- t2_all_wta |> filter(treatment!="Base")|>
    group_by(share_to_winner) |> 
    summarize(fraction_wta = n()/nrow(t2_all_wta))
  nl <- nrow(t1 |> filter(treatment=="Base"))
  t2_all_luck <-  t1 |> filter(treatment=="Base") |>
    group_by(share_to_winner) |> 
    summarize(fraction_luck = n()/nl)
  right_df <- all_wta |> left_join(t2_all_luck) 
  right <- right_df |>
    ggplot(aes(x = share_to_winner)) +
    geom_col(aes(y = fraction_wta, fill = "WTA"),
             width = 0.05, colour = NA) +
    geom_col(aes(y = fraction_luck, fill = "Luck"),
             width = 0.05, colour = "black") +
    scale_y_continuous(
      limits = c(0, 0.5),
      breaks = seq(0, 0.5, by = 0.1),
      labels = number_format(accuracy = 0.1, decimal.mark = ".")
    ) +
    theme_minimal() +
    scale_fill_manual(
      name   = "Treatments",
      values = c("WTA" = "grey", "Luck" = NA),
      breaks = c("WTA", "Luck")
    ) +
    guides(
      fill = guide_legend(
        override.aes = list(
          fill   = c("grey", NA),
          colour = c(NA, "black"),
          size   = c(NA, 0.6) 
        )
      )
    ) +
    labs(
      x = "Share to winner",
      y = "Share of spectators",
      title = "Subsample",
      subtitle = "Smallest winning margin"
    )
  x <- list( "left"=left, "right"=right)
  
  x
}

role_of_winning_margin_graph_lg <- function(mmw2018) {
  top_df <- mmw2018 |> mutate(all_to_winner = as.numeric(y2==e2),
                           winning_margin = x2-x1,
                           winning_margin = if_else(winning_margin >=15, 15, winning_margin)) |>
    filter(treatment!="Base") |>
    group_by(winning_margin) |>
    summarize(mean_winner = mean(all_to_winner),
              se_winner = sd(all_to_winner)/sqrt(n()))
  
  top <- top_df |>
    ggplot(aes(x = winning_margin, y = mean_winner, ymin = mean_winner-se_winner, ymax=mean_winner+se_winner)) +
    geom_point() +
    geom_errorbar(width=0.4) +
    geom_line() +
    theme_minimal() +
    scale_x_continuous(
      breaks = 0:15,
      labels = function(x) ifelse(x == 15, "\u226515", x)
    ) +
    scale_y_continuous(limits = c(0, 1)) +
    labs(x="Winning margin", y = "Share of spectators", title="All to winner")
  
  
  
  
  bottom_df  <-  mmw2018 |> mutate(share_to_winner = y2/e2,
                               winning_margin = x2-x1,
                               winning_margin = if_else(winning_margin >=15, 15, winning_margin)) |>
    filter(treatment!="Base") |>
    group_by(winning_margin) |>
    summarize(mean_winner = mean(share_to_winner),
              se_winner = sd(share_to_winner)/sqrt(n()))
  
  bottom <- bottom_df |>
    ggplot(aes(x = winning_margin, y = mean_winner, 
               ymin = mean_winner-se_winner, ymax=mean_winner+se_winner)) +
    geom_point() +
    geom_errorbar(width=0.4) +
    geom_line() +
    theme_minimal() +
    scale_x_continuous(
      breaks = 0:15,
      labels = function(x) ifelse(x == 15, "\u226515", x)
    ) +
    scale_y_continuous(limits = c(0.5, 1)) +
    labs(x="Winning margin", y = "Share of income", title="Share to winner")
  list("top"=top, "bottom"=bottom)
  
  
  
  
}


het11 <- function(mmw2018) {
  f4df1 <- mmw2018 |>
    mutate(
      republican = ifelse(pol2==1,"Republican","Nonrepublican"),
      college = ifelse(education>4, "College", "Noncollege"),
      male = ifelse(sex==1, "Male", "Female"),
      above_median_age = ifelse(age>=median(age), "Old", "Young"),
      all_to_winner = as.numeric(y2==e2),
      share_to_winner = y2/e2
    ) |> filter(treatment!="Base")
  lvls <- rev(c("Republican","Nonrepublican","College", "Noncollege","Male","Female","Young","Old"))
  r1 <- f4df1 |> group_by(republican) |> summarize(maw = mean(all_to_winner),
                                                   maw_se = sd(all_to_winner)/sqrt(n())) |> rename(group=republican)
  r2 <- f4df1 |> group_by(college) |> summarize(maw = mean(all_to_winner),
                                                maw_se = sd(all_to_winner)/sqrt(n())) |> rename(group=college)
  r3 <- f4df1 |> group_by(male) |> summarize(maw = mean(all_to_winner),
                                             maw_se = sd(all_to_winner)/sqrt(n())) |> rename(group = male)
  r4 <- f4df1 |> group_by(above_median_age) |> summarize(maw = mean(all_to_winner),
                                                         maw_se = sd(all_to_winner)/sqrt(n())) |> rename(group = above_median_age)
  g11df <- list(r1,r2,r3,r4) |> bind_rows() |> mutate(groupf = factor(group, levels=lvls))
  g11 <- g11df |> ggplot(aes(x=groupf, y = maw, ymin = maw - maw_se, ymax = maw + maw_se)) + 
    geom_col() + 
    geom_errorbar(width=0.5) +
    theme_minimal() + 
    coord_flip() + 
    labs(y="Share of spectators \u00B1 SE", 
         x=element_blank(),
         title="All to winner") +
    theme(plot.title.position = "plot")
  rs1 <- f4df1 |> group_by(republican) |> summarize(maw = mean(share_to_winner),
                                                    maw_se = sd(all_to_winner)/sqrt(n())) |> rename(group=republican)
  rs2 <- f4df1 |> group_by(college) |> summarize(maw = mean(share_to_winner),
                                                 maw_se = sd(all_to_winner)/sqrt(n())) |> rename(group=college)
  rs3 <- f4df1 |> group_by(male) |> summarize(maw = mean(share_to_winner),
                                              maw_se = sd(all_to_winner)/sqrt(n())) |> rename(group = male)
  rs4 <- f4df1 |> group_by(above_median_age) |> summarize(maw = mean(share_to_winner),
                                                          maw_se = sd(all_to_winner)/sqrt(n())) |> rename(group = above_median_age)
  h11df <- list(rs1,rs2,rs3,rs4) |> bind_rows() |> mutate(groupf = factor(group, levels=lvls))
  h11 <- h11df |> ggplot(aes(x=groupf, y = maw, ymin = maw - maw_se, ymax = maw + maw_se)) + 
    geom_col() + 
    geom_errorbar(width=0.5) + 
    theme_minimal() + 
    coord_flip() + 
    labs(y="Share to winner \u00B1 SE", 
         x=element_blank(),
         title="Share to winner") +
    theme(plot.title.position = "plot")
  list("all"=g11, "share"=h11)
}

het12 <- function(mmw2018) {
  f4df2 <- mmw2018 |> mutate(wta = as.numeric(treatment!="Base")) |>
    mutate(
      republican = ifelse(pol2==1,"Republican","Nonrepublican"),
      college = ifelse(education>4, "College", "Noncollege"),
      male = ifelse(sex==1, "Male", "Female"),
      above_median_age = ifelse(age>=median(age), "Old", "Young"),
      all_to_winner = as.numeric(y2==e2),
      share_to_winner = y2/e2,
      margin = x2-x1
    ) 
  lvls <- rev(c("Republican","Nonrepublican","College", "Noncollege","Male","Female","Young","Old"))
  k1 <- f4df2 |> filter(republican=="Republican") |> lm(all_to_winner ~ wta, data=_) |> broom::tidy() |> mutate(group="Republican")
  k2 <- f4df2 |> filter(republican=="Nonrepublican") |> lm(all_to_winner ~ wta, data=_) |> broom::tidy() |> mutate(group="Nonrepublican")
  k3 <- f4df2 |> filter(college=="College") |> lm(all_to_winner ~ wta, data=_) |> broom::tidy() |> mutate(group="College")
  k4 <- f4df2 |> filter(college=="Noncollege") |> lm(all_to_winner ~ wta, data=_) |> broom::tidy() |> mutate(group="Noncollege")
  k5 <- f4df2 |> filter(male=="Male") |> lm(all_to_winner ~ wta, data=_) |> broom::tidy() |> mutate(group="Male")
  k6 <- f4df2 |> filter(male=="Female") |> lm(all_to_winner ~ wta, data=_) |> broom::tidy() |> mutate(group="Female")
  k7 <- f4df2 |> filter(above_median_age=="Young") |> lm(all_to_winner ~ wta, data=_) |> broom::tidy() |> mutate(group="Young")
  k8 <- f4df2 |> filter(above_median_age=="Old") |> lm(all_to_winner ~ wta, data=_) |> broom::tidy() |> mutate(group="Old")
  g12df <- list(k1,k2,k3,k4,k5,k6,k7,k8) |> bind_rows() |> mutate(groupf = factor(group, levels=lvls)) |>
    filter(term=="wta") 
  g12 <- g12df |> ggplot(aes(x=groupf, y = estimate, ymin=estimate - std.error, ymax=estimate+std.error)) +
    geom_point() +
    geom_errorbar(width=0.4) +
    geom_hline(yintercept = 0) +
    scale_y_continuous(limits = c(-0.1, 0.3)) +
    coord_flip() +
    theme_minimal() +
    labs(title="WTA competition vs. Luck",
         y = "Estimate \u00B1 SE",
         x = element_blank()) +
    theme(plot.title.position = "plot")
  ks1 <- f4df2 |> filter(republican=="Republican") |> lm(share_to_winner ~ wta, data=_) |> broom::tidy() |> mutate(group="Republican")
  ks2 <- f4df2 |> filter(republican=="Nonrepublican") |> lm(share_to_winner ~ wta, data=_) |> broom::tidy() |> mutate(group="Nonrepublican")
  ks3 <- f4df2 |> filter(college=="College") |> lm(share_to_winner ~ wta, data=_) |> broom::tidy() |> mutate(group="College")
  ks4 <- f4df2 |> filter(college=="Noncollege") |> lm(share_to_winner ~ wta, data=_) |> broom::tidy() |> mutate(group="Noncollege")
  ks5 <- f4df2 |> filter(male=="Male") |> lm(share_to_winner ~ wta, data=_) |> broom::tidy() |> mutate(group="Male")
  ks6 <- f4df2 |> filter(male=="Female") |> lm(share_to_winner ~ wta, data=_) |> broom::tidy() |> mutate(group="Female")
  ks7 <- f4df2 |> filter(above_median_age=="Young") |> lm(share_to_winner ~ wta, data=_) |> broom::tidy() |> mutate(group="Young")
  ks8 <- f4df2 |> filter(above_median_age=="Old") |> lm(share_to_winner ~ wta, data=_) |> broom::tidy() |> mutate(group="Old")
  h12df <- list(ks1,ks2,ks3,ks4,ks5,ks6,ks7,ks8) |> bind_rows() |> mutate(groupf = factor(group, levels=lvls)) |>
    filter(term=="wta") 
  h12 <- h12df |> ggplot(aes(x=groupf, y = estimate, ymin=estimate - std.error, ymax=estimate+std.error)) +
    geom_point() +
    geom_errorbar(width=0.4) +
    geom_hline(yintercept = 0) +
    scale_y_continuous(limits = c(-0.1, 0.3)) +
    coord_flip() +
    theme_minimal() +
    labs(title="WTA competition vs. Luck",
         y = "Estimate \u00B1 SE",
         x = element_blank()) +
    theme(plot.title.position = "plot")
  h12
  list("all"=g12,"share"=h12)
}


het21 <- function(mmw2018) {
  f4df3 <- mmw2018 |> mutate(wta = as.numeric(treatment!="Base")) |>
    mutate(
      republican = ifelse(pol2==1,"Republican","Nonrepublican"),
      college = ifelse(education>4, "College", "Noncollege"),
      male = ifelse(sex==1, "Male", "Female"),
      above_median_age = ifelse(age>=median(age), "Old", "Young"),
      all_to_winner = as.numeric(y2==e2),
      share_to_winner = y2/e2
    ) |> filter(x2-x1 ==1 | is.na(x2))
  lvls <- rev(c("Republican","Nonrepublican", "College", "Noncollege","Male","Female","Young","Old"))
  l1 <- f4df3 |> filter(republican=="Republican") |> lm(all_to_winner ~ wta, data=_) |> broom::tidy() |> mutate(group="Republican")
  l2 <- f4df3 |> filter(republican=="Nonrepublican") |> lm(all_to_winner ~ wta, data=_) |> broom::tidy() |> mutate(group="Nonrepublican")
  l3 <- f4df3 |> filter(college=="College") |> lm(all_to_winner ~ wta, data=_) |> broom::tidy() |> mutate(group="College")
  l4 <- f4df3 |> filter(college=="Noncollege") |> lm(all_to_winner ~ wta, data=_) |> broom::tidy() |> mutate(group="Noncollege")
  l5 <- f4df3 |> filter(male=="Male") |> lm(all_to_winner ~ wta, data=_) |> broom::tidy() |> mutate(group="Male")
  l6 <- f4df3 |> filter(male=="Female") |> lm(all_to_winner ~ wta, data=_) |> broom::tidy() |> mutate(group="Female")
  l7 <- f4df3 |> filter(above_median_age=="Young") |> lm(all_to_winner ~ wta, data=_) |> broom::tidy() |> mutate(group="Young")
  l8 <- f4df3 |> filter(above_median_age=="Old") |> lm(all_to_winner ~ wta, data=_) |> broom::tidy() |> mutate(group="Old")

  
    g21df <- list(l1,l2,l3,l4,l5,l6,l7,l8) |> bind_rows() |> mutate(groupf = factor(group, levels=lvls)) |>
    filter(term=="wta") 
  g21 <- g21df |> ggplot(aes(x=groupf, y = estimate, ymin=estimate - std.error, ymax=estimate+std.error)) +
    geom_point() +
    geom_errorbar(width=0.4) +
    geom_hline(yintercept = 0) +
    scale_y_continuous(limits = c(-0.1, 0.3)) +
    coord_flip() +
    theme_minimal() +
    labs(title="WTA comp. vs. Luck (minimal margin)",
         y = "Estimate \u00B1 SE",
         x = element_blank()) +
    theme(plot.title.position = "plot")

  ls1 <- f4df3 |> filter(republican=="Republican") |> lm(share_to_winner ~ wta, data=_) |> broom::tidy() |> mutate(group="Republican")
  ls2 <- f4df3 |> filter(republican=="Nonrepublican") |> lm(share_to_winner ~ wta, data=_) |> broom::tidy() |> mutate(group="Nonrepublican")
  ls3 <- f4df3 |> filter(college=="College") |> lm(share_to_winner ~ wta, data=_) |> broom::tidy() |> mutate(group="College")
  ls4 <- f4df3 |> filter(college=="Noncollege") |> lm(share_to_winner ~ wta, data=_) |> broom::tidy() |> mutate(group="Noncollege")
  ls5 <- f4df3 |> filter(male=="Male") |> lm(share_to_winner ~ wta, data=_) |> broom::tidy() |> mutate(group="Male")
  ls6 <- f4df3 |> filter(male=="Female") |> lm(share_to_winner ~ wta, data=_) |> broom::tidy() |> mutate(group="Female")
  ls7 <- f4df3 |> filter(above_median_age=="Young") |> lm(share_to_winner ~ wta, data=_) |> broom::tidy() |> mutate(group="Young")
  ls8 <- f4df3 |> filter(above_median_age=="Old") |> lm(share_to_winner ~ wta, data=_) |> broom::tidy() |> mutate(group="Old")
  h21df <- list(ls1,ls2,ls3,ls4,ls5,ls6,ls7,ls8) |> bind_rows() |> mutate(groupf = factor(group, levels=lvls)) |>
    filter(term=="wta") 
  h21 <- h21df |> ggplot(aes(x=groupf, y = estimate, ymin=estimate - std.error, ymax=estimate+std.error)) +
    geom_point() +
    geom_errorbar(width=0.4) +
    geom_hline(yintercept = 0) +
    scale_y_continuous(limits = c(-0.1, 0.3)) +
    coord_flip() +
    theme_minimal() +
    labs(title="WTA comp. vs. Luck (minimal margin)",
         y = "Estimate \u00B1 SE",
         x = element_blank()) +
    theme(plot.title.position = "plot")
 
  list("all"=g21, "share"=h21)
 
}

het22 <- function(mmw2018) {
  f4df2 <- mmw2018 |> mutate(wta = as.numeric(treatment!="Base")) |>
    mutate(
      republican = ifelse(pol2==1,"Republican","Nonrepublican"),
      college = ifelse(education>4, "College", "Noncollege"),
      male = ifelse(sex==1, "Male", "Female"),
      above_median_age = ifelse(age>=median(age), "Old", "Young"),
      all_to_winner = as.numeric(y2==e2),
      share_to_winner = y2/e2,
      margin = x2-x1
    ) 
  lvls <- rev(c("Republican","Nonrepublican","College", "Noncollege","Male","Female","Young","Old"))
  m1 <- f4df2 |> filter(republican=="Republican") |> lm(all_to_winner ~ margin, data=_) |> broom::tidy() |> mutate(group="Republican")
  m2 <- f4df2 |> filter(republican=="Nonrepublican") |> lm(all_to_winner ~ margin, data=_) |> broom::tidy() |> mutate(group="Nonrepublican")
  m3 <- f4df2 |> filter(college=="College") |> lm(all_to_winner ~ margin, data=_) |> broom::tidy() |> mutate(group="College")
  m4 <- f4df2 |> filter(college=="Noncollege") |> lm(all_to_winner ~ margin, data=_) |> broom::tidy() |> mutate(group="Noncollege")
  m5 <- f4df2 |> filter(male=="Male") |> lm(all_to_winner ~ margin, data=_) |> broom::tidy() |> mutate(group="Male")
  m6 <- f4df2 |> filter(male=="Female") |> lm(all_to_winner ~ margin, data=_) |> broom::tidy() |> mutate(group="Female")
  m7 <- f4df2 |> filter(above_median_age=="Young") |> lm(all_to_winner ~ margin, data=_) |> broom::tidy() |> mutate(group="Young")
  m8 <- f4df2 |> filter(above_median_age=="Old") |> lm(all_to_winner ~ margin, data=_) |> broom::tidy() |> mutate(group="Old")
  g22df <- list(m1,m2,m3,m4,m5,m6,m7,m8) |> bind_rows() |> mutate(groupf = factor(group, levels=lvls)) |>
    filter(term=="margin") 
  g22 <- g22df |> ggplot(aes(x=groupf, y = estimate, ymin=estimate - std.error, ymax=estimate+std.error)) +
    geom_point() +
    geom_errorbar(width=0.4) +
    geom_hline(yintercept = 0) +
    scale_y_continuous(limits = c(-0.01, 0.03)) +
    coord_flip() +
    theme_minimal() +
    labs(title="Effect of winning margin",
         y = "Estimate \u00B1 SE",
         x = element_blank()) +
    theme(plot.title.position = "plot")

  ms1 <- f4df2 |> filter(republican=="Republican") |> lm(share_to_winner ~ margin, data=_) |> broom::tidy() |> mutate(group="Republican")
  ms2 <- f4df2 |> filter(republican=="Nonrepublican") |> lm(share_to_winner ~ margin, data=_) |> broom::tidy() |> mutate(group="Nonrepublican")
  ms3 <- f4df2 |> filter(college=="College") |> lm(share_to_winner ~ margin, data=_) |> broom::tidy() |> mutate(group="College")
  ms4 <- f4df2 |> filter(college=="Noncollege") |> lm(share_to_winner ~ margin, data=_) |> broom::tidy() |> mutate(group="Noncollege")
  ms5 <- f4df2 |> filter(male=="Male") |> lm(share_to_winner ~ margin, data=_) |> broom::tidy() |> mutate(group="Male")
  ms6 <- f4df2 |> filter(male=="Female") |> lm(share_to_winner ~ margin, data=_) |> broom::tidy() |> mutate(group="Female")
  ms7 <- f4df2 |> filter(above_median_age=="Young") |> lm(share_to_winner ~ margin, data=_) |> broom::tidy() |> mutate(group="Young")
  ms8 <- f4df2 |> filter(above_median_age=="Old") |> lm(share_to_winner ~ margin, data=_) |> broom::tidy() |> mutate(group="Old")
  h22df <- list(ms1,ms2,ms3,ms4,ms5,ms6,ms7,ms8) |> bind_rows() |> mutate(groupf = factor(group, levels=lvls)) |>
    filter(term=="margin") 
  h22 <- h22df |> ggplot(aes(x=groupf, y = estimate, ymin=estimate - std.error, ymax=estimate+std.error)) +
    geom_point() +
    geom_errorbar(width=0.4) +
    geom_hline(yintercept = 0) +
    scale_y_continuous(limits = c(-0.01, 0.03)) +
    coord_flip() +
    theme_minimal() +
    labs(title="Effect of winning margin",
         y = "Estimate \u00B1 SE",
         x = element_blank()) +
    theme(plot.title.position = "plot")

  list("all"=g22, "share"=h22)
}

heterogeneity_figure_all_to_winner_lg <- function(mmw2018)  {
  list("g11" = het11(mmw2018)$all,
       "g12" = het12(mmw2018)$all,
       "g21" = het21(mmw2018)$all,
       "g22" = het22(mmw2018)$all)
}

heterogeneity_figure_share_lg <- function(mmw2018)  {
  list("g11" = het11(mmw2018)$share,
       "g12" = het12(mmw2018)$share,
       "g21" = het21(mmw2018)$share,
       "g22" = het22(mmw2018)$share)
}

treatment_names_translate <- function(x) {
    stopifnot(is.character(x), length(x) == 1)
    lookup <- c(
      "WTA: No Choice" = "WTA-No Choice",
      "WTA: No Exp"   = "WTA-No Exp",
      "WTA" = "WTA",
      "Base"= "Luck"
    )
    if (x %in% names(lookup)) lookup[[x]] else x
}

treatments_heterogeneities <- function(mmw2018, treatments, outcome) {
  lvls <- rev(c("Republican","Nonrepublican","College", "Noncollege","Male","Female","Young","Old"))
  sample <- mmw2018 |> 
    filter(treatment %in% treatments) |>
    mutate(treat = as.numeric( treatment == treatments[2])) |>
  mutate(
    republican = ifelse(pol2==1,"Republican","Nonrepublican"),
    college = ifelse(education>4, "College", "Noncollege"),
    male = ifelse(sex==1, "Male", "Female"),
    above_median_age = ifelse(age>=median(age), "Old", "Young"),
    all_to_winner = as.numeric(y2==e2),
    share_to_winner = y2/e2,
    margin = x2-x1
  )
  if (outcome=="share") {
    sample <- sample |> mutate(y = share_to_winner)
    subt <- "Share to winner"
  } else {
    sample <- sample |> mutate(y = all_to_winner)
    subt <- "All to winner"
  }
  ms1 <- sample |> filter(republican=="Republican") |> lm(y ~ treat, data=_) |> broom::tidy() |> mutate(group="Republican")
  ms2 <- sample |> filter(republican=="Nonrepublican") |> lm(y ~ treat, data=_) |> broom::tidy() |> mutate(group="Nonrepublican")
  ms3 <- sample |> filter(college=="College") |> lm(y ~ treat, data=_) |> broom::tidy() |> mutate(group="College")
  ms4 <- sample |> filter(college=="Noncollege") |> lm(y ~ treat, data=_) |> broom::tidy() |> mutate(group="Noncollege")
  ms5 <- sample |> filter(male=="Male") |> lm(y ~ treat, data=_) |> broom::tidy() |> mutate(group="Male")
  ms6 <- sample |> filter(male=="Female") |> lm(y ~ treat, data=_) |> broom::tidy() |> mutate(group="Female")
  ms7 <- sample |> filter(above_median_age=="Young") |> lm(y ~ treat, data=_) |> broom::tidy() |> mutate(group="Young")
  ms8 <- sample |> filter(above_median_age=="Old") |> lm(y ~ treat, data=_) |> broom::tidy() |> mutate(group="Old")
  elist <- list(ms1,ms2,ms3,ms4,ms5,ms6,ms7,ms8) |> 
    bind_rows() |> 
    mutate(groupf = factor(group, levels=lvls)) |>
    filter(term=="treat") 
  treatment_string <- paste( treatment_names_translate(treatments[2]), "vs." , treatment_names_translate(treatments[1]))
  elist |> ggplot(aes(x=groupf, y = estimate, ymin=estimate - std.error, ymax=estimate+std.error)) +
    geom_point() +
    geom_errorbar(width=0.4) +
    geom_hline(yintercept = 0) + 
    scale_y_continuous(limits = c(-0.09, 0.05)) +
    coord_flip() +
    theme_minimal() +
    labs(title=treatment_string,
         subtitle = subt,
         y = "Estimate \u00B1 SE",
         x = element_blank()) +
    theme(plot.title.position = "plot")
}

heterogeneous_subtreatment_effects <- function(mmw2018) {
  g11 <- treatments_heterogeneities(mmw2018, c("WTA", "WTA: No Choice"), "all")
  g12 <- treatments_heterogeneities(mmw2018, c("WTA", "WTA: No Choice"), "share")
  g21 <- treatments_heterogeneities(mmw2018, c("WTA", "WTA: No Exp"), "all")
  g22 <- treatments_heterogeneities(mmw2018, c("WTA", "WTA: No Exp"), "share")
  
  list("g11"=g11,
       "g12"=g12,
       "g21"=g21,
       "g22"=g22)
}

    



qresponse1 <- function(mmw2018) {
  n1 <- mmw2018 |> 
    mutate(att3r = 8-att3) |>
    group_by(att3r = factor(att3r)) |>
    summarize(fraction = n()/nrow(mmw2018)) |>
    ggplot(aes(x=att3r, y = fraction)) +
    geom_col() + 
    theme_minimal() +
    labs(x = element_blank(),
         y = "Share",
         title="Gold medalist's earnings") +
    theme(plot.title.position = "plot",
          axis.text.x = element_text(angle = 45, hjust = 1),
          plot.title = element_text(size = 8)) +
    scale_x_discrete( labels = c("Entirely unfair", "", "", "", "", "", "Entirely fair"))
  n1
}

qresponse2 <- function(mmw2018) {
  n2 <- mmw2018 |> 
    mutate(att4r = 8-att4) |>
    group_by(att4r = factor(att4r)) |>
    summarize(fraction = n()/nrow(mmw2018)) |>
    ggplot(aes(x=att4r, y = fraction)) +
    geom_col() + 
    theme_minimal() +
    labs(x = element_blank(),
         y = "Share",
         title="Earnings of superstars acceptable") +
    theme(plot.title.position = "plot",
          axis.text.x = element_text(angle = 45, hjust = 1),
          plot.title = element_text(size = 8))   +
    scale_x_discrete( labels = c("Fully disagree", "", "", "", "", "", "Fully agree"))
  n2
}

qresponse3 <- function(mmw2018) {
  n3 <- mmw2018 |> 
    group_by(att2 = factor(att2)) |>
    summarize(fraction = n()/nrow(mmw2018)) |>
    ggplot(aes(x=att2, y = fraction)) +
    geom_col() + 
    theme_minimal() +
    labs(x = element_blank(),
         y = "Share",
         title="Taxes on top 1% should") +
    theme(plot.title.position = "plot",
          axis.text.x = element_text(angle = 45, hjust = 1),
          plot.title = element_text(size = 8))  +
    scale_x_discrete( labels = c("Increase","Stay the same","Decrease"))
  n3
}

question_responses_lg <- function(mmw2018) {
    list("a"=qresponse1(mmw2018),
       "b"=qresponse2(mmw2018),
       "c"=qresponse3(mmw2018))
}



distribution_of_performance_by_treatment_lg <- function(mmw2018) {
  tdf <- mmw2018 |> 
    filter(treatment!="Base") |>
    mutate(treatment = make_labels(treatment))
  all_x <- c(tdf$x1, tdf$x2)
  treatment <- c(tdf$treatment, tdf$treatment)
  distdfs1 <- tibble(all_x=all_x,
                     treatment = treatment)
  
  l11 <- distdfs1 |> 
    ggplot(aes(x=all_x)) +
    geom_histogram(aes(y = after_stat(density)),
                   binwidth = 1, 
                   boundary = -0.5,  
    ) +
    scale_x_continuous(breaks = c(0,5,10,15,20,25), limits = c(-0.5, 24.5)) +
    labs(
      x = "Performance of worker",
      y = "Share",
      title = "All WTA treatments"
    ) +
    theme_minimal() +
    theme(plot.title.position = "plot")
  l12 <- distdfs1 |> filter(treatment=="WTA") |>
    ggplot(aes(x=all_x)) +
    geom_histogram(aes(y = after_stat(density)),
                   binwidth = 1, 
                   boundary = -0.5,  
    ) +
    scale_x_continuous(breaks = c(0,5,10,15,20,25), limits = c(-0.5, 24.5)) +
    labs(
      x = "Performance of worker",
      y = "Share",
      title = "WTA",
    ) +
    theme_minimal() +
    theme(plot.title.position = "plot")
  l21 <- distdfs1 |> filter(treatment=="WTA–No Choice") |>
    ggplot(aes(x=all_x)) +
    geom_histogram(aes(y = after_stat(density)),
                   binwidth = 1, 
                   boundary = -0.5,  
    ) +
    scale_x_continuous(breaks = c(0,5,10,15,20,25), limits = c(-0.5, 24.5)) +
    labs(
      x = "Performance of worker",
      y = "Share",
      title = "WTA-No Choice",
    ) +
    theme_minimal() +
    theme(plot.title.position = "plot")
  l22 <- distdfs1 |> filter(treatment=="WTA–No Expectations") |>
    ggplot(aes(x=all_x)) +
    geom_histogram(aes(y = after_stat(density)),
                   binwidth = 1, 
                   boundary = -0.5,  
    ) +
    scale_x_continuous(breaks = c(0,5,10,15,20,25), limits = c(-0.5, 24.5)) +
    labs(
      x = "Performance of worker",
      y = "Share",
      title = "WTA-No Expectations",
    ) +
    theme_minimal() +
    theme(plot.title.position = "plot")
  list("a"=l11, "b"=l12, "c"=l21, "d"=l22)
}

distribution_of_winning_margin_by_treatment_lg <- function(mmw2018) {
  tdf <- mmw2018 |> 
    filter(treatment!="Base") |>
    mutate(treatment = make_labels(treatment))
  winning_margin <- tdf$x2 - tdf$x1
  distdfs2 <- tibble(winning_margin=winning_margin,
                     treatment = tdf$treatment)
  m11 <- distdfs2 |> 
    ggplot(aes(x=winning_margin)) +
    geom_histogram(aes(y = after_stat(density)),
                   binwidth = 1, 
                   boundary = -0.5,  
    ) +
    scale_x_continuous(breaks = c(0,5,10,15,20), limits = c(-0.5, 21.5)) +
    labs(
      x = "Winning margin",
      y = "Share",
      title = "All WTA treatments"
    ) +
    theme_minimal() +
    theme(plot.title.position = "plot")
  m12 <- distdfs2 |> filter(treatment=="WTA") |>
    ggplot(aes(x=winning_margin)) +
    geom_histogram(aes(y = after_stat(density)),
                   binwidth = 1, 
                   boundary = -0.5,  
    ) +
    scale_x_continuous(breaks = c(0,5,10,15,20), limits = c(-0.5, 21.5)) +
    labs(
      x = "Winning margin",
      y = "Share",
      title = "WTA"
    ) +
    theme_minimal() +
    theme(plot.title.position = "plot")
  m21 <- distdfs2 |> filter(treatment=="WTA–No Choice") |>
    ggplot(aes(x=winning_margin)) +
    geom_histogram(aes(y = after_stat(density)),
                   binwidth = 1, 
                   boundary = -0.5,  
    ) +
    scale_x_continuous(breaks = c(0,5,10,15,20), limits = c(-0.5, 21.5)) +
    labs(
      x = "Winning margin",
      y = "Share",
      title = "WTA-No Choice"
    ) +
    theme_minimal() +
    theme(plot.title.position = "plot")
  m22 <- distdfs2 |> filter(treatment=="WTA–No Expectations") |>
    ggplot(aes(x=winning_margin)) +
    geom_histogram(aes(y = after_stat(density)),
                   binwidth = 1, 
                   boundary = -0.5,  
    ) +
    scale_x_continuous(breaks = c(0,5,10,15,20), limits = c(-0.5, 21.5)) +
    labs(
      x = "Winning margin",
      y = "Share",
      title = "WTA-No Expectations"
    ) +
    theme_minimal() +
    theme(plot.title.position = "plot")
  list("a"=m11, "b"=m12, "c"=m21, "d"=m22)
}

flatness_all_to_winner_g <- function(mmw2018) {
  mmw2018 |> 
    mutate(all_to_winner = as.numeric(y2==e2),
           winning_margin = x2-x1,
           winning_margin = if_else(winning_margin >=15, 15, winning_margin)) |>
    filter(treatment!="Base") |>
    mutate(treatment = make_labels(treatment)) |>
    group_by(treatment, winning_margin) |>
    summarize(mean_winner = mean(all_to_winner),
              se_winner = sd(all_to_winner)/sqrt(n())) |>
    ggplot(aes(x = winning_margin, y = mean_winner, ymin = mean_winner-se_winner, ymax=mean_winner+se_winner)) +
    geom_point() +
    geom_errorbar(width=0.4) +
    geom_line() +
    theme_minimal() +
    scale_x_continuous(
      breaks = 0:15,
      labels = function(x) ifelse(x == 15, "\u226515", x)
    ) +
    scale_y_continuous(limits = c(0, 1)) +
    labs(x="Winning margin", y = "Share allocating all to winner \u00B1 SE") +
    facet_wrap(.~treatment, ncol=1)
}

flatness_share_to_winner_g <- function(mmw2018) {
  mmw2018 |> 
    mutate(share_to_winner = y2/e2,
           winning_margin = x2-x1,
           winning_margin = if_else(winning_margin >=15, 15, winning_margin)) |>
    filter(treatment!="Base") |>
    mutate(treatment = make_labels(treatment)) |>
    group_by(treatment, winning_margin) |>
    summarize(mean_winner = mean(share_to_winner),
              se_winner = sd(share_to_winner)/sqrt(n())) |>
    ggplot(aes(x = winning_margin, y = mean_winner, 
               ymin = mean_winner-se_winner, ymax=mean_winner+se_winner)) +
    geom_point() +
    geom_errorbar(width=0.4) +
    geom_line() +
    theme_minimal() +
    scale_x_continuous(
      breaks = 0:15,
      labels = function(x) ifelse(x == 15, "\u226515", x)
    ) +
    scale_y_continuous(limits = c(0.45, 1)) +
    labs(x="Winning margin", y = "Share allocated to winner \u00B1 SE") +
    facet_wrap(.~treatment, ncol=1)
}

distributions_performance_and_margin_lg <- function(mmw2025) {
  tabledf <- mmw2025 |> 
    mutate(all_to_winner = as.numeric(y2==e2),
           share_to_winner = y2/(y1+y2),
           winning_margin = x2-x1,
           republican = as.numeric(pol2==1),
           college = as.numeric(education>4),
           female = as.numeric(sex==2),
           above_median_age = as.numeric(age > median(age)),
           regionf = factor(region),
           treatmentf = relevel(factor(treatment), ref = "baseline"))
  
  all_x <- c(tabledf$x1, tabledf$x2)
  distdfs1 <- tibble(all_x=all_x)
  winning_margin <- tabledf$x2 - tabledf$x1
  distdfs2 <- tibble(winning_margin=winning_margin)
  
  wm_2025 <- distdfs2 |>
    ggplot(aes(x=winning_margin)) +
    geom_histogram( aes(y = after_stat(density)),
                    binwidth = 1, 
                    boundary = -0.5,  
    ) +
    scale_x_continuous(breaks = c(0,5,10,15,20), limits = c(0.5, 21.5)) +
    labs(
      x = "Winning margin",
      y = "Share",
    ) +
    theme_minimal()
  
  h_workers_2025 <- distdfs1 |> 
    ggplot(aes(x=all_x)) +
    geom_histogram(aes(y = after_stat(density)),
                   binwidth = 1, 
                   boundary = -0.5,  
    ) +
    scale_x_continuous(breaks = c(0,5,10,15,20,25), limits = c(-0.5, 24.5)) +
    labs(
      x = "Performance of worker",
      y = "Share",
    ) +
    theme_minimal()
  
  list("a"=h_workers_2025, "b"=wm_2025)  
}

restricted_main_l <- function(mmw2018r) {
  tabledf <- mmw2018r |>
    mutate(all_to_winner = as.numeric(y2==e2),
           share_to_winner = y2/(y1+y2),
           winning_margin = x2-x1,
           republican = as.numeric(pol2==1),
           college = as.numeric(education>4),
           female = as.numeric(sex==2),
           above_median_age = as.numeric(age > median(age)),
           regionf = factor(area),
           treatmentf = relevel(factor(treatment), ref = "Base"),
           competition = as.numeric(treatment!="Base"))
  
  c1 <- tabledf |> filter(treatment!="Base") |> feols(all_to_winner ~ treatment , data=_, vcov="hetero")
  c2 <- tabledf |> feols(all_to_winner ~ competition + republican + college + female + above_median_age | regionf, data=_, vcov="hetero")
  c3 <- tabledf |> filter(treatment!="Base") |> feols(all_to_winner ~ winning_margin + republican + college + female + above_median_age | regionf, data=_, vcov="hetero")
  c4 <- tabledf |> filter(treatment!="Base") |> feols(share_to_winner ~ treatment , data=_, vcov="hetero")
  c5 <- tabledf |> feols(share_to_winner ~ competition + republican + college + female + above_median_age | regionf, data=_, vcov="hetero")
  c6 <- tabledf |> filter(treatment!="Base") |> feols(share_to_winner ~ winning_margin + republican + college + female + above_median_age | regionf, data=_, vcov="hetero")
  list(c1,c2,c3,c4,c5,c6)
}

heterogeneous_treatment_effects_all_ll <- function(mmw2018) {
  tabledf <- mmw2018 |>
    mutate(all_to_winner = as.numeric(y2==e2),
           share_to_winner = y2/(y1+y2),
           competition = as.numeric(treatment!="Base"),
           winning_margin = x2-x1,
           republican = as.numeric(pol2==1),
           college = as.numeric(education>4),
           female = as.numeric(sex==2),
           above_median_age = as.numeric(age > median(age)),
           regionf = factor(area),
           performance_winner = x2,
           treatment = fct_relevel(treatment, "WTA")
    )
  q1 <- tabledf |> feols(all_to_winner ~ competition*republican + college + female + above_median_age | regionf , data=_, vcov="hetero")
  me_q1 <- slopes(q1, variables = "competition", by = "republican")
  c1 = c(
    sprintf("%.3f", tidy(me_q1)$estimate[2]),
    sprintf("(%.3f)", tidy(me_q1)$std.error[2])
  )
  q2 <- tabledf |> feols(all_to_winner ~ republican + competition*college + female + above_median_age | regionf , data=_, vcov="hetero")
  me_q2 <- slopes(q2, variables = "competition", by = "college")
  c2 = c(
    sprintf("%.3f", tidy(me_q2)$estimate[2]),
    sprintf("(%.3f)", tidy(me_q2)$std.error[2])
  )
  q3 <- tabledf |> feols(all_to_winner ~ republican + college + competition*female + above_median_age | regionf , data=_, vcov="hetero")
  me_q3 <- slopes(q3, variables = "competition", by = "female")
  c3 = c(
    sprintf("%.3f", tidy(me_q3)$estimate[2]),
    sprintf("(%.3f)", tidy(me_q3)$std.error[2])
  ) 
  q4 <- tabledf |> feols(all_to_winner ~ republican + college + female + competition*above_median_age | regionf , data=_, vcov="hetero")
  me_q4 <- slopes(q4, variables = "competition", by = "above_median_age")
  c4 = c(
    sprintf("%.3f", tidy(me_q4)$estimate[2]),
    sprintf("(%.3f)", tidy(me_q4)$std.error[2])
  ) 
  
  q5 <- tabledf |> filter(winning_margin==1 | treatment=="Base") |> feols(all_to_winner ~ competition*republican + college + female + above_median_age | regionf , data=_, vcov="hetero")
  me_q5 <- slopes(q5, variables = "competition", by = "republican")
  c5 = c(
    sprintf("%.3f", tidy(me_q5)$estimate[2]),
    sprintf("(%.3f)", tidy(me_q5)$std.error[2])
  )
  q6 <- tabledf |> filter(winning_margin==1 | treatment=="Base") |>feols(all_to_winner ~ republican + competition*college + female + above_median_age | regionf , data=_, vcov="hetero")
  me_q6 <- slopes(q6, variables = "competition", by = "college")
  c6 = c(
    sprintf("%.3f", tidy(me_q6)$estimate[2]),
    sprintf("(%.3f)", tidy(me_q6)$std.error[2])
  )
  q7 <- tabledf |> filter(winning_margin==1 | treatment=="Base") |>feols(all_to_winner ~ republican + college + competition*female + above_median_age | regionf , data=_, vcov="hetero")
  me_q7 <- slopes(q7, variables = "competition", by = "female")
  c7 = c(
    sprintf("%.3f", tidy(me_q7)$estimate[2]),
    sprintf("(%.3f)", tidy(me_q7)$std.error[2])
  ) 
  q8 <- tabledf |> filter(winning_margin==1 | treatment=="Base") |> feols(all_to_winner ~ republican + college + female + competition*above_median_age | regionf , data=_, vcov="hetero")
  me_q8 <- slopes(q8, variables = "competition", by = "above_median_age")
  c8 = c(
    sprintf("%.3f", tidy(me_q8)$estimate[2]),
    sprintf("(%.3f)", tidy(me_q8)$std.error[2])
  )
  extra_rows <- tibble(row_names = c("Linear combination WTA$\\times X$", ""),
                       c1=c1,c2=c2,c3=c3,c4=c4,c5=c5,c6=c6,c7=c7,c8=c8)
  regressions <- list(q1,q2,q3,q4,q5,q6,q7,q8)
  
  list("regressions"=regressions, "extra_rows"=extra_rows)
}

heterogeneous_treatment_effects_share_ll <- function(mmw2018) {
  tabledf <- mmw2018 |>
    mutate(all_to_winner = as.numeric(y2==e2),
           share_to_winner = y2/(y1+y2),
           competition = as.numeric(treatment!="Base"),
           winning_margin = x2-x1,
           republican = as.numeric(pol2==1),
           college = as.numeric(education>4),
           female = as.numeric(sex==2),
           above_median_age = as.numeric(age > median(age)),
           regionf = factor(area),
           performance_winner = x2,
           treatment = fct_relevel(treatment, "WTA")
    )
  q1 <- tabledf |> feols(share_to_winner ~ competition*republican + college + female + above_median_age | regionf , data=_, vcov="hetero")
  me_q1 <- slopes(q1, variables = "competition", by = "republican")
  c1 = c(
    sprintf("%.3f", tidy(me_q1)$estimate[2]),
    sprintf("(%.3f)", tidy(me_q1)$std.error[2])
  )
  q2 <- tabledf |> feols(share_to_winner ~ republican + competition*college + female + above_median_age | regionf , data=_, vcov="hetero")
  me_q2 <- slopes(q2, variables = "competition", by = "college")
  c2 = c(
    sprintf("%.3f", tidy(me_q2)$estimate[2]),
    sprintf("(%.3f)", tidy(me_q2)$std.error[2])
  )
  q3 <- tabledf |> feols(share_to_winner ~ republican + college + competition*female + above_median_age | regionf , data=_, vcov="hetero")
  me_q3 <- slopes(q3, variables = "competition", by = "female")
  c3 = c(
    sprintf("%.3f", tidy(me_q3)$estimate[2]),
    sprintf("(%.3f)", tidy(me_q3)$std.error[2])
  ) 
  q4 <- tabledf |> feols(share_to_winner ~ republican + college + female + competition*above_median_age | regionf , data=_, vcov="hetero")
  me_q4 <- slopes(q4, variables = "competition", by = "above_median_age")
  c4 = c(
    sprintf("%.3f", tidy(me_q4)$estimate[2]),
    sprintf("(%.3f)", tidy(me_q4)$std.error[2])
  ) 
  
  q5 <- tabledf |> filter(winning_margin==1 | treatment=="Base") |> feols(share_to_winner ~ competition*republican + college + female + above_median_age | regionf , data=_, vcov="hetero")
  me_q5 <- slopes(q5, variables = "competition", by = "republican")
  c5 = c(
    sprintf("%.3f", tidy(me_q5)$estimate[2]),
    sprintf("(%.3f)", tidy(me_q5)$std.error[2])
  )
  q6 <- tabledf |> filter(winning_margin==1 | treatment=="Base") |>feols(share_to_winner ~ republican + competition*college + female + above_median_age | regionf , data=_, vcov="hetero")
  me_q6 <- slopes(q6, variables = "competition", by = "college")
  c6 = c(
    sprintf("%.3f", tidy(me_q6)$estimate[2]),
    sprintf("(%.3f)", tidy(me_q6)$std.error[2])
  )
  q7 <- tabledf |> filter(winning_margin==1 | treatment=="Base") |>feols(share_to_winner ~ republican + college + competition*female + above_median_age | regionf , data=_, vcov="hetero")
  me_q7 <- slopes(q7, variables = "competition", by = "female")
  c7 = c(
    sprintf("%.3f", tidy(me_q7)$estimate[2]),
    sprintf("(%.3f)", tidy(me_q7)$std.error[2])
  ) 
  q8 <- tabledf |> filter(winning_margin==1 | treatment=="Base") |> feols(share_to_winner ~ republican + college + female + competition*above_median_age | regionf , data=_, vcov="hetero")
  me_q8 <- slopes(q8, variables = "competition", by = "above_median_age")
  c8 = c(
    sprintf("%.3f", tidy(me_q8)$estimate[2]),
    sprintf("(%.3f)", tidy(me_q8)$std.error[2])
  )
  extra_rows <- tibble(row_names = c("Linear combination WTA$\\times X$", ""),
                       c1=c1,c2=c2,c3=c3,c4=c4,c5=c5,c6=c6,c7=c7,c8=c8)
  
  regressions <- list(q1,q2,q3,q4,q5,q6,q7,q8)
  
  list("regressions"=regressions, 
       "extra_rows"=extra_rows)
  
}


heterogeneous_treatment_effects_wm_ll <- function(mmw2018) {
  tabledf <- mmw2018 |>
    mutate(all_to_winner = as.numeric(y2==e2),
           share_to_winner = y2/(y1+y2),
           competition = as.numeric(treatment!="Base"),
           winning_margin = x2-x1,
           republican = as.numeric(pol2==1),
           college = as.numeric(education>4),
           female = as.numeric(sex==2),
           above_median_age = as.numeric(age > median(age)),
           regionf = factor(area),
           performance_winner = x2,
           treatment = fct_relevel(treatment, "WTA")
    )
  
  r1 <- tabledf |> feols(all_to_winner ~ winning_margin*republican + college + female + above_median_age | regionf , data=_, vcov="hetero")
  me_r1 <- slopes(r1, variables = "winning_margin", by = "republican")
  c1 = c(
    sprintf("%.3f", tidy(me_r1)$estimate[2]),
    sprintf("(%.3f)", tidy(me_r1)$std.error[2])
  )
  r2 <- tabledf |> feols(all_to_winner ~ republican + winning_margin*college + female + above_median_age | regionf , data=_, vcov="hetero")
  me_r2 <- slopes(r2, variables = "winning_margin", by = "college")
  c2 = c(
    sprintf("%.3f", tidy(me_r2)$estimate[2]),
    sprintf("(%.3f)", tidy(me_r2)$std.error[2])
  ) 
  r3 <- tabledf |> feols(all_to_winner ~ republican + college + winning_margin*female + above_median_age | regionf , data=_, vcov="hetero")
  me_r3 <- slopes(r3, variables = "winning_margin", by = "female")
  c3 = c(
    sprintf("%.3f", tidy(me_r3)$estimate[2]),
    sprintf("(%.3f)", tidy(me_r3)$std.error[2])
  ) 
  r4 <- tabledf |> feols(all_to_winner ~ republican + college + female + winning_margin*above_median_age | regionf , data=_, vcov="hetero")
  me_r4 <- slopes(r4, variables = "winning_margin", by = "above_median_age")
  c4 = c(
    sprintf("%.3f", tidy(me_r4)$estimate[2]),
    sprintf("(%.3f)", tidy(me_r4)$std.error[2])
  ) 
  r5 <- tabledf |> feols(share_to_winner ~ winning_margin*republican + college + female + above_median_age | regionf , data=_, vcov="hetero")
  me_r5 <- slopes(r5, variables = "winning_margin", by = "republican")
  c5 = c(
    sprintf("%.3f", tidy(me_r5)$estimate[2]),
    sprintf("(%.3f)", tidy(me_r5)$std.error[2])
  )
  r6 <- tabledf |> feols(share_to_winner ~ republican + winning_margin*college + female + above_median_age | regionf , data=_, vcov="hetero")
  me_r6 <- slopes(r6, variables = "winning_margin", by = "college")
  c6 = c(
    sprintf("%.3f", tidy(me_r6)$estimate[2]),
    sprintf("(%.3f)", tidy(me_r6)$std.error[2])
  ) 
  r7 <- tabledf |> feols(share_to_winner ~ republican + college + winning_margin*female + above_median_age | regionf , data=_, vcov="hetero")
  me_r7 <- slopes(r7, variables = "winning_margin", by = "female")
  c7 = c(
    sprintf("%.3f", tidy(me_r7)$estimate[2]),
    sprintf("(%.3f)", tidy(me_r7)$std.error[2])
  ) 
  r8 <- tabledf |> feols(share_to_winner ~ republican + college + female + winning_margin*above_median_age | regionf , data=_, vcov="hetero")
  me_r8 <- slopes(r8, variables = "winning_margin", by = "above_median_age")
  c8 = c(
    sprintf("%.3f", tidy(me_r8)$estimate[2]),
    sprintf("(%.3f)", tidy(me_r8)$std.error[2])
  )  
  extra_rows <- tibble(row_names = c("Linear combination WTA$\\times X$", ""),
                       c1=c1,c2=c2,c3=c3,c4=c4,c5=c5,c6=c6,c7=c7,c8=c8)
  regressions <- list(r1,r2,r3,r4,r5,r6,r7,r8)
  
  list("regressions"=regressions, 
       "extra_rows"=extra_rows)
}


general_attitudes_restricted_l <- function(mmw2018r) {
  tabledf <- mmw2018r |>
    filter(treatment != "Base") |>
    mutate(share_to_winner = y2/(y1+y2),
           all_to_winner = as.numeric(y2==e2),
           republican = as.numeric(pol2==1),
           college = as.numeric(education>4),
           female = as.numeric(sex==2),
           above_median_age = as.numeric(age > median(age)),
           regionf = factor(area)
    )
  
  c1 <- tabledf |> fixest::feols(scale(8-att3) ~ all_to_winner + republican + college + female + above_median_age | regionf, data=_, vcov="hetero")
  c2 <- tabledf |> fixest::feols(scale(8-att3) ~ share_to_winner + republican + college + female + above_median_age | regionf, data=_, vcov="hetero")
  c3 <- tabledf |> fixest::feols(scale(8-att4) ~ all_to_winner + republican + college + female + above_median_age | regionf, data=_, vcov="hetero")
  c4 <- tabledf |> fixest::feols(scale(8-att4) ~ share_to_winner + republican + college + female + above_median_age | regionf, data=_, vcov="hetero")
  c5 <- tabledf |> fixest::feols(scale(att2) ~ all_to_winner + republican + college + female + above_median_age | regionf, data=_, vcov="hetero")
  c6 <- tabledf |> fixest::feols(scale(att2) ~ share_to_winner + republican + college + female + above_median_age | regionf, data=_, vcov="hetero")
  list(c1,c2,c3,c4,c5,c6)
}

lab_treatments_l <- function(mmw2014) {
  tabledf <- mmw2014 |>
    # Note that x1 and x2 are not meaningful in Luck treatments,.
    # since the number of problems solved by individuals are different from the
    # randomly assigned pair in terms of earnings.
    filter(e1==0) |>
    mutate(treatment = case_when(
      T==1 ~ "WTA-No Choice",
      T==2 ~ "WTA",
      T==3 ~ "WTA-No Exp",
      T==4 ~ "Base"),
      treatmentf = relevel(factor(treatment, levels=c("WTA-No Choice",
                              "WTA",
                              "WTA-No Exp",
                              "Base")), ref="WTA") ,
      female = as.numeric(sex==1),
      right = as.numeric(political>3),
      all_to_winner = as.numeric(y2==e2),
      share_to_winner = y2/e2,
      winning_margin = x2-x1,
      competition = as.numeric(treatment %in% c("WTA-No Choice","WTA","WTA-No Exp")))
  
  c1 <- tabledf |> filter(treatment!="Base") |> feols(all_to_winner ~ treatmentf , data=_, vcov="hetero")
  c2 <- tabledf |> feols(all_to_winner ~ competition + age + female + right | sessionid, data=_, vcov="hetero")
  c3 <-  tabledf |> filter(treatment!="Base") |> feols(all_to_winner ~ winning_margin + age + female + right | sessionid, data=_, vcov="hetero")
  c4 <- tabledf |> filter(treatment!="Base") |> feols(share_to_winner ~ treatmentf , data=_, vcov="hetero")
  c5 <- tabledf |> feols(share_to_winner ~ competition + age + female + right | sessionid, data=_, vcov="hetero")
  c6 <-  tabledf |> filter(treatment!="Base") |> feols(share_to_winner ~ winning_margin + age + female + right | sessionid, data=_, vcov="hetero")
  
  list(c1,c2,c3,c4,c5,c6)
}

by_place_in_distribution_l <- function(mmw2025) {
  tabledf <- mmw2025 |>
    labelled::remove_labels() |>
    mutate(all_to_winner = as.numeric(y2==e2),
           share_to_winner = y2/(y1+y2),
           winning_margin = x2-x1,
           republican = as.numeric(pol2==1),
           college = as.numeric(education>4),
           female = as.numeric(sex==2),
           above_median_age = as.numeric(age > median(age)),
           regionf = factor(region),
           treatmentf = relevel(factor(treatment), ref = "baseline"))
  prods <- c(tabledf$x1, tabledf$x2)
  md <- median(prods)
  tabledfd <- tabledf |> filter(treatment=="show_distribution")
  k1 <- tabledfd |> filter(x2<md) |> feols(all_to_winner ~ winning_margin, data=_, vcov="hetero")
  k2 <- tabledfd |> filter(x2<md) |> feols(all_to_winner ~ winning_margin + republican + college + female + above_median_age + regionf, data=_, vcov="hetero")
  k3 <- tabledfd |> filter(x2<md) |> feols(share_to_winner ~ winning_margin, data=_, vcov="hetero")
  k4 <- tabledfd |> filter(x2<md) |> feols(share_to_winner ~ winning_margin + republican + college + female + above_median_age + regionf, data=_, vcov="hetero")
  
  k5 <- tabledfd |> filter(x2>=md, x1<md) |> feols(all_to_winner ~ winning_margin, data=_, vcov="hetero")
  k6 <- tabledfd |> filter(x2>=md, x1<md) |> feols(all_to_winner ~ winning_margin + republican + college + female + above_median_age + regionf, data=_, vcov="hetero")
  k7 <- tabledfd |> filter(x2>=md, x1<md) |> feols(share_to_winner ~ winning_margin, data=_, vcov="hetero")
  k8 <- tabledfd |> filter(x2>=md, x1<md) |> feols(share_to_winner ~ winning_margin + republican + college + female + above_median_age + regionf, data=_, vcov="hetero")
  
  k9  <- tabledfd |> filter(x1>=md) |> feols(all_to_winner ~ winning_margin, data=_, vcov="hetero")
  k10 <- tabledfd |> filter(x1>=md) |> feols(all_to_winner ~ winning_margin + republican + college + female + above_median_age + regionf, data=_, vcov="hetero")
  k11 <- tabledfd |> filter(x1>=md) |> feols(share_to_winner ~ winning_margin, data=_, vcov="hetero")
  k12 <- tabledfd |> filter(x1>=md) |> feols(share_to_winner ~ winning_margin + republican + college + female + above_median_age + regionf, data=_, vcov="hetero")
  
  list(k1,k2,k3,k4,k5,k6,k7,k8,k9,k10,k11,k12)
}

ass_giving_all_attitudes_2025_l <- function(mmw2025) {
  tabledf <- mmw2025 |>
    labelled::remove_labels() |>
    mutate(all_to_winner = as.numeric(y2==e2),
           share_to_winner = y2/(y1+y2),
           winning_margin = x2-x1,
           republican = as.numeric(pol2==1),
           college = as.numeric(education>4),
           female = as.numeric(sex==2),
           above_median_age = as.numeric(age > median(age)),
           regionf = factor(region),
           treatmentf = relevel(factor(treatment), ref = "baseline"))
  
  t4_c1 <- tabledf |> fixest::feols(scale(8-att3) ~ all_to_winner, data=_, vcov="hetero")
  t4_c2 <- tabledf |> fixest::feols(scale(8-att3) ~ republican + college + female + above_median_age | regionf, data=_, vcov="hetero")
  t4_c3 <- tabledf |> fixest::feols(scale(8-att3) ~ all_to_winner + republican + college + female + above_median_age | regionf, data=_, vcov="hetero")
  
  t4_c4 <- tabledf |> fixest::feols(scale(8-att4) ~ all_to_winner, data=_, vcov="hetero")
  t4_c5 <- tabledf |> fixest::feols(scale(8-att4) ~ republican + college + female + above_median_age | regionf, data=_, vcov="hetero")
  t4_c6 <- tabledf |> fixest::feols(scale(8-att4) ~ all_to_winner + republican + college + female + above_median_age | regionf, data=_, vcov="hetero")
  
  t4_c7 <- tabledf |> fixest::feols(scale(att2) ~ all_to_winner, data=_, vcov="hetero")
  t4_c8 <- tabledf |> fixest::feols(scale(att2) ~ republican + college + female + above_median_age | regionf, data=_, vcov="hetero")
  t4_c9 <- tabledf |> fixest::feols(scale(att2) ~ all_to_winner + republican + college + female + above_median_age | regionf, data=_, vcov="hetero")
  
  all_to_winner <- list(t4_c1, t4_c2, t4_c3, t4_c4, t4_c5, t4_c6, t4_c7, t4_c8, t4_c9)
  
  u4_c1 <- tabledf |> fixest::feols(scale(8-att3) ~ share_to_winner, data=_, vcov="hetero")
  u4_c2 <- tabledf |> fixest::feols(scale(8-att3) ~ republican + college + female + above_median_age | regionf, data=_, vcov="hetero")
  u4_c3 <- tabledf |> fixest::feols(scale(8-att3) ~ share_to_winner + republican + college + female + above_median_age | regionf, data=_, vcov="hetero")

  u4_c4 <- tabledf |> fixest::feols(scale(8-att4) ~ share_to_winner, data=_, vcov="hetero")
  u4_c5 <- tabledf |> fixest::feols(scale(8-att4) ~ republican + college + female + above_median_age | regionf, data=_, vcov="hetero")
  u4_c6 <- tabledf |> fixest::feols(scale(8-att4) ~ share_to_winner + republican + college + female + above_median_age | regionf, data=_, vcov="hetero")
  
  u4_c7 <- tabledf |> fixest::feols(scale(att2) ~ share_to_winner, data=_, vcov="hetero")
  u4_c8 <- tabledf |> fixest::feols(scale(att2) ~ republican + college + female + above_median_age | regionf, data=_, vcov="hetero")
  u4_c9 <- tabledf |> fixest::feols(scale(att2) ~ share_to_winner + republican + college + female + above_median_age | regionf, data=_, vcov="hetero")
  
  share_to_winner <- list(u4_c1, u4_c2, u4_c3, u4_c4, u4_c5, u4_c6, u4_c7, u4_c8, u4_c9)
  
  list("all_to_winner"=all_to_winner, "share_to_winner"=share_to_winner)
  
}

outcomes_on_background_l <- function(mmw2018) {
  outcomes <- mmw2018 |>  
    filter(treatment != "Base") |>
    mutate(all_to_winner = as.numeric(y2==e2),
         share_to_winner = y2/(y1+y2),
         competition = as.numeric(treatment!="Base"),
         winning_margin = x2-x1,
         republican = as.numeric(pol2==1),
         college = as.numeric(education>4),
         female = as.numeric(sex==2),
         above_median_age = as.numeric(age > median(age)),
         regionf = factor(area),
         performance_winner = x2,
         treatment = fct_relevel(treatment, "WTA")
  )
  
  k1 <- outcomes |> feols(all_to_winner ~ republican + college + female + above_median_age + regionf, data=_, vcov="hetero")
  k2 <- outcomes |> filter(winning_margin==1) |> feols(all_to_winner ~ republican + college + female + above_median_age + regionf, data=_, vcov="hetero")
  k3 <- outcomes |> feols(share_to_winner ~ republican + college + female + above_median_age + regionf, data=_, vcov="hetero")
  k4 <- outcomes |> filter(winning_margin==1) |> feols(share_to_winner ~ republican + college + female + above_median_age + regionf, data=_, vcov="hetero")

  names <- c("republican"="Republican",
             "college"= "College",
             "female"="Female",
             "above_median_age"="Above median age")
  regs <- list(k1,k2,k3,k4)
  list("names"=names, 
       "regs"=regs)
}

balance_table_2018 <- function(mmw2018) {
  columns <- c("Age", "Female","Republican","Education","Taxes on top one percent",
               "Gold medalist","Superstar","Midwest","Northeast", "South","West", "Num.Obs")
  
  treatments <- c("WTA","WTA: No Choice","WTA: No Exp", "Base")
  
  df <- mmw2018 |> mutate(republican = as.numeric(pol2==1),
                          female = as.numeric(sex==2))
  # First for the pooled data
  cs <- list("all"= c(
    mean(df$age),
    mean(df$female),
    mean(df$republican),
    mean(df$education),
    mean(df$att2),
    mean(df$att3),
    mean(df$att4),
    mean(df$area=="Midwest"),
    mean(df$area=="Northeast"),
    mean(df$area=="South"),
    mean(df$area=="West"),
    nrow(df)))
  
  # For each of the treatments
  for (trt in treatments) {
    smpl <- df |> filter(treatment==trt)
    k <- c(
      mean(smpl$age),
      mean(smpl$female),
      mean(smpl$republican),
      mean(smpl$education),
      mean(smpl$att2),
      mean(smpl$att3),
      mean(smpl$att4),
      mean(smpl$area=="Midwest"),
      mean(smpl$area=="Northeast"),
      mean(smpl$area=="South"),
      mean(smpl$area=="West"),
      nrow(smpl))
    cs[[trt]]=k
  }
  
  # Final column with F-test/ANOVA
  tests <- c(
    oneway.test(age ~ treatment, data=df)$p.value,
    oneway.test(female ~ treatment, data=df)$p.value,
    oneway.test(republican ~ treatment, data=df)$p.value,
    oneway.test(education ~ treatment, data=df)$p.value,
    oneway.test(att2 ~ treatment, data=df)$p.value,
    oneway.test(att3 ~ treatment, data=df)$p.value,
    oneway.test(att4 ~ treatment, data=df)$p.value,
    oneway.test(area=="Midwest" ~ treatment, data=df)$p.value,
    oneway.test(area=="Northeast" ~ treatment, data=df)$p.value,
    oneway.test(area=="South" ~ treatment, data=df)$p.value,
    oneway.test(area=="West" ~ treatment, data=df)$p.value,
    nrow(df)
  )
  
  tibble(variable =  columns,
         all = cs$all,
         wta = cs$`WTA`,
         nochoice = cs$`WTA: No Choice`,
         noexp = cs$`WTA: No Exp`,
         luck = cs$`Base`,
         tests = tests)
}

lab_balance_l <- function(mmw2014) {
  rows <- c("Age", "Female","Rightwing", "Num.Obs")
  df <- mmw2014 |> mutate(rightwing = as.numeric(political>3),
                          female = as.numeric(sex==2)) |>
    filter(e1!=e2)
  cs <- list( "all" = c(
    mean(df$age),
    mean(df$female),
    mean(df$rightwing),
    nrow(df)))
  trts <- list()
  for (t in seq(1,4)) {
    smpl <- df |> filter(T==t)
    trts[[t]] <- c(
      mean(smpl$age),
      mean(smpl$female),
      mean(smpl$rightwing),
      nrow(smpl)
      )
  }
  tests <- c( 
    oneway.test(age ~ T, data=df)$p.value,
    oneway.test(female ~ T, data=df)$p.value,
    oneway.test(rightwing ~T, data=df)$p.value,
    nrow(df)
  )
  tibble(variable=rows, 
         all = cs$all,
         wta = trts[[2]],
         wtanochoice = trts[[1]],
         wtanoexp = trts[[3]],
         luck = trts[[4]],
         tests = tests)
  
}