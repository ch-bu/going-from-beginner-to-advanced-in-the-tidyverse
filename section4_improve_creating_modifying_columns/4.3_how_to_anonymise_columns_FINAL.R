# “the processing of personal data in such a 
# manner that the personal data can no longer
# be attributed to a specific data subject 
# without the use of additional information 
# provided that such additional information 
# is kept separately and is subject to 
# technical and organisational measures 
# to ensure that the personal data are not 
# attributed to an identified or identifiable 
# natural person.” 
# (https://edps.europa.eu/system/files/2021-04/21-04-27_aepd- edps_anonymisation_en_5.pdf)

set.seed(11)
gss_cat |> 
  mutate(
    relig = fct_anon(relig,
                     prefix = "religion_")
  ) |> 
  select(year, marital, relig)


presidential |> 
  mutate(
    name = fct_anon(name)
  )

library(randomNames)

presidential |> 
  mutate(
    name = randomNames(
      n = nrow(presidential),
      name.order = "first.last"
    )
  )