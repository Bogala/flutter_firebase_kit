# Guide de Référence : Standardisation, Optimisation et Sécurité de AGENTS.md pour les Équipes

tags: Nouveau, Pratique, Théorie

# **I. Définition et Philosophie : Le Manifeste du Context Engineering**

Le fichier `AGENTS.md` représente la pierre angulaire de toute stratégie d'ingénierie logicielle assistée par IA de haute performance. Il est un format ouvert et structuré, souvent basé sur Markdown, qui fournit un ensemble de contraintes et d'instructions prévisibles aux agents codants intelligents.[1, 2] Son utilité dépasse celle d'un simple document de documentation ; il agit comme la Source Unique de Vérité (Single Source of Truth) pour guider le comportement du modèle au sein d'un projet.

## **1.1. `AGENTS.md`: Le Fichier `README` pour les Agents Codants**

La fonction principale de ce standard est d'assurer que les assistants IA (qu'il s'agisse de Copilot, Claude Code ou d'agents CLI) ingèrent le contexte fondamental nécessaire pour opérer efficacement dans un environnement spécifique.[1] Placé à la racine du projet, il est le premier artefact que les agents indexent pour définir leur rôle, leurs limites et leurs commandes exécutables.[3, 4]

Pour les équipes d'élite, l'existence et l'application stricte de l'`AGENTS.md` est un impératif de gouvernance. Ce fichier garantit que tous les développeurs, utilisant potentiellement des outils d'IA différents, adhèrent aux mêmes conventions d'équipe et aux mêmes standards de qualité.

## **1.2. De l'Ingénierie de Prompt à l'Ingénierie de Contexte (Context Engineering - CE)**

Le développement assisté par IA a évolué de l'ingénierie de prompt, qui se concentrait sur la formulation optimale des requêtes, vers l'Ingénierie de Contexte (CE).[5] Le CE est la discipline qui vise à optimiser la sélection et l'organisation des *tokens* inclus lors de l'inférence pour atteindre un comportement souhaité de l'agent.[5]

Le contexte complet mis à disposition d'un LLM est composé de plusieurs éléments [6]: le *system prompt* (instructions de base), l'entrée utilisateur, l'historique de la conversation, les descriptions d'outils (Tool Descriptions), et les connaissances récupérées (Retrieved Knowledge). `AGENTS.md` joue le rôle de manifeste qui encadre l'ensemble de ces composants. Il définit les instructions fondamentales et la *persona* de l'agent, tout en référençant les métadonnées de la tâche et les outils disponibles. L'ingénierie du contexte est cruciale car la fenêtre de tokens est une ressource limitée et coûteuse, nécessitant une optimisation rigoureuse de l'utilité de chaque information fournie.[5]

## **1.3. L'Impératif de la Standardisation et Implications Stratégiques**

La standardisation via `AGENTS.md` transforme l'IA d'un simple outil d'aide en un **agent de conformité actif**. Lorsque le comportement de l'IA est dicté par un fichier versionné dans Git, cela crée un **Contrat d'Adhésion** tacite. Ce contrat assure que les nouveaux outils d'IA ou les nouveaux membres de l'équipe reçoivent automatiquement l'ensemble complet des règles architecturales et des conventions de développement.

Si les développeurs utilisaient des prompts individuels pour dicter la qualité du code (prompt engineering isolé), le résultat serait inévitablement hétérogène. En centralisant ces règles dans un fichier unique (Context Engineering), on assure l'homogénéité de la sortie de code. `AGENTS.md` devient ainsi un artefact de gouvernance qui garantit que l'IA commence toujours son travail avec les contraintes de qualité et de sécurité requises.

# **II. Mise en place Technique et Architecture du Fichier**

L'efficacité de l'`AGENTS.md` repose sur une structure technique précise et une organisation hiérarchique adaptée aux projets modernes.

# **2.1. Structure du Répertoire et Hiérarchie des Fichiers `AGENTS.md`**

Le standard spécifie que le fichier `AGENTS.md` **doit** être placé à la racine du répertoire pour être détecté sans ambiguïté par les outils d'indexation.[3] Pour les monorepos ou les applications modulaires, les implémentations modernes supportent une structure hiérarchique: des fichiers `AGENTS.md` peuvent exister dans des sous-répertoires.[3]

Cette structure hiérarchique introduit un principe fondamental de gouvernance: la **spécialisation**. Les instructions dans le fichier `AGENTS.md` d'un sous-répertoire (par exemple, `services/auth/AGENTS.md`) doivent être appliquées cumulativement, et elles **surchargent ou spécialisent** les règles générales définies à la racine du projet. Cela permet de définir des conventions spécifiques (ex: l'utilisation de Go pour le backend, et de TypeScript pour le frontend) sans compromettre les règles de sécurité globales.

## **2.2. Anatomie de l'Agent : Métadonnées et Manifeste YAML**

Pour être à la fois lisible par l'humain (Markdown) et structuré pour la machine, un fichier `AGENTS.md` efficace intègre le **YAML Frontmatter**.[7] Ce bloc de métadonnées, situé au début du fichier, est essentiel pour la configuration structurée.[4]

Les champs critiques incluent [4, 8]:

- **Identification:** `id` et `version` sont vitaux pour l'audit et le suivi de la gouvernance.
- **Persona:** La définition du rôle est fondamentale, car elle guide le ton, le niveau de détail et l'expertise de l'agent. Par exemple, définir l'agent comme un "Senior C++ Developer qui se soucie grandement de la qualité du code, de la lisibilité et de l'efficacité" force l'IA à adhérer à ces priorités.[4, 9]
- **Capabilities & Permissions:** Ces champs déclarent explicitement les actions que l'agent est autorisé à entreprendre (ex: `code-modify`, `test-run`) et définissent des politiques de sécurité claires, telles que l'exigence d'une `humanApproval: required` pour les opérations sensibles comme les changements de schéma de base de données.[8]

## **2.3. Séctions Canoniques et Directives Exécutables**

Le corps du fichier est organisé en sections claires qui servent de manuel d'utilisation détaillé pour l'IA [4]:

1. **Commands (Outils Exécutables):** Cette section liste les commandes shell que l'agent peut invoquer (ex: `pnpm test`, `npm run lint --fix`).[2, 4] L'inclusion de commandes permet à l'IA d'effectuer des tâches d'auto-vérification (validation des tests, correction du style de code).[4]

2. **Standards & Conventions:** Elle dicte les règles de *Software Craftsmanship*, y compris les conventions de nommage (ex: `camelCase` pour les fonctions, `PascalCase` pour les classes).[4] L'efficacité de cette section est maximisée par l'inclusion d'exemples de code réels annotés "Good" vs. "Bad" pour ancrer visuellement les attentes.[4]

3. **Boundaries (Garde-fous Architecturaux):** Cette section est la plus critique pour la sécurité et la gouvernance. Elle utilise une sémantique à trois niveaux pour définir les limites d'agence [4]:

◦ **✓ Always:** Actions obligatoires (ex: `Write to src/ and tests/`).

◦ **⚠️ Ask First:** Actions nécessitant une confirmation explicite (ex: `Database schema changes`).

◦ **❌ Never:** Interdictions absolues (ex: `Commit secrets or API keys`, `Never remove failing tests`).[4]

# **III. Matrice de Compatibilité et Évaluation des Agents Actuels**

Bien que le standard `AGENTS.md` soit ouvert, sa consommation varie selon les fournisseurs d'agents. Un architecte doit comprendre comment chaque outil intègre ce contexte dans son pipeline d'inférence.

## **3.1. Analyse Détaillée de la Consommation de `AGENTS.md`**

Le marché utilise principalement deux mécanismes: l'indexation sémantique et les règles propriétaires persistantes.

| Agent d'IA | Support Explicite `AGENTS.md` | Mécanisme de Contexte Principal | Mode de Consommation des Règles | Notes d'Interopérabilité |
| --- | --- | --- | --- | --- |
| **GitHub Copilot** | Implicite | Indexation Sémantique Distante/Locale | Consultation des fichiers les plus sémantiquement similaires [10, 11] | Le contenu de `AGENTS.md` est intégré via des embeddings. Sa pertinence dépend de la qualité de l'indexation par rapport à la requête.[10] |
| **Cursor** | Explicite (via Project Rules) | Fichiers `.cursor/rules` (MDC) | Contexte persistant inclus au début de chaque session, *scopeé* par chemin de répertoire.[12] | Utilise un format similaire (.mdc) dans un répertoire `.cursor/rules`. Nécessite une adaptation/traduction du standard `AGENTS.md` principal.[12] |
| **Claude Code** | Explicite (via `CLAUDE.md`/Skills) | Agent Skills et Exécution de Code Local | Utilise des répertoires de "Skills" (contenant `SKILL.md`) pour encapsuler l'expertise et les commandes.[7, 13] | Grande capacité d'exécution d'outils locaux, faisant des commandes dans `AGENTS.md` des appels de fonctions concrets.[7] |
| **Gemini Code Assist** | Implicite/Via Protocoles | Très Grande Fenêtre de Contexte (1M tokens) | Inclusion directe de larges contextes de projet (CAG).[14] | S'appuie sur le Model Context Protocol (MCP) pour intégrer le contexte et les outils de manière sécurisée.[15] |

## **3.2. Le Model Context Protocol (MCP) : Le Standard d'Interchangeabilité**

Le Model Context Protocol (MCP) est un standard ouvert conçu pour permettre aux assistants IA de se connecter de manière sécurisée aux sources de données externes et aux outils locaux.[15] Ce protocole représente la couche architecturale qui permet de transformer les directives statiques de l'`AGENTS.md` en actions sécurisées et vérifiables (Tool-Calling).

L'utilisation du MCP permet à l'agent de consulter des sources d'information dynamiques (RAG) ou d'exécuter des linters locaux (conformément aux commandes spécifiées dans `AGENTS.md`), tout en maintenant le contrôle de l'exécution et la sécurité au niveau de la machine locale.[15] Pour l'architecte, cela signifie que les commandes définies dans `AGENTS.md` doivent être conçues comme des appels d'outils concrets que l'agent, via un protocole comme le MCP, pourra invoquer et dont il pourra analyser le résultat.

## **3.3. Standardisation et Abstraction**

Bien que le marché utilise des formats légèrement différents (ex: Cursor avec `.cursor/rules`), l'architecte doit maintenir l'`AGENTS.md` à la racine comme la source de vérité de la gouvernance. La meilleure pratique consiste à utiliser des scripts de CI/CD pour générer et synchroniser les formats propriétaires à partir du manifeste `AGENTS.md` principal.[16] La valeur est dans la sémantique — l'ensemble des règles (Persona, Commands, Boundaries) doit être cohérent, même si le format de sérialisation varie légèrement.

# **IV. Génération et Stratégies de Maintenance**

Un fichier `AGENTS.md` performant est un document vivant. Son processus de création et de maintenance doit être itératif et ancré dans la réalité de la base de code.

## **4.1. Initialisation : Générer un `AGENTS.md` à partir d'un Code Existant**

L'initialisation peut être accélérée par l'IA. De nombreux outils offrent des fonctionnalités pour générer un brouillon initial en analysant le dépôt (ex: la commande `/init` de certains agents).[13] Ces outils examinent la structure des dossiers, les dépendances (`package.json`), les configurations de linters (`.eslintrc`), et les fichiers de workflow CI/CD pour déduire les commandes de build et de test.[13, 17]

Cependant, il est essentiel de ne pas faire aveuglément confiance aux fichiers auto-générés.[17] Ces outils sont excellents pour détecter les modèles syntaxiques évidents mais manquent souvent les nuances spécifiques de *Software Craftsmanship*, de sécurité ou de logique DDD. L'architecte doit toujours considérer le fichier généré comme un point de départ nécessitant un affinement humain pour injecter la sagesse architecturale et les conventions non écrites.

## **4.2. Enrichissement par Analyse Statique et Conventions Existantes**

Pour garantir l'alignement entre les règles d'IA et les règles de CI/CD, l'`AGENTS.md` doit intégrer les résultats de l'analyse statique existante. Les outils d'analyse (comme SwiftLint, ShellCheck, ou des configurations ESLint complexes [18]) formalisent déjà les règles de style. L'architecte peut créer des scripts qui sérialisent ces configurations en sections Markdown digestes, garantissant que l'IA reçoit les mêmes contraintes de qualité que le linter.

## **4.3. `AGENTS.md` comme Document Vivant : Les Boucles de Rétroaction**

La maintenance doit être intégrée au cycle de développement. L'erreur d'un agent doit devenir une opportunité pour améliorer le contexte.

Chaque fois qu'un agent génère une solution incorrecte, une vulnérabilité, ou enfreint une règle architecturale (une *hallucination* ou une déviation de la norme), cela signale une ambiguïté dans le contexte fourni. Ce constat doit déclencher un processus de révision de l'`AGENTS.md`.[17] La règle défaillante doit être rendue plus concrète, soit par l'ajout d'exemples (Few-Shot), soit par une reformulation plus impérative. Le fichier `AGENTS.md` doit être sous contrôle de version (Git) afin de suivre l'évolution de la gouvernance et de pouvoir comparer les performances des agents entre différentes versions de règles.[16]

# **V. Optimisation du Contexte et Efficacité Token**

L'ingénierie du contexte est l'art d'utiliser l'espace limité de la fenêtre de tokens pour obtenir les meilleurs résultats possibles, en équilibrant la concision et la précision.[5]

## **5.1. Concision vs. Précision : La Densité d'Information**

Des prompts excessivement longs, même avec des LLMs à grandes fenêtres de contexte (comme Gemini 1M tokens [14]), peuvent diluer l'information cruciale et réduire la cohérence du résultat.[19] L'objectif est de maximiser la densité d'information pertinente par token.

La **précision** n'est pas synonyme de longueur. Pour les contraintes architecturales complexes, il est souvent plus efficace de fournir des **exemples concrets** (Few-Shot Examples) que des explications théoriques détaillées. Les exemples de code annotés "Good vs. Bad" dans `AGENTS.md` fournissent une compréhension sémantique profonde des attentes en matière de style et d'architecture, sans consommer un grand nombre de tokens en prose.[5] La concision doit être appliquée aux instructions de base, en utilisant un langage direct et simple pour définir le rôle de l'agent.[5]

## **5.2. Techniques d'Économie de Tokens**

Les architectes doivent employer des techniques avancées pour compresser les règles de qualité dans le contexte:

- **Le Meta Prompting:** Cette technique se concentre sur les aspects structurels des tâches plutôt que sur les détails spécifiques de contenu.[20] Pour l'`AGENTS.md`, cela signifie formuler des instructions qui ciblent la forme architecturale. Par exemple, au lieu de décrire la logique métier, exiger que "toutes les fonctions gérant des opérations échouables DOIVENT retourner un objet `Result<T, E>`." Cette approche réduit le nombre de tokens nécessaires en exploitant la connaissance structurelle innée du modèle.
- **Compaction et Abstraction:** Les agents autonomes peuvent utiliser des techniques de *Structured Note-Taking* pour résumer l'historique de la conversation ou les résultats intermédiaires, réduisant ainsi le volume de données récurrentes injectées dans le prompt.[5]

## **5.3. Gestion du Savoir Externe (RAG vs. CAG)**

La connaissance nécessaire à un projet se divise en deux catégories, gérées par deux stratégies distinctes d'intégration du contexte:

1. **Context Augmented Generation (CAG) / Inclusion Directe:** Cette approche utilise les très grandes fenêtres de contexte disponibles pour injecter directement des corpus de connaissances (comme des glossaires DDD complets ou des configurations stables).[21] Ceci garantit un accès immédiat et constant à la connaissance fondamentale. **Recommandation:** Utiliser le CAG (via l'`AGENTS.md` lui-même) pour les règles architecturales *stables et fondamentales* (SOLID, conventions, limites de l'agent).

2. **Retrieval Augmented Generation (RAG):** Le RAG permet de récupérer dynamiquement des fragments de documents pertinents (ex: documentation API interne, normes légales) et de les insérer dans le prompt au moment de la requête.[6, 22] Le RAG est idéal pour les connaissances *dynamiques* ou *massives* qui ne nécessitent pas d'être dans le contexte à chaque inférence. L'`AGENTS.md` doit référencer ces sources RAG via des `@-mentions` ou des définitions de Tools (Tool Descriptions).[3, 23]

L'approche optimale combine les deux: `AGENTS.md` fournit le *system prompt* et les règles de gouvernance par CAG, tandis que l'agent utilise des outils RAG pour se *grounder* dans la documentation technique dynamique.

# **VI. Enforcing Craftsmanship : Programmer l'Excellence du Code**

L'`AGENTS.md` est le vecteur par lequel l'architecte impose les méthodologies de développement de haute qualité (Software Craftsmanship).

## **6.1. Forcer le TDD (Test Driven Development)**

Pour éviter que l'IA ne génère du code non testé ou mal spécifié, l'`AGENTS.md` doit imposer un **Protocole TDD Séquentiel** via des instructions claires.[24, 25]

Le protocole doit être formulé comme une séquence d'étapes non négociables que l'agent doit déclarer avant d'agir:

1. **Phase Red:** L'agent **DOIT** commencer par écrire un test unitaire unique et échouant, définissant clairement la signature de la fonction et le comportement attendu pour un cas minimal.[26]

2. **Phase Green:** L'agent doit ensuite implémenter la quantité **MINIMALE** de code pour faire passer le test.

3. **Phase Refactor:** Une fois le test passé, l'agent doit systématiquement analyser le code pour les *code smells*, appliquer les principes SOLID et refactoriser, tout en s'assurant que tous les tests restent au vert.[25]

Cette approche transforme le TDD en ingénierie de prompt en fournissant à l'agent un contrat formel (le test) avant de générer l'implémentation, réduisant ainsi l'ambiguïté.[26]

## **6.2. Intégration du DDD (Domain Driven Design)**

Le DDD requiert une adhésion stricte au *langage ubiquitaire* et à la structure du domaine. L'`AGENTS.md` doit l'assurer:

1. **Référence de Modèle:** Référencer explicitement le document de définition du domaine (ex: `@domain/shipping_model.yaml`).

2. **Contrainte de Langue:** L'agent doit être instruit d'**UTILISER TOUJOURS** les termes précis du langage ubiquitaire (ex: 'ShipmentAggregate' au lieu de 'package').

3. **Contraintes de Modélisation:** Exiger que le code généré respecte les limites des *Bounded Contexts*, crée des Entités mutables uniquement par des méthodes d'Agrégat, et utilise des Value Objects pour l'immutabilité.

## **6.3. Imposer les Principes SOLID, KISS et DRY**

Les principes de conception doivent être injectés comme des contraintes dans la section `Standards`.[27]

- **Single Responsibility Principle (SRP):** Définir une règle impérative stipulant que si l'agent identifie une classe gérant plusieurs préoccupations (ex: traitement des données *et* logique métier), il **DOIT** la refactoriser en classes séparées (ex: `DataPreprocessor` et `BusinessService`).[27]
- **KISS (Keep It Simple, Stupid) et Auto-Réflexion:** Les LLMs ont une tendance documentée à la sur-ingénierie.[28] Pour contrer cela, il est nécessaire d'intégrer une étape de **Self-Reflection** (voir Section VIII). L'agent doit s'auto-questionner: "Existe-t-il une solution plus simple, plus élégante et plus robuste qui adhère aux principes KISS et DRY? Produire un score de confiance (1-10) et la justification de l'approche la plus simple avant de générer le code".[28]

# **VII. Sécurité et Gestion des Secrets**

La sécurité fait partie intégrante de la gouvernance architecturale, en particulier la défense contre les risques listés dans l'OWASP LLM Top 10.[29, 30]

## **7.1. Prévention de la Fuite de Données Sensibles (OWASP LLM06)**

Le risque de divulgation de données sensibles est géré en isolant strictement les secrets du contexte du prompt.[31]

- **Règles "Never" Strictes:** La section `Boundaries` de l'`AGENTS.md` doit contenir des interdictions absolues: **NEVER** inclure des clés API, des mots de passe ou des tokens d'authentification codés en dur dans le code généré ou dans les exemples. **NEVER** référencer des fichiers secrets (comme `.env`).[4]
- **Gestion Externe des Secrets:** L'IA doit être instruite d'utiliser le mécanisme d'accès aux secrets de l'organisation (ex: Vault client) plutôt que de connaître ou de suggérer le secret lui-même.[31]

## **7.2. Contrôle de la Génération de Code Insecure (OWASP LLM02)**

L'agent doit être programmé pour adhérer aux pratiques de codage sécurisé dès la conception (*Secure by Design*).[32]

- **Règles de Code Sécurisé:** `AGENTS.md` doit exiger des mesures préventives spécifiques:

◦ **Input Validation:** "ALWAYS valider et nettoyer toutes les entrées utilisateur externes avant le traitement ou l'intégration dans des requêtes (SQL, Shell)."

◦ **Principe de Moindre Privilège:** "Le code d'intégration des services DOIT opérer sous le Principe de Moindre Privilège."

◦ **Interdiction des Fonctions Dangereuses:** "NEVER utiliser de fonctions d'exécution non sécurisées (ex: `eval()`)."

- **Enforcement Indépendant:** Il est crucial de reconnaître que l'IA est susceptible aux attaques par injection de prompt (LLM01). Par conséquent, les contrôles de sécurité (linters de sécurité, analyse statique) doivent être appliqués **indépendamment de l'IA** après la génération du code.[29, 31] `AGENTS.md` doit inclure des commandes pour exécuter ces outils de vérification (ex: `npm audit`).

## **7.3. Nettoyage (Sanitization) des Instructions**

Le système d'orchestration de l'agent doit garantir que les données brutes de l'environnement ou de l'utilisateur ne sont pas divulguées au modèle. La *Data Redaction* (masquage ou remplacement des PII par des substituts génériques) doit être effectuée sur les entrées avant qu'elles ne soient transmises au LLM.[32]

# **VIII. Audit et Observabilité : Vérification de l'Adhérence Agentique**

L'audit prouve que la gouvernance architecturale définie dans `AGENTS.md` a été respectée.[33] Il ne suffit pas que le code soit correct ; il faut la **preuve** que l'agent a suivi les règles.

## **8.1. Déterminer l'Adhérence : Le Concept de Preuve d'Exécution**

Dans les systèmes agents complexes, il est possible que l'agent hallucine ou ignore des contraintes conflictuelles.[34] Pour pallier cela, l'agent doit être contraint à suivre un plan structuré et à générer un artefact de vérification.

Si `AGENTS.md` est le contrat de travail de l'agent, celui-ci doit fournir une **trace d'audit interne** démontrant qu'il a consulté ce contrat. L'évaluation de l'agent doit donc aller au-delà de la qualité du texte généré pour inclure les étapes de raisonnement, les appels d'outils et l'alignement avec les politiques.[33]

## **8.2. Auto-Réflexion et Preuve de Conformité**

La technique de *Self-Reflection* est la méthode la plus fiable pour forcer l'agent à intégrer et à valider son adhésion aux règles.[35, 36]

**Protocole d'Auto-Évaluation:**

1. L'agent est instruit de définir une **rubrique d'excellence** basée sur les exigences de l'`AGENTS.md` (ex: "Conformité à SOLID-LSP", "Adhésion au TDD-Refactor Phase").

2. L'agent doit ensuite **critiquer sa propre solution provisoire** en fonction de cette rubrique.

3. L'agent doit **produire cette auto-critique dans un format structuré (JSON)** pour validation externe avant de donner la réponse finale.[35, 36, 37] Cette sortie structurée permet d'utiliser des outils automatisés (LLM-as-judge) pour vérifier l'adhérence.

## **8.3. Logging Structuré et Télémétrie LLM**

Pour l'audit de conformité, l'interaction avec l'agent doit être traitée comme un flux de télémétrie, routé et enrichi dans un pipeline d'observabilité.[38, 39]

Afin d'éviter le "wall of text" et de permettre une analyse lisible, les prompts et les réponses doivent être loggés dans un format structuré, idéalement JSON, en utilisant un schéma défini.[37, 38]

Les champs d'audit critiques pour la gouvernance sont ceux qui lient l'action de l'agent à la version spécifique des règles [38, 40]:

Schéma d'Audit Critique pour l'Adhérence LLM

| **Champ** | **Description** | **Justification Architecturale** |
| --- | --- | --- |
| `timestamp` | Moment de l'inférence. | Traçabilité légale et chronologique.[39] |
| `user_id` | Développeur initiant la requête. | Identification de la responsabilité.[38] |
| `project_context_hash` | Hachage Git de la version d'AGENTS.md utilisée. | **Preuve de la version de la gouvernance appliquée.** |
| `compliance_assessment` | Résultat structuré de l'auto-évaluation de l'agent (TDD/SOLID/KISS adherence).[37] | Permet l'évaluation automatisée de la non-régression. |
| `prompt_tokens` | Nombre de tokens d'entrée et de sortie. | Métrique de coût et d'efficacité.[39] |
| `source_references` | Liste des fichiers du projet (ou documents RAG) lus par l'agent.[40] | Vérification des sources utilisées par l'agent pour éviter l'hallucination basée sur un contexte insuffisant.[10] |
| `tool_calls` | Liste des commandes exécutées par l'agent. | Audit des actions potentielles sur le système de fichiers ou les dépendances.[33] |

# **IX. Bonnes Pratiques et Anti-Patterns**

## **9.1. Les "Do's" : Créer un `AGENTS.md` Archétype**

- **Spécialisation de la Persona:** Toujours définir une persona claire et spécialisée (ex: `@test-agent`, `@docs-agent`) plutôt qu'un "assistant généraliste".[4]
- **Gouvernance des Risques:** Utiliser systématiquement la sémantique **Always/Ask First/Never** dans les `Boundaries` pour contrôler l'agence et les risques.[4]
- **Ancrage par l'Exemple:** Inclure des exemples de code concrets (Few-Shot) dans la section `Standards` pour renforcer la compréhension des conventions.[4]
- **Auto-Validation:** Fournir des **Commandes Exécutables** qui permettent à l'agent de tester et de linter son propre code, créant une boucle de vérification intégrée.[4]
- **Formalisation de l'Output:** Mandater un **Output Structuré (JSON Schema)** pour toutes les réponses nécessitant des données précises (ex: rapports d'audit, payloads d'API).[37]

## **9.2. Les "Don'ts" : Éviter l'Ambiguïté et la Surcharge d'Agence**

- **Vague Instructions:** Ne pas écrire de contexte vague ou philosophique. Les instructions doivent être simples, directes, et impératives.[5]
- **Surcharge d'Information:** Éviter d'inclure des données sensibles ou de surcharger le contexte avec des informations obsolètes ou non pertinentes.[31] Privilégier le RAG pour le savoir massif ou dynamique.
- **Confiance Aveugle:** Ne jamais faire entièrement confiance aux fichiers générés automatiquement sans les auditer et y injecter manuellement les nuances de *Software Craftsmanship*.[17]
- **Oubli du Suivi:** Ne pas omettre d'exiger une trace d'auto-réflexion ou d'évaluation de conformité de la part de l'agent (ne pas se contenter de l'output, exiger la justification).
- **Excessive Agency:** Ne pas accorder à l'agent le pouvoir de prendre des décisions critiques de sécurité ou d'architecture sans un point de friction (`Ask First` ou révision humaine) pour éviter l'Excessive Agency (LLM08).[29]

# **Conclusion**

L'adoption du standard `AGENTS.md` marque une étape décisive vers la maturité de l'ingénierie logicielle assistée par IA. Pour un architecte, ce fichier est l'outil le plus puissant pour passer d'une simple assistance au codage à une véritable **gouvernance architecturale programmatique**.

En imposant le standard `AGENTS.md`, les équipes d'élite s'assurent que:

1. **Le Craftsmanship est Forcé:** Les contraintes méthodologiques (TDD, DDD, SOLID) sont injectées directement dans le *system prompt* et vérifiées par un mécanisme d'auto-réflexion structuré.

2. **La Sécurité est Préventive:** Les règles `Never` et la gestion externe des secrets minimisent le risque de fuite d'information (LLM06), tandis que les commandes exécutables permettent une auto-vérification de la sécurité (LLM02).

3. **L'Adhérence est Auditable:** L'exigence de logs structurés, incluant le hachage de la version d'`AGENTS.md` et les preuves de conformité, fournit une traçabilité essentielle pour la conformité réglementaire et l'amélioration continue des agents.

`AGENTS.md` est, en définitive, le contrat de travail détaillé qui transforme l'IA générative en un co-développeur junior hautement qualifié, contraint de maintenir les standards d'excellence du projet à chaque itération.

## Références

1. openai/agents.md: AGENTS.md — a simple, open format for guiding coding agents - GitHub, [https://github.com/openai/agents.md](https://www.google.com/url?sa=E&q=https%3A%2F%2Fgithub.com%2Fopenai%2Fagents.md)

2. AGENTS.md, [https://agents.md/](https://www.google.com/url?sa=E&q=https%3A%2F%2Fagents.md%2F)

3. This repository defines AGENT.md, a standardized format that lets your codebase speak directly to any agentic coding tool. - GitHub, [https://github.com/agentmd/agent.md](https://www.google.com/url?sa=E&q=https%3A%2F%2Fgithub.com%2Fagentmd%2Fagent.md)

4. How to write a great agents.md: Lessons from over 2,500 repositories - The GitHub Blog, [https://github.blog/ai-and-ml/github-copilot/how-to-write-a-great-agents-md-lessons-from-over-2500-repositories/](https://www.google.com/url?sa=E&q=https%3A%2F%2Fgithub.blog%2Fai-and-ml%2Fgithub-copilot%2Fhow-to-write-a-great-agents-md-lessons-from-over-2500-repositories%2F)

5. Effective context engineering for AI agents - Anthropic, [https://www.anthropic.com/engineering/effective-context-engineering-for-ai-agents](https://www.google.com/url?sa=E&q=https%3A%2F%2Fwww.anthropic.com%2Fengineering%2Feffective-context-engineering-for-ai-agents)

6. Context Engineering: The Discipline Behind Reliable LLM Applications & Agents, [https://www.comet.com/site/blog/context-engineering/](https://www.google.com/url?sa=E&q=https%3A%2F%2Fwww.comet.com%2Fsite%2Fblog%2Fcontext-engineering%2F)

7. Equipping agents for the real world with Agent Skills - Anthropic, [https://www.anthropic.com/engineering/equipping-agents-for-the-real-world-with-agent-skills](https://www.google.com/url?sa=E&q=https%3A%2F%2Fwww.anthropic.com%2Fengineering%2Fequipping-agents-for-the-real-world-with-agent-skills)

8. What Is Agents.md? A Complete Guide to the New AI Coding Agent Standard in 2025, [https://www.remio.ai/post/what-is-agents-md-a-complete-guide-to-the-new-ai-coding-agent-standard-in-2025](https://www.google.com/url?sa=E&q=https%3A%2F%2Fwww.remio.ai%2Fpost%2Fwhat-is-agents-md-a-complete-guide-to-the-new-ai-coding-agent-standard-in-2025)

9. Best practices for using GitHub Copilot, [https://docs.github.com/en/copilot/get-started/best-practices](https://www.google.com/url?sa=E&q=https%3A%2F%2Fdocs.github.com%2Fen%2Fcopilot%2Fget-started%2Fbest-practices)

10. How Copilot Chat uses context - Visual Studio (Windows) - Microsoft Learn, [https://learn.microsoft.com/en-us/visualstudio/ide/copilot-context-overview?view=visualstudio](https://www.google.com/url?sa=E&q=https%3A%2F%2Flearn.microsoft.com%2Fen-us%2Fvisualstudio%2Fide%2Fcopilot-context-overview%3Fview%3Dvisualstudio)

11. Understanding the Contextual Scope of GitHub Copilot #69280, [https://github.com/orgs/community/discussions/69280](https://www.google.com/url?sa=E&q=https%3A%2F%2Fgithub.com%2Forgs%2Fcommunity%2Fdiscussions%2F69280)

12. Rules | Cursor Docs, [https://cursor.com/docs/context/rules](https://www.google.com/url?sa=E&q=https%3A%2F%2Fcursor.com%2Fdocs%2Fcontext%2Frules)

13. Using CLAUDE.MD files: Customizing Claude Code for your codebase, [https://www.claude.com/blog/using-claude-md-files](https://www.google.com/url?sa=E&q=https%3A%2F%2Fwww.claude.com%2Fblog%2Fusing-claude-md-files)

14. Gemini Code Assist | AI coding assistant, [https://codeassist.google/](https://www.google.com/url?sa=E&q=https%3A%2F%2Fcodeassist.google%2F)

15. Introducing the AWS Infrastructure as Code MCP Server: AI-Powered CDK and CloudFormation Assistance, [https://aws.amazon.com/blogs/devops/introducing-the-aws-infrastructure-as-code-mcp-server-ai-powered-cdk-and-cloudformation-assistance/](https://www.google.com/url?sa=E&q=https%3A%2F%2Faws.amazon.com%2Fblogs%2Fdevops%2Fintroducing-the-aws-infrastructure-as-code-mcp-server-ai-powered-cdk-and-cloudformation-assistance%2F)

16. Prompt engineering best practices: Data-driven optimization guide - Articles - Braintrust, [https://www.braintrust.dev/articles/systematic-prompt-engineering](https://www.google.com/url?sa=E&q=https%3A%2F%2Fwww.braintrust.dev%2Farticles%2Fsystematic-prompt-engineering)

17. Mastering Project Context Files for AI Coding Agents - EclipseSource, [https://eclipsesource.com/blogs/2025/11/20/mastering-project-context-files-for-ai-coding-agents/](https://www.google.com/url?sa=E&q=https%3A%2F%2Feclipsesource.com%2Fblogs%2F2025%2F11%2F20%2Fmastering-project-context-files-for-ai-coding-agents%2F)

18. analysis-tools-dev/static-analysis: ⚙️ A curated list of static analysis (SAST) tools and linters for all programming languages, config files, build tools, and more. The focus is on tools which improve code quality. - GitHub, [https://github.com/analysis-tools-dev/static-analysis](https://www.google.com/url?sa=E&q=https%3A%2F%2Fgithub.com%2Fanalysis-tools-dev%2Fstatic-analysis)

19. The Power of Concise Prompts in Large Language Models, [https://promptengineering.org/the-power-of-concise-prompts-in-large-language-models/](https://www.google.com/url?sa=E&q=https%3A%2F%2Fpromptengineering.org%2Fthe-power-of-concise-prompts-in-large-language-models%2F)

20. Meta Prompting | Prompt Engineering Guide, [https://www.promptingguide.ai/techniques/meta-prompting](https://www.google.com/url?sa=E&q=https%3A%2F%2Fwww.promptingguide.ai%2Ftechniques%2Fmeta-prompting)

21. Architectural Strategies for External Knowledge Integration in LLMs: A Comparative Analysis of RAG and CAG - DEV Community, [https://dev.to/foxgem/architectural-strategies-for-external-knowledge-integration-in-llms-a-comparative-analysis-of-rag-23d6](https://www.google.com/url?sa=E&q=https%3A%2F%2Fdev.to%2Ffoxgem%2Farchitectural-strategies-for-external-knowledge-integration-in-llms-a-comparative-analysis-of-rag-23d6)

22. External Knowledge: Why Augmented Language Models Need More Than What They're Trained On - Label Studio, [https://labelstud.io/learningcenter/external-knowledge-why-augmented-language-models-need-more-than-what-they-re-trained-on/](https://www.google.com/url?sa=E&q=https%3A%2F%2Flabelstud.io%2Flearningcenter%2Fexternal-knowledge-why-augmented-language-models-need-more-than-what-they-re-trained-on%2F)

23. @ Mentions | Cursor Docs, [https://cursor.com/docs/context/mentions](https://www.google.com/url?sa=E&q=https%3A%2F%2Fcursor.com%2Fdocs%2Fcontext%2Fmentions)

24. Mastering prompt engineering across the software development lifecycle - Hasgeek, [https://hasgeek.com/fifthelephant/mastering-prompt-engineering-across-the-software-development-lifecycle/](https://www.google.com/url?sa=E&q=https%3A%2F%2Fhasgeek.com%2Ffifthelephant%2Fmastering-prompt-engineering-across-the-software-development-lifecycle%2F)

25. Kent Beck's TDD System Prompt (from https://tidyfirst.substack.com/p/augmented-coding-beyond-the-vibes) · GitHub - GitHub Gist, [https://gist.github.com/spilist/8bbf75568c0214083e4d0fbbc1f8a09c](https://www.google.com/url?sa=E&q=https%3A%2F%2Fgist.github.com%2Fspilist%2F8bbf75568c0214083e4d0fbbc1f8a09c)

26. Test-driven development as prompt engineering - David Luhr, [https://luhr.co/blog/2024/02/07/test-driven-development-as-prompt-engineering/](https://www.google.com/url?sa=E&q=https%3A%2F%2Fluhr.co%2Fblog%2F2024%2F02%2F07%2Ftest-driven-development-as-prompt-engineering%2F)

27. How to Apply SOLID Principles in AI Development Using Prompt Engineering - Syncfusion, [https://www.syncfusion.com/blogs/post/solid-principles-ai-development](https://www.google.com/url?sa=E&q=https%3A%2F%2Fwww.syncfusion.com%2Fblogs%2Fpost%2Fsolid-principles-ai-development)

28. Re: Over-engineered nightmares, here's a prompt that's made my life SO MUCH easier, [https://www.reddit.com/r/ChatGPTCoding/comments/1j48skd/re_overengineered_nightmares_heres_a_prompt_thats/](https://www.google.com/url?sa=E&q=https%3A%2F%2Fwww.reddit.com%2Fr%2FChatGPTCoding%2Fcomments%2F1j48skd%2Fre_overengineered_nightmares_heres_a_prompt_thats%2F)

29. OWASP LLM Top 10: How it Applies to Code Generation | Learn Article - Sonar, [https://www.sonarsource.com/resources/library/owasp-llm-code-generation/](https://www.google.com/url?sa=E&q=https%3A%2F%2Fwww.sonarsource.com%2Fresources%2Flibrary%2Fowasp-llm-code-generation%2F)

30. OWASP Top Ten, [https://owasp.org/www-project-top-ten/](https://www.google.com/url?sa=E&q=https%3A%2F%2Fowasp.org%2Fwww-project-top-ten%2F)

31. LLM07:2025 System Prompt Leakage - OWASP Gen AI Security Project, [https://genai.owasp.org/llmrisk/llm072025-system-prompt-leakage/](https://www.google.com/url?sa=E&q=https%3A%2F%2Fgenai.owasp.org%2Fllmrisk%2Fllm072025-system-prompt-leakage%2F)

32. Is Your LLM Leaking Sensitive Data? A Developer's Guide to Preventing Sensitive Information Disclosure - Pangea Cloud, [https://pangea.cloud/blog/a-developers-guide-to-preventing-sensitive-information-disclosure/](https://www.google.com/url?sa=E&q=https%3A%2F%2Fpangea.cloud%2Fblog%2Fa-developers-guide-to-preventing-sensitive-information-disclosure%2F)

33. What is AI Agent Evaluation? | IBM, [https://www.ibm.com/think/topics/ai-agent-evaluation](https://www.google.com/url?sa=E&q=https%3A%2F%2Fwww.ibm.com%2Fthink%2Ftopics%2Fai-agent-evaluation)

34. [2502.12197] A Closer Look at System Prompt Robustness - arXiv, [https://arxiv.org/abs/2502.12197](https://www.google.com/url?sa=E&q=https%3A%2F%2Farxiv.org%2Fabs%2F2502.12197)

35. GPT-5 prompting guide | OpenAI Cookbook, [https://cookbook.openai.com/examples/gpt-5/gpt-5_prompting_guide](https://www.google.com/url?sa=E&q=https%3A%2F%2Fcookbook.openai.com%2Fexamples%2Fgpt-5%2Fgpt-5_prompting_guide)

36. 5 prompt engineering techniques for legal work - Thomson Reuters Legal Solutions, [https://legal.thomsonreuters.com/blog/prompt-engineering-best-ai-output/](https://www.google.com/url?sa=E&q=https%3A%2F%2Flegal.thomsonreuters.com%2Fblog%2Fprompt-engineering-best-ai-output%2F)

37. JSON prompting for LLMs - IBM Developer, [https://developer.ibm.com/articles/json-prompting-llms/](https://www.google.com/url?sa=E&q=https%3A%2F%2Fdeveloper.ibm.com%2Farticles%2Fjson-prompting-llms%2F)

38. How are you preparing LLM audit logs for compliance? : r/Observability - Reddit, [https://www.reddit.com/r/Observability/comments/1knejrx/how_are_you_preparing_llm_audit_logs_for/](https://www.google.com/url?sa=E&q=https%3A%2F%2Fwww.reddit.com%2Fr%2FObservability%2Fcomments%2F1knejrx%2Fhow_are_you_preparing_llm_audit_logs_for%2F)

39. Set Up Logging for LLM APIs in Azure API Management - Microsoft Learn, [https://learn.microsoft.com/en-us/azure/api-management/api-management-howto-llm-logs](https://www.google.com/url?sa=E&q=https%3A%2F%2Flearn.microsoft.com%2Fen-us%2Fazure%2Fapi-management%2Fapi-management-howto-llm-logs)

40. Audit logs for Copilot and AI applications - Microsoft Learn, [https://learn.microsoft.com/en-us/purview/audit-copilot](https://www.google.com/url?sa=E&q=https%3A%2F%2Flearn.microsoft.com%2Fen-us%2Fpurview%2Faudit-copilot)
