create table characters (
  id INTEGER PRIMARY KEY, 
  name TEXT NOT NULL, 
  nature TEXT,
  demeanor TEXT,
  clan TEXT NOT NULL,
  generation INTEGER NOT NULL,
  concept TEXT,
  chronicle TEXT, 
  sire TEXT,
  conscience INTEGER NOT NULL DEFAULT 1,
  self_control INTEGER NOT NULL DEFAULT 1,
  courage INTEGER NOT NULL DEFAULT 1,
  humanity INTEGER NOT NULL DEFAULT 2,
  max_willpower INTEGER NOT NULL DEFAULT 0,
  cur_willpower INTEGER NOT NULL DEFAULT 0,
  cur_blood INTEGER NOT NULL DEFAULT 0,
  max_blood INTEGER NOT NULL DEFAULT 0
);