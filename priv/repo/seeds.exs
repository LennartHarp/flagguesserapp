alias Flagguesserapp.Regions.Region
alias Flagguesserapp.Flags.Flag
alias Flagguesserapp.Repo

africa =
  %Region{name: "Africa", slug: "africa"}
  |> Repo.insert!()

asia =
  %Region{name: "Asia", slug: "asia"}
  |> Repo.insert!()

europe =
  %Region{name: "Europe", slug: "europe"}
  |> Repo.insert!()

northamerica =
  %Region{name: "North America", slug: "north-america"}
  |> Repo.insert!()

sourthamerica =
  %Region{name: "South America", slug: "south-america"}
  |> Repo.insert!()

oceania =
  %Region{name: "Oceania", slug: "oceania"}
  |> Repo.insert!()

[
  %Flag{name: "Afghanistan", continent: :asia, region: asia, image_path: "/images/af.svg"},
  %Flag{name: "Albania", continent: :europe, region: europe, image_path: "/images/al.svg"},
  %Flag{name: "Algeria", continent: :africa, region: africa, image_path: "/images/dz.svg"},
  %Flag{name: "Andorra", continent: :europe, region: europe, image_path: "/images/ad.svg"},
  %Flag{name: "Angola", continent: :africa, region: africa, image_path: "/images/ao.svg"},
  %Flag{
    name: "Antigua and Barbuda",
    continent: :northamerica,
    region: northamerica,
    image_path: "/images/ag.svg"
  },
  %Flag{
    name: "Argentina",
    continent: :southamerica,
    region: sourthamerica,
    image_path: "/images/ar.svg"
  },
  %Flag{name: "Armenia", continent: :asia, region: asia, image_path: "/images/am.svg"},
  %Flag{name: "Australia", continent: :oceania, region: oceania, image_path: "/images/au.svg"},
  %Flag{name: "Austria", continent: :europe, region: europe, image_path: "/images/at.svg"},
  %Flag{name: "Azerbaijan", continent: :asia, region: asia, image_path: "/images/az.svg"},
  %Flag{
    name: "Bahamas",
    continent: :northamerica,
    region: northamerica,
    image_path: "/images/bs.svg"
  },
  %Flag{name: "Bahrain", continent: :asia, region: asia, image_path: "/images/bh.svg"},
  %Flag{name: "Bangladesh", continent: :asia, region: asia, image_path: "/images/bd.svg"},
  %Flag{
    name: "Barbados",
    continent: :northamerica,
    region: northamerica,
    image_path: "/images/bb.svg"
  },
  %Flag{name: "Belarus", continent: :europe, region: europe, image_path: "/images/by.svg"},
  %Flag{name: "Belgium", continent: :europe, region: europe, image_path: "/images/be.svg"},
  %Flag{
    name: "Belize",
    continent: :northamerica,
    region: northamerica,
    image_path: "/images/bz.svg"
  },
  %Flag{name: "Benin", continent: :africa, region: africa, image_path: "/images/bj.svg"},
  %Flag{name: "Bhutan", continent: :asia, region: asia, image_path: "/images/bt.svg"},
  %Flag{
    name: "Bolivia",
    continent: :southamerica,
    region: sourthamerica,
    image_path: "/images/bo.svg"
  },
  %Flag{
    name: "Bosnia and Herzegovina",
    continent: :europe,
    region: europe,
    image_path: "/images/ba.svg"
  },
  %Flag{name: "Botswana", continent: :africa, region: africa, image_path: "/images/bw.svg"},
  %Flag{
    name: "Brazil",
    continent: :southamerica,
    region: sourthamerica,
    image_path: "/images/br.svg"
  },
  %Flag{name: "Brunei Darussalam", continent: :asia, region: asia, image_path: "/images/bn.svg"},
  %Flag{name: "Bulgaria", continent: :europe, region: europe, image_path: "/images/bg.svg"},
  %Flag{name: "Burkina Faso", continent: :africa, region: africa, image_path: "/images/bf.svg"},
  %Flag{name: "Burundi", continent: :africa, region: africa, image_path: "/images/bi.svg"},
  %Flag{name: "Cabo Verde", continent: :africa, region: africa, image_path: "/images/cv.svg"},
  %Flag{name: "Cambodia", continent: :asia, region: asia, image_path: "/images/kh.svg"},
  %Flag{name: "Cameroon", continent: :africa, region: africa, image_path: "/images/cm.svg"},
  %Flag{
    name: "Canada",
    continent: :northamerica,
    region: northamerica,
    image_path: "/images/ca.svg"
  },
  %Flag{
    name: "Central Africa,n Republic",
    continent: :africa,
    region: africa,
    image_path: "/images/cf.svg"
  },
  %Flag{name: "Chad", continent: :africa, region: africa, image_path: "/images/td.svg"},
  %Flag{
    name: "Chile",
    continent: :southamerica,
    region: sourthamerica,
    image_path: "/images/cl.svg"
  },
  %Flag{name: "China", continent: :asia, region: asia, image_path: "/images/cn.svg"},
  %Flag{
    name: "Colombia",
    continent: :southamerica,
    region: sourthamerica,
    image_path: "/images/co.svg"
  },
  %Flag{name: "Comoros", continent: :africa, region: africa, image_path: "/images/km.svg"},
  %Flag{
    name: "Congo (Congo-Brazzaville)",
    continent: :africa,
    region: africa,
    image_path: "/images/cg.svg"
  },
  %Flag{
    name: "Congo (Democratic Republic)",
    continent: :africa,
    region: africa,
    image_path: "/images/cd.svg"
  },
  %Flag{
    name: "Costa Rica",
    continent: :northamerica,
    region: northamerica,
    image_path: "/images/cr.svg"
  },
  %Flag{name: "Croatia", continent: :europe, region: europe, image_path: "/images/hr.svg"},
  %Flag{
    name: "Cuba",
    continent: :northamerica,
    region: northamerica,
    image_path: "/images/cu.svg"
  },
  %Flag{name: "Cyprus", continent: :europe, region: europe, image_path: "/images/cy.svg"},
  %Flag{
    name: "Czechia (Czech Republic)",
    continent: :europe,
    region: europe,
    image_path: "/images/cz.svg"
  },
  %Flag{name: "Denmark", continent: :europe, region: europe, image_path: "/images/dk.svg"},
  %Flag{name: "Djibouti", continent: :africa, region: africa, image_path: "/images/dj.svg"},
  %Flag{
    name: "Dominica",
    continent: :northamerica,
    region: northamerica,
    image_path: "/images/dm.svg"
  },
  %Flag{
    name: "Dominican Republic",
    continent: :northamerica,
    region: northamerica,
    image_path: "/images/do.svg"
  },
  %Flag{
    name: "Ecuador",
    continent: :southamerica,
    region: sourthamerica,
    image_path: "/images/ec.svg"
  },
  %Flag{name: "Egypt", continent: :africa, region: africa, image_path: "/images/eg.svg"},
  %Flag{
    name: "El Salvador",
    continent: :northamerica,
    region: northamerica,
    image_path: "/images/sv.svg"
  },
  %Flag{
    name: "Equatorial Guinea",
    continent: :africa,
    region: africa,
    image_path: "/images/gq.svg"
  },
  %Flag{name: "Eritrea", continent: :africa, region: africa, image_path: "/images/er.svg"},
  %Flag{name: "Estonia", continent: :europe, region: europe, image_path: "/images/ee.svg"},
  %Flag{
    name: "Eswatini (Swaziland)",
    continent: :africa,
    region: africa,
    image_path: "/images/sz.svg"
  },
  %Flag{name: "Ethiopia", continent: :africa, region: africa, image_path: "/images/et.svg"},
  %Flag{name: "Fiji", continent: :oceania, region: oceania, image_path: "/images/fj.svg"},
  %Flag{name: "Finland", continent: :europe, region: europe, image_path: "/images/fi.svg"},
  %Flag{name: "France", continent: :europe, region: europe, image_path: "/images/fr.svg"},
  %Flag{name: "Gabon", continent: :africa, region: africa, image_path: "/images/ga.svg"},
  %Flag{name: "Gambia", continent: :africa, region: africa, image_path: "/images/gm.svg"},
  %Flag{name: "Georgia", continent: :asia, region: asia, image_path: "/images/ge.svg"},
  %Flag{name: "Germany", continent: :europe, region: europe, image_path: "/images/de.svg"},
  %Flag{name: "Ghana", continent: :africa, region: africa, image_path: "/images/gh.svg"},
  %Flag{name: "Greece", continent: :europe, region: europe, image_path: "/images/gr.svg"},
  %Flag{
    name: "Grenada",
    continent: :northamerica,
    region: northamerica,
    image_path: "/images/gd.svg"
  },
  %Flag{
    name: "Guatemala",
    continent: :northamerica,
    region: northamerica,
    image_path: "/images/gt.svg"
  },
  %Flag{name: "Guinea", continent: :africa, region: africa, image_path: "/images/gn.svg"},
  %Flag{name: "Guinea-Bissau", continent: :africa, region: africa, image_path: "/images/gw.svg"},
  %Flag{
    name: "Guyana",
    continent: :southamerica,
    region: sourthamerica,
    image_path: "/images/gy.svg"
  },
  %Flag{
    name: "Haiti",
    continent: :northamerica,
    region: northamerica,
    image_path: "/images/ht.svg"
  },
  %Flag{
    name: "Honduras",
    continent: :northamerica,
    region: northamerica,
    image_path: "/images/hn.svg"
  },
  %Flag{name: "Hungary", continent: :europe, region: europe, image_path: "/images/hu.svg"},
  %Flag{name: "Iceland", continent: :europe, region: europe, image_path: "/images/is.svg"},
  %Flag{name: "India", continent: :asia, region: asia, image_path: "/images/in.svg"},
  %Flag{name: "Indonesia", continent: :asia, region: asia, image_path: "/images/id.svg"},
  %Flag{name: "Iran", continent: :asia, region: asia, image_path: "/images/ir.svg"},
  %Flag{name: "Iraq", continent: :asia, region: asia, image_path: "/images/iq.svg"},
  %Flag{name: "Ireland", continent: :europe, region: europe, image_path: "/images/ie.svg"},
  %Flag{name: "Israel", continent: :asia, region: asia, image_path: "/images/il.svg"},
  %Flag{name: "Italy", continent: :europe, region: europe, image_path: "/images/it.svg"},
  %Flag{
    name: "Jamaica",
    continent: :northamerica,
    region: northamerica,
    image_path: "/images/jm.svg"
  },
  %Flag{name: "Japan", continent: :asia, region: asia, image_path: "/images/jp.svg"},
  %Flag{name: "Jordan", continent: :asia, region: asia, image_path: "/images/jo.svg"},
  %Flag{name: "Kazakhstan", continent: :asia, region: asia, image_path: "/images/kz.svg"},
  %Flag{name: "Kenya", continent: :africa, region: africa, image_path: "/images/ke.svg"},
  %Flag{name: "Kiribati", continent: :oceania, region: oceania, image_path: "/images/ki.svg"},
  %Flag{name: "Korea (North)", continent: :asia, region: asia, image_path: "/images/kp.svg"},
  %Flag{name: "Korea (South)", continent: :asia, region: asia, image_path: "/images/kr.svg"},
  %Flag{name: "Kosovo", continent: :europe, region: europe, image_path: "/images/xk.svg"},
  %Flag{name: "Kuwait", continent: :asia, region: asia, image_path: "/images/kw.svg"},
  %Flag{name: "Kyrgyzstan", continent: :asia, region: asia, image_path: "/images/kg.svg"},
  %Flag{name: "Laos", continent: :asia, region: asia, image_path: "/images/la.svg"},
  %Flag{name: "Latvia", continent: :europe, region: europe, image_path: "/images/lv.svg"},
  %Flag{name: "Lebanon", continent: :asia, region: asia, image_path: "/images/lb.svg"},
  %Flag{name: "Lesotho", continent: :africa, region: africa, image_path: "/images/ls.svg"},
  %Flag{name: "Liberia", continent: :africa, region: africa, image_path: "/images/lr.svg"},
  %Flag{name: "Libya", continent: :africa, region: africa, image_path: "/images/ly.svg"}
  # Füge weitere Länder alphabetisch hinzu...
]
|> Enum.each(&Repo.insert!/1)
