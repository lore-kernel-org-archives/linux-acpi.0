From: "hongbo.zhang" <hongbo.zhang@linaro.org>
Subject: [PATCH V5 0/2] Upstream ST-Ericsson thermal driver
Date: Fri,  9 Nov 2012 19:29:06 +0800
Message-ID: <1352460548-3494-1-git-send-email-hongbo.zhang@linaro.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Sender: linux-pm-owner@vger.kernel.org
To: linux-acpi@vger.kernel.org, rui.zhang@intel.com
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, amit.kachhap@linaro.org, patches@linaro.org, linaro-dev@lists.linaro.org, linaro-kernel@lists.linaro.org, STEricsson_nomadik_linux@list.st.com, kernel@igloocommunity.org, "hongbo.zhang" <hongbo.zhang@linaro.com>
List-Id: linux-acpi@vger.kernel.org

From: "hongbo.zhang" <hongbo.zhang@linaro.com>

V4->V5 Changes:

In patch "Thermal: Add ST-Ericsson DB8500 thermal driver":
 - use flush_work instead of flush_work_sync since the later is deprecated now.
 - parameter trip_points of db8500_thermal_match_cdev is renamed to trip_point;
 - re-order oprerations in function db8500_thermal_update_config;

hongbo.zhang (2):
  Thermal: Add ST-Ericsson DB8500 thermal driver.
  Thermal: Add ST-Ericsson DB8500 thermal properties and platform data.

 .../devicetree/bindings/thermal/db8500-thermal.txt |  44 ++
 arch/arm/boot/dts/dbx5x0.dtsi                      |  14 +
 arch/arm/boot/dts/snowball.dts                     |  31 ++
 arch/arm/configs/u8500_defconfig                   |   2 +
 arch/arm/mach-ux500/board-mop500.c                 |  64 +++
 drivers/thermal/Kconfig                            |  20 +
 drivers/thermal/Makefile                           |   2 +
 drivers/thermal/db8500_cpufreq_cooling.c           | 108 +++++
 drivers/thermal/db8500_thermal.c                   | 531 +++++++++++++++++++++
 include/linux/platform_data/db8500_thermal.h       |  38 ++
 10 files changed, 854 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/db8500-thermal.txt
 create mode 100644 drivers/thermal/db8500_cpufreq_cooling.c
 create mode 100644 drivers/thermal/db8500_thermal.c
 create mode 100644 include/linux/platform_data/db8500_thermal.h

-- 
1.7.11.3

