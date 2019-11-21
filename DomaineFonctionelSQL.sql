
CREATE SEQUENCE public.ingredient_id_ingredient_seq;

CREATE TABLE public.Ingredient (
                Id_Ingredient INTEGER NOT NULL DEFAULT nextval('public.ingredient_id_ingredient_seq'),
                Nom_Ingredient VARCHAR NOT NULL,
                Quantite INTEGER NOT NULL,
                CONSTRAINT ingredient_pk PRIMARY KEY (Id_Ingredient)
);


ALTER SEQUENCE public.ingredient_id_ingredient_seq OWNED BY public.Ingredient.Id_Ingredient;

CREATE SEQUENCE public.pizza_id_pizza_seq;

CREATE TABLE public.Pizza (
                ID_Pizza INTEGER NOT NULL DEFAULT nextval('public.pizza_id_pizza_seq'),
                Nom_pizza VARCHAR NOT NULL,
                Note INTEGER NOT NULL,
                Composition VARCHAR NOT NULL,
                Prix INTEGER NOT NULL,
                Id_Ingredient INTEGER NOT NULL,
                CONSTRAINT pizza_pk PRIMARY KEY (ID_Pizza)
);


ALTER SEQUENCE public.pizza_id_pizza_seq OWNED BY public.Pizza.ID_Pizza;

CREATE SEQUENCE public.paiement_id_paiement_seq;

CREATE TABLE public.Paiement (
                ID_Paiement INTEGER NOT NULL DEFAULT nextval('public.paiement_id_paiement_seq'),
                Typre_paiement VARCHAR NOT NULL,
                Validite BOOLEAN NOT NULL,
                Heure_paiement TIME NOT NULL,
                CONSTRAINT paiement_pk PRIMARY KEY (ID_Paiement)
);


ALTER SEQUENCE public.paiement_id_paiement_seq OWNED BY public.Paiement.ID_Paiement;

CREATE SEQUENCE public.utilisateur_id_utilisateur_seq;

CREATE TABLE public.Utilisateur (
                Id_Utilisateur INTEGER NOT NULL DEFAULT nextval('public.utilisateur_id_utilisateur_seq'),
                Nom VARCHAR NOT NULL,
                Prenom VARCHAR NOT NULL,
                Date_Arrivee DATE NOT NULL,
                Date_Naissance DATE NOT NULL,
                Type_Compte VARCHAR NOT NULL,
                CONSTRAINT utilisateur_pk PRIMARY KEY (Id_Utilisateur)
);


ALTER SEQUENCE public.utilisateur_id_utilisateur_seq OWNED BY public.Utilisateur.Id_Utilisateur;

CREATE SEQUENCE public.preparation_num_ro_pr_paration_seq;

CREATE TABLE public.Preparation (
                Numéro_préparation INTEGER NOT NULL DEFAULT nextval('public.preparation_num_ro_pr_paration_seq'),
                Id_Utilisateur INTEGER NOT NULL,
                Date_préparation DATE NOT NULL,
                Heure_préparation TIME NOT NULL,
                Préparation_OK BOOLEAN DEFAULT False NOT NULL,
                CONSTRAINT preparation_pk PRIMARY KEY (Numéro_préparation, Id_Utilisateur)
);


ALTER SEQUENCE public.preparation_num_ro_pr_paration_seq OWNED BY public.Preparation.Numéro_préparation;

CREATE SEQUENCE public.livraison_num_ro_livraison_seq;

CREATE TABLE public.Livraison (
                Numéro_Livraison INTEGER NOT NULL DEFAULT nextval('public.livraison_num_ro_livraison_seq'),
                Id_Utilisateur INTEGER NOT NULL,
                Date DATE NOT NULL,
                Heure_recuperation TIME NOT NULL,
                Heure_livraison_pizza TIME NOT NULL,
                CONSTRAINT livraison_pk PRIMARY KEY (Numéro_Livraison, Id_Utilisateur)
);


ALTER SEQUENCE public.livraison_num_ro_livraison_seq OWNED BY public.Livraison.Numéro_Livraison;

CREATE SEQUENCE public.commande_numero_commande_seq;

CREATE TABLE public.Commande (
                Numero_commande INTEGER NOT NULL DEFAULT nextval('public.commande_numero_commande_seq'),
                Numéro_Livraison INTEGER NOT NULL,
                Id_Utilisateur INTEGER NOT NULL,
                Numéro_préparation INTEGER NOT NULL,
                Utilisateur VARCHAR NOT NULL,
                Date_commande DATE NOT NULL,
                Heure_commande TIME NOT NULL,
                Nombre_pizza INTEGER NOT NULL,
                ID_Paiement INTEGER NOT NULL,
                ID_Pizza INTEGER NOT NULL,
                CONSTRAINT commande_pk PRIMARY KEY (Numero_commande, Numéro_Livraison, Id_Utilisateur, Numéro_préparation)
);


ALTER SEQUENCE public.commande_numero_commande_seq OWNED BY public.Commande.Numero_commande;

CREATE SEQUENCE public.facture_num_ro_facture_seq;

CREATE TABLE public.Facture (
                Numéro_Facture INTEGER NOT NULL DEFAULT nextval('public.facture_num_ro_facture_seq'),
                ID_Paiement INTEGER NOT NULL,
                Numero_commande INTEGER NOT NULL,
                Numéro_Livraison INTEGER NOT NULL,
                Id_Utilisateur INTEGER NOT NULL,
                Numéro_préparation INTEGER NOT NULL,
                CONSTRAINT facture_pk PRIMARY KEY (Numéro_Facture, ID_Paiement, Numero_commande, Numéro_Livraison, Id_Utilisateur, Numéro_préparation)
);


ALTER SEQUENCE public.facture_num_ro_facture_seq OWNED BY public.Facture.Numéro_Facture;

CREATE SEQUENCE public.adresse_id_adresse_seq;

CREATE TABLE public.Adresse (
                ID_Adresse INTEGER NOT NULL DEFAULT nextval('public.adresse_id_adresse_seq'),
                Numero INTEGER NOT NULL,
                Voie VARCHAR NOT NULL,
                Code_Postal INTEGER NOT NULL,
                Ville VARCHAR NOT NULL,
                Id_Utilisateur INTEGER NOT NULL,
                CONSTRAINT adresse_pk PRIMARY KEY (ID_Adresse)
);


ALTER SEQUENCE public.adresse_id_adresse_seq OWNED BY public.Adresse.ID_Adresse;

ALTER TABLE public.Pizza ADD CONSTRAINT ingredient_pizza_fk
FOREIGN KEY (Id_Ingredient)
REFERENCES public.Ingredient (Id_Ingredient)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.Commande ADD CONSTRAINT pizza_commande_fk
FOREIGN KEY (ID_Pizza)
REFERENCES public.Pizza (ID_Pizza)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.Commande ADD CONSTRAINT paiement_commande_fk
FOREIGN KEY (ID_Paiement)
REFERENCES public.Paiement (ID_Paiement)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.Facture ADD CONSTRAINT paiement_facture_fk
FOREIGN KEY (ID_Paiement)
REFERENCES public.Paiement (ID_Paiement)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.Adresse ADD CONSTRAINT utilisateur_adresse_fk
FOREIGN KEY (Id_Utilisateur)
REFERENCES public.Utilisateur (Id_Utilisateur)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.Commande ADD CONSTRAINT utilisateur_commande_fk
FOREIGN KEY (Id_Utilisateur)
REFERENCES public.Utilisateur (Id_Utilisateur)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.Livraison ADD CONSTRAINT utilisateur_livraison_fk
FOREIGN KEY (Id_Utilisateur)
REFERENCES public.Utilisateur (Id_Utilisateur)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.Preparation ADD CONSTRAINT utilisateur_preparation_fk
FOREIGN KEY (Id_Utilisateur)
REFERENCES public.Utilisateur (Id_Utilisateur)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.Commande ADD CONSTRAINT preparation_commande_fk
FOREIGN KEY (Numéro_préparation, Id_Utilisateur)
REFERENCES public.Preparation (Numéro_préparation, Id_Utilisateur)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.Commande ADD CONSTRAINT livraison_commande_fk
FOREIGN KEY (Numéro_Livraison, Id_Utilisateur)
REFERENCES public.Livraison (Numéro_Livraison, Id_Utilisateur)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.Facture ADD CONSTRAINT commande_facture_fk
FOREIGN KEY (Numero_commande, Numéro_Livraison, Id_Utilisateur, Numéro_préparation)
REFERENCES public.Commande (Numero_commande, Numéro_Livraison, Id_Utilisateur, Numéro_préparation)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;
