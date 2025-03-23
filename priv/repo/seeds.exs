alias Flagguesserapp.Modes.Mode
alias Flagguesserapp.Accounts.User
alias Flagguesserapp.Regions.Region
alias Flagguesserapp.Flags.Flag
alias Flagguesserapp.Repo

# Regions
africa =
  %Region{name: "Africa", slug: "africa", image_path: "/images/africa.svg"}
  |> Repo.insert!()

asia =
  %Region{name: "Asia", slug: "asia", image_path: "/images/asia.svg"}
  |> Repo.insert!()

europe =
  %Region{name: "Europe", slug: "europe", image_path: "/images/europe.svg"}
  |> Repo.insert!()

northamerica =
  %Region{name: "North America", slug: "north-america", image_path: "/images/north-america.svg"}
  |> Repo.insert!()

southamerica =
  %Region{name: "South America", slug: "south-america", image_path: "/images/south-america.svg"}
  |> Repo.insert!()

oceania =
  %Region{name: "Oceania", slug: "oceania", image_path: "/images/oceania.svg"}
  |> Repo.insert!()

# Modes
[
  %Mode{name: "Best of all!", slug: "best-of-all"},
  %Mode{name: "Best of 10!", slug: "best-of-ten"},
  %Mode{name: "Best of 20!", slug: "best-of-twenty"}
]
|> Enum.each(&Repo.insert!(&1))

# Users
test_user =
  %User{}
  |> User.registration_changeset(%{
    username: "Lennart",
    email: "lennart@example.com",
    password: "111111111111"
  })
  |> Repo.insert!()

test_admin_user =
  %User{}
  |> User.registration_changeset(%{
    username: "Bob",
    email: "lennart@admin.com",
    password: "111111111111",
    is_admin: true
  })
  |> Repo.insert!()

# Flags
[
  %Flag{name: "Afghanistan", region: asia, image_path: "/images/af.svg"},
  %Flag{name: "Albania", region: europe, image_path: "/images/al.svg"},
  %Flag{name: "Algeria", region: africa, image_path: "/images/dz.svg"},
  %Flag{name: "Andorra", region: europe, image_path: "/images/ad.svg"},
  %Flag{name: "Angola", region: africa, image_path: "/images/ao.svg"},
  %Flag{name: "Antigua and Barbuda", region: northamerica, image_path: "/images/ag.svg"},
  %Flag{name: "Argentina", region: southamerica, image_path: "/images/ar.svg"},
  %Flag{name: "Armenia", region: asia, image_path: "/images/am.svg"},
  %Flag{name: "Australia", region: oceania, image_path: "/images/au.svg"},
  %Flag{name: "Austria", region: europe, image_path: "/images/at.svg"},
  %Flag{name: "Azerbaijan", region: asia, image_path: "/images/az.svg"},
  %Flag{name: "Bahamas", region: northamerica, image_path: "/images/bs.svg"},
  %Flag{name: "Bahrain", region: asia, image_path: "/images/bh.svg"},
  %Flag{name: "Bangladesh", region: asia, image_path: "/images/bd.svg"},
  %Flag{name: "Barbados", region: northamerica, image_path: "/images/bb.svg"},
  %Flag{name: "Belarus", region: europe, image_path: "/images/by.svg"},
  %Flag{name: "Belgium", region: europe, image_path: "/images/be.svg"},
  %Flag{name: "Belize", region: northamerica, image_path: "/images/bz.svg"},
  %Flag{name: "Benin", region: africa, image_path: "/images/bj.svg"},
  %Flag{name: "Bhutan", region: asia, image_path: "/images/bt.svg"},
  %Flag{name: "Bolivia", region: southamerica, image_path: "/images/bo.svg"},
  %Flag{name: "Bosnia and Herzegovina", region: europe, image_path: "/images/ba.svg"},
  %Flag{name: "Botswana", region: africa, image_path: "/images/bw.svg"},
  %Flag{name: "Brazil", region: southamerica, image_path: "/images/br.svg"},
  %Flag{name: "Brunei Darussalam", region: asia, image_path: "/images/bn.svg"},
  %Flag{name: "Bulgaria", region: europe, image_path: "/images/bg.svg"},
  %Flag{name: "Burkina Faso", region: africa, image_path: "/images/bf.svg"},
  %Flag{name: "Burundi", region: africa, image_path: "/images/bi.svg"},
  %Flag{name: "Cabo Verde", region: africa, image_path: "/images/cv.svg"},
  %Flag{name: "Cambodia", region: asia, image_path: "/images/kh.svg"},
  %Flag{name: "Cameroon", region: africa, image_path: "/images/cm.svg"},
  %Flag{name: "Canada", region: northamerica, image_path: "/images/ca.svg"},
  %Flag{name: "Central African Republic", region: africa, image_path: "/images/cf.svg"},
  %Flag{name: "Chad", region: africa, image_path: "/images/td.svg"},
  %Flag{name: "Chile", region: southamerica, image_path: "/images/cl.svg"},
  %Flag{name: "China", region: asia, image_path: "/images/cn.svg"},
  %Flag{name: "Colombia", region: southamerica, image_path: "/images/co.svg"},
  %Flag{name: "Comoros", region: africa, image_path: "/images/km.svg"},
  %Flag{name: "Congo (Congo-Brazzaville)", region: africa, image_path: "/images/cg.svg"},
  %Flag{name: "Congo (Democratic Republic)", region: africa, image_path: "/images/cd.svg"},
  %Flag{name: "Costa Rica", region: northamerica, image_path: "/images/cr.svg"},
  %Flag{name: "Croatia", region: europe, image_path: "/images/hr.svg"},
  %Flag{name: "Cuba", region: northamerica, image_path: "/images/cu.svg"},
  %Flag{name: "Cyprus", region: europe, image_path: "/images/cy.svg"},
  %Flag{name: "Czechia (Czech Republic)", region: europe, image_path: "/images/cz.svg"},
  %Flag{name: "Denmark", region: europe, image_path: "/images/dk.svg"},
  %Flag{name: "Djibouti", region: africa, image_path: "/images/dj.svg"},
  %Flag{name: "Dominica", region: northamerica, image_path: "/images/dm.svg"},
  %Flag{name: "Dominican Republic", region: northamerica, image_path: "/images/do.svg"},
  %Flag{name: "Ecuador", region: southamerica, image_path: "/images/ec.svg"},
  %Flag{name: "Egypt", region: africa, image_path: "/images/eg.svg"},
  %Flag{name: "El Salvador", region: northamerica, image_path: "/images/sv.svg"},
  %Flag{name: "Equatorial Guinea", region: africa, image_path: "/images/gq.svg"},
  %Flag{name: "Eritrea", region: africa, image_path: "/images/er.svg"},
  %Flag{name: "Estonia", region: europe, image_path: "/images/ee.svg"},
  %Flag{name: "Eswatini (Swaziland)", region: africa, image_path: "/images/sz.svg"},
  %Flag{name: "Ethiopia", region: africa, image_path: "/images/et.svg"},
  %Flag{name: "Fiji", region: oceania, image_path: "/images/fj.svg"},
  %Flag{name: "Finland", region: europe, image_path: "/images/fi.svg"},
  %Flag{name: "France", region: europe, image_path: "/images/fr.svg"},
  %Flag{name: "Gabon", region: africa, image_path: "/images/ga.svg"},
  %Flag{name: "Gambia", region: africa, image_path: "/images/gm.svg"},
  %Flag{name: "Georgia", region: asia, image_path: "/images/ge.svg"},
  %Flag{name: "Germany", region: europe, image_path: "/images/de.svg"},
  %Flag{name: "Ghana", region: africa, image_path: "/images/gh.svg"},
  %Flag{name: "Greece", region: europe, image_path: "/images/gr.svg"},
  %Flag{name: "Grenada", region: northamerica, image_path: "/images/gd.svg"},
  %Flag{name: "Guatemala", region: northamerica, image_path: "/images/gt.svg"},
  %Flag{name: "Guinea", region: africa, image_path: "/images/gn.svg"},
  %Flag{name: "Guinea-Bissau", region: africa, image_path: "/images/gw.svg"},
  %Flag{name: "Guyana", region: southamerica, image_path: "/images/gy.svg"},
  %Flag{name: "Haiti", region: northamerica, image_path: "/images/ht.svg"},
  %Flag{name: "Honduras", region: northamerica, image_path: "/images/hn.svg"},
  %Flag{name: "Hungary", region: europe, image_path: "/images/hu.svg"},
  %Flag{name: "Iceland", region: europe, image_path: "/images/is.svg"},
  %Flag{name: "India", region: asia, image_path: "/images/in.svg"},
  %Flag{name: "Indonesia", region: asia, image_path: "/images/id.svg"},
  %Flag{name: "Iran", region: asia, image_path: "/images/ir.svg"},
  %Flag{name: "Iraq", region: asia, image_path: "/images/iq.svg"},
  %Flag{name: "Ireland", region: europe, image_path: "/images/ie.svg"},
  %Flag{name: "Israel", region: asia, image_path: "/images/il.svg"},
  %Flag{name: "Italy", region: europe, image_path: "/images/it.svg"},
  %Flag{name: "Jamaica", region: northamerica, image_path: "/images/jm.svg"},
  %Flag{name: "Japan", region: asia, image_path: "/images/jp.svg"},
  %Flag{name: "Jordan", region: asia, image_path: "/images/jo.svg"},
  %Flag{name: "Kazakhstan", region: asia, image_path: "/images/kz.svg"},
  %Flag{name: "Kenya", region: africa, image_path: "/images/ke.svg"},
  %Flag{name: "Kiribati", region: oceania, image_path: "/images/ki.svg"},
  %Flag{name: "Korea (North)", region: asia, image_path: "/images/kp.svg"},
  %Flag{name: "Korea (South)", region: asia, image_path: "/images/kr.svg"},
  %Flag{name: "Kosovo", region: europe, image_path: "/images/xk.svg"},
  %Flag{name: "Kuwait", region: asia, image_path: "/images/kw.svg"},
  %Flag{name: "Kyrgyzstan", region: asia, image_path: "/images/kg.svg"},
  %Flag{name: "Laos", region: asia, image_path: "/images/la.svg"},
  %Flag{name: "Latvia", region: europe, image_path: "/images/lv.svg"},
  %Flag{name: "Lebanon", region: asia, image_path: "/images/lb.svg"},
  %Flag{name: "Lesotho", region: africa, image_path: "/images/ls.svg"},
  %Flag{name: "Liberia", region: africa, image_path: "/images/lr.svg"},
  %Flag{name: "Libya", region: africa, image_path: "/images/ly.svg"},
  %Flag{name: "Liechtenstein", region: europe, image_path: "/images/li.svg"},
  %Flag{name: "Lithuania", region: europe, image_path: "/images/lt.svg"},
  %Flag{name: "Luxembourg", region: europe, image_path: "/images/lu.svg"},
  %Flag{name: "Madagascar", region: africa, image_path: "/images/mg.svg"},
  %Flag{name: "Malawi", region: africa, image_path: "/images/mw.svg"},
  %Flag{name: "Malaysia", region: asia, image_path: "/images/my.svg"},
  %Flag{name: "Maldives", region: asia, image_path: "/images/mv.svg"},
  %Flag{name: "Mali", region: africa, image_path: "/images/ml.svg"},
  %Flag{name: "Malta", region: europe, image_path: "/images/mt.svg"},
  %Flag{name: "Marshall Islands", region: oceania, image_path: "/images/mh.svg"},
  %Flag{name: "Mauritania", region: africa, image_path: "/images/mr.svg"},
  %Flag{name: "Mauritius", region: africa, image_path: "/images/mu.svg"},
  %Flag{name: "Mexico", region: northamerica, image_path: "/images/mx.svg"},
  %Flag{name: "Micronesia", region: oceania, image_path: "/images/fm.svg"},
  %Flag{name: "Moldova", region: europe, image_path: "/images/md.svg"},
  %Flag{name: "Monaco", region: europe, image_path: "/images/mc.svg"},
  %Flag{name: "Mongolia", region: asia, image_path: "/images/mn.svg"},
  %Flag{name: "Montenegro", region: europe, image_path: "/images/me.svg"},
  %Flag{name: "Morocco", region: africa, image_path: "/images/ma.svg"},
  %Flag{name: "Mozambique", region: africa, image_path: "/images/mz.svg"},
  %Flag{name: "Myanmar", region: asia, image_path: "/images/mm.svg"},
  %Flag{name: "Namibia", region: africa, image_path: "/images/na.svg"},
  %Flag{name: "Nauru", region: oceania, image_path: "/images/nr.svg"},
  %Flag{name: "Nepal", region: asia, image_path: "/images/np.svg"},
  %Flag{name: "Netherlands", region: europe, image_path: "/images/nl.svg"},
  %Flag{name: "New Zealand", region: oceania, image_path: "/images/nz.svg"},
  %Flag{name: "Nicaragua", region: northamerica, image_path: "/images/ni.svg"},
  %Flag{name: "Niger", region: africa, image_path: "/images/ne.svg"},
  %Flag{name: "Nigeria", region: africa, image_path: "/images/ng.svg"},
  %Flag{name: "North Macedonia", region: europe, image_path: "/images/mk.svg"},
  %Flag{name: "Norway", region: europe, image_path: "/images/no.svg"},
  %Flag{name: "Oman", region: asia, image_path: "/images/om.svg"},
  %Flag{name: "Pakistan", region: asia, image_path: "/images/pk.svg"},
  %Flag{name: "Palau", region: oceania, image_path: "/images/pw.svg"},
  %Flag{name: "Panama", region: northamerica, image_path: "/images/pa.svg"},
  %Flag{name: "Papua New Guinea", region: oceania, image_path: "/images/pg.svg"},
  %Flag{name: "Paraguay", region: southamerica, image_path: "/images/py.svg"},
  %Flag{name: "Peru", region: southamerica, image_path: "/images/pe.svg"},
  %Flag{name: "Philippines", region: asia, image_path: "/images/ph.svg"},
  %Flag{name: "Poland", region: europe, image_path: "/images/pl.svg"},
  %Flag{name: "Portugal", region: europe, image_path: "/images/pt.svg"},
  %Flag{name: "Qatar", region: asia, image_path: "/images/qa.svg"},
  %Flag{name: "Romania", region: europe, image_path: "/images/ro.svg"},
  %Flag{name: "Russia", region: europe, image_path: "/images/ru.svg"},
  %Flag{name: "Rwanda", region: africa, image_path: "/images/rw.svg"},
  %Flag{name: "Saint Kitts and Nevis", region: northamerica, image_path: "/images/kn.svg"},
  %Flag{name: "Saint Lucia", region: northamerica, image_path: "/images/lc.svg"},
  %Flag{
    name: "Saint Vincent and the Grenadines",
    region: northamerica,
    image_path: "/images/vc.svg"
  },
  %Flag{name: "Samoa", region: oceania, image_path: "/images/ws.svg"},
  %Flag{name: "San Marino", region: europe, image_path: "/images/sm.svg"},
  %Flag{name: "Sao Tome and Principe", region: africa, image_path: "/images/st.svg"},
  %Flag{name: "Saudi Arabia", region: asia, image_path: "/images/sa.svg"},
  %Flag{name: "Senegal", region: africa, image_path: "/images/sn.svg"},
  %Flag{name: "Serbia", region: europe, image_path: "/images/rs.svg"},
  %Flag{name: "Seychelles", region: africa, image_path: "/images/sc.svg"},
  %Flag{name: "Sierra Leone", region: africa, image_path: "/images/sl.svg"},
  %Flag{name: "Singapore", region: asia, image_path: "/images/sg.svg"},
  %Flag{name: "Slovakia", region: europe, image_path: "/images/sk.svg"},
  %Flag{name: "Slovenia", region: europe, image_path: "/images/si.svg"}
  # Füge weitere Länder alphabetisch hinzu...
]
|> Enum.each(&Repo.insert!(&1))
