From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 3/3] drm/etnaviv: add thermal dependency
Date: Wed, 26 Jul 2017 15:53:12 +0200
Message-ID: <20170726135312.2214309-4-arnd@arndb.de>
References: <20170726135312.2214309-1-arnd@arndb.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170726135312.2214309-1-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: dri-devel@lists.freedesktop.org
Cc: Arnd Bergmann <arnd@arndb.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Lucas Stach <l.stach@pengutronix.de>, Russell King <linux+etnaviv@armlinux.org.uk>, Christian Gmeiner <christian.gmeiner@gmail.com>, David Airlie <airlied@linux.ie>, Patrik Jakobsson <patrik.r.jakobsson@gmail.com>, Daniel Vetter <daniel.vetter@intel.com>, Jani Nikula <jani.nikula@linux.intel.com>, Ben Skeggs <bskeggs@redhat.com>, Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, Jens Frederich <jfrederich@gmail.com>, Daniel Drake <dsd@laptop.org>, Jon Nettleton <jon.nettleton@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, etnaviv@lists.freedesktop.o
List-Id: linux-acpi@vger.kernel.org

When CONFIG_THERMAL is enabled as a loadable module, and etnaviv is
built-in, we get a link error:

drivers/gpu/drm/etnaviv/etnaviv_gpu.o: In function `etnaviv_gpu_bind':
etnaviv_gpu.c:(.text.etnaviv_gpu_bind+0x34): undefined reference to `thermal_of_cooling_device_register'
etnaviv_gpu.c:(.text.etnaviv_gpu_bind+0xe0): undefined reference to `thermal_cooling_device_unregister'
drivers/gpu/drm/etnaviv/etnaviv_gpu.o: In function `etnaviv_gpu_unbind':
etnaviv_gpu.c:(.text.etnaviv_gpu_unbind+0xf0): undefined reference to `thermal_cooling_device_unregister'

This adds a Kconfig dependency to prevent etnaviv from being built-in
with CONFIG_THERMAL=m, while still allowing the valid configurations.
Unfortunately, simply adding the dependency here breaks Kconfig through
a dependency loop involving lots of symbols all the way until ACPI_VIDEO,
which is the only video driver that explicitly selects 'THERMAL'. Turning
this into a 'depends on' addresses the problem.
For completeness, I'm also removing the redundant 'select THERMAL'
from INTEL_MENLOW, so no other driver uses that statement.

Fixes: bcdfb5e56dc5 ("drm/etnaviv: add etnaviv cooling device")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
v2: spend more thought on ACPI_VIDEO dependencies, as we need another
    patch before this.
---
 drivers/acpi/Kconfig            | 2 +-
 drivers/gpu/drm/etnaviv/Kconfig | 1 +
 drivers/platform/x86/Kconfig    | 1 -
 3 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index a8f5a40e2914..1282b2936164 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -184,7 +184,7 @@ config ACPI_VIDEO
 	tristate "Video"
 	depends on X86
 	depends on INPUT
-	select THERMAL
+	depends on THERMAL
 	select BACKLIGHT_CLASS_DEVICE
 	select BACKLIGHT_LCD_SUPPORT
 	default y
diff --git a/drivers/gpu/drm/etnaviv/Kconfig b/drivers/gpu/drm/etnaviv/Kconfig
index 71cee4e9fefb..1d6c744e7924 100644
--- a/drivers/gpu/drm/etnaviv/Kconfig
+++ b/drivers/gpu/drm/etnaviv/Kconfig
@@ -3,6 +3,7 @@ config DRM_ETNAVIV
 	tristate "ETNAVIV (DRM support for Vivante GPU IP cores)"
 	depends on DRM
 	depends on ARCH_MXC || ARCH_DOVE || (ARM && COMPILE_TEST)
+	depends on THERMAL || THERMAL=n
 	depends on MMU
 	select SHMEM
 	select SYNC_FILE
diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index 2d9fb46a8d11..d9238e9ff54a 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -532,7 +532,6 @@ config SENSORS_HDAPS
 config INTEL_MENLOW
 	tristate "Thermal Management driver for Intel menlow platform"
 	depends on ACPI_THERMAL
-	select THERMAL
 	---help---
 	  ACPI thermal management enhancement driver on
 	  Intel Menlow platform.
-- 
2.9.0
