# Perfect Numbers

Aplicativo Flutter para verificar e encontrar números perfeitos.

Um número perfeito é um número inteiro positivo que é igual à soma de seus divisores próprios (excluindo ele mesmo). Exemplos: 6, 28, 496, 8128.

## Funcionalidades

1. **Verificar Número Perfeito** - Verifica se um número informado é perfeito e exibe seus divisores
2. **Encontrar em Range** - Encontra todos os números perfeitos entre dois valores

## Arquitetura

O projeto segue o padrão **MVVM** com **Clean Architecture** e princípios **SOLID**.

```
lib/
├── core/
│   └── result/                 # Classe Result para tratamento de erros
├── data/
│   ├── repositories/           # Implementações dos repositories
│   └── services/               # Serviços de cálculo
├── domain/
│   ├── entities/               # Entidades de domínio
│   ├── repositories/           # Interfaces dos repositories
│   └── usecases/               # Casos de uso
├── presentation/
│   ├── pages/                  # Páginas da aplicação
│   ├── viewmodels/             # ViewModels com ChangeNotifier
│   └── widgets/                # Widgets reutilizáveis
└── main.dart
```

## Tecnologias

- **Flutter** 3.11+
- **Provider** - Gerenciamento de estado
- **Material 3** - Design system

## Princípios SOLID

| Princípio | Aplicação |
|-----------|-----------|
| **S** - Single Responsibility | Cada classe tem uma única responsabilidade |
| **O** - Open/Closed | Classes extensíveis via interfaces |
| **L** - Liskov Substitution | Implementações substituíveis |
| **I** - Interface Segregation | Interfaces pequenas e específicas |
| **D** - Dependency Inversion | Dependências via abstrações |

## Como Executar

```bash
# Instalar dependências
flutter pub get

# Executar o app
flutter run

# Executar testes
flutter test

# Analisar código
flutter analyze
```

## Testes

O projeto possui **71 testes** cobrindo todas as camadas:

```
test/
├── data/
│   ├── repositories/
│   │   └── perfect_number_repository_test.dart    # 9 testes
│   └── services/
│       └── perfect_number_calculator_test.dart    # 23 testes
├── domain/
│   └── usecases/
│       ├── check_perfect_number_usecase_test.dart # 4 testes
│       └── find_perfect_numbers_usecase_test.dart # 4 testes
├── presentation/
│   └── viewmodels/
│       ├── check_number_viewmodel_test.dart       # 9 testes
│       ├── find_range_viewmodel_test.dart         # 11 testes
│       └── home_viewmodel_test.dart               # 4 testes
└── widget_test.dart                               # 7 testes
```

### Cenários Testados

- Números perfeitos válidos (6, 28, 496, 8128)
- Números não perfeitos
- Entradas inválidas (texto, vazio, negativos, zero)
- Range inválido (início > fim)
- Estados do ViewModel (loading, error, success, reset)
- Navegação entre abas
- Notificações de listeners

### Executar Testes

```bash
# Todos os testes
flutter test

# Com cobertura
flutter test --coverage

# Teste específico
flutter test test/data/services/perfect_number_calculator_test.dart
```

## Estrutura de Componentes

### Widgets Reutilizáveis

- `AppSnackbar` - Exibe mensagens de erro, alerta e sucesso
- `AppLoading` - Overlay de carregamento
- `CustomTextField` - Campo de texto customizado
- `LoadingButton` - Botão com estado de loading
- `ResultCard` - Card para exibição de resultados

### ViewModels

- `HomeViewModel` - Gerencia navegação entre abas
- `CheckNumberViewModel` - Gerencia verificação de número
- `FindRangeViewModel` - Gerencia busca em range

## Screenshots

O app possui duas telas principais acessíveis via navegação inferior:

1. **Verificar** - Input único para verificar se número é perfeito
2. **Range** - Dois inputs para buscar números perfeitos no intervalo


