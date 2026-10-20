# MCU_Learn

STM32 / MCU 练手工程集合。每个子目录是一个独立可编译的工程，互不依赖。

## 工程列表

| 目录 | 芯片 | 框架 / 工具链 | 说明 |
| --- | --- | --- | --- |
| [`stm32f103-test/`](stm32f103-test/) | STM32F103xB (Cortex-M3) | STM32CubeMX + HAL + CMake | 基础点灯 / 串口工程模板 |

## 目录约定

```
MCU_Learn/
├── stm32f103-test/          # 单个工程，独立自包含
│   ├── Core/                # 应用代码（main.c / gpio.c / usart.c 等）
│   ├── Drivers/             # CMSIS + STM32xx HAL 驱动
│   ├── cmake/               # 工具链文件（gcc-arm-none-eabi.cmake）
│   ├── build/               # 编译输出（已 gitignore，不进仓库）
│   ├── test.ioc             # CubeMX 工程文件
│   ├── CMakeLists.txt
│   └── CMakePresets.json
└── .gitignore               # 仓库级忽略规则
```

新增工程时，在根目录下再建一个子目录（如 `stm32f407-uart/`），
把对应 CubeMX 工程放进去即可；各工程自带 `.gitignore` 负责本工程的 `build/`。

## 编译

进入具体工程目录：

```bash
cd stm32f103-test
cmake --preset Debug      # 生成构建目录
cmake --build build/Debug # 编译
```

依赖 `arm-none-eabi-gcc`。用 STM32CubeMX / STM32CubeIDE 打开工程时，
直接打开对应子目录下的 `.ioc` 文件。

## 关于 `build/`

`build/` 内的 `CMakeCache.txt` 记录的是**绝对路径**，因此工程目录一旦移动，
需要先清空 `build/` 再重新用 `cmake --preset` 生成，否则 CMake 会报缓存路径不一致。
