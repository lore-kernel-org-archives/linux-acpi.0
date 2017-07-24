From: Thierry Reding <thierry.reding@gmail.com>
Subject: [PATCH 6/7] docs: driver-api: Add GPIO section
Date: Mon, 24 Jul 2017 16:57:27 +0200
Message-ID: <20170724145728.7662-6-thierry.reding@gmail.com>
References: <20170724145728.7662-1-thierry.reding@gmail.com>
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <20170724145728.7662-1-thierry.reding@gmail.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Jonathan Corbet <corbet@lwn.net>, linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

This adds a section about the various parts of the GPIO subsystem to the
driver API documentation. Note that this isn't exhaustive documentation,
but rather focusses on pulling in the kerneldoc from various sources, in
order to improve coverage of kerneldoc processing.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 Documentation/driver-api/gpio.rst  | 45 ++++++++++++++++++++++++++++++++++++++
 Documentation/driver-api/index.rst |  1 +
 2 files changed, 46 insertions(+)
 create mode 100644 Documentation/driver-api/gpio.rst

diff --git a/Documentation/driver-api/gpio.rst b/Documentation/driver-api/gpio.rst
new file mode 100644
index 000000000000..6dd4aa647f27
--- /dev/null
+++ b/Documentation/driver-api/gpio.rst
@@ -0,0 +1,45 @@
+===================================
+General Purpose Input/Output (GPIO)
+===================================
+
+Core
+====
+
+.. kernel-doc:: include/linux/gpio/driver.h
+   :internal:
+
+.. kernel-doc:: drivers/gpio/gpiolib.c
+   :export:
+
+Legacy API
+==========
+
+The functions listed in this section are deprecated. The GPIO descriptor based
+API described above should be used in new code.
+
+.. kernel-doc:: drivers/gpio/gpiolib-legacy.c
+   :export:
+
+ACPI support
+============
+
+.. kernel-doc:: drivers/gpio/gpiolib-acpi.c
+   :export:
+
+Device tree support
+===================
+
+.. kernel-doc:: drivers/gpio/gpiolib-of.c
+   :export:
+
+Device-managed API
+==================
+
+.. kernel-doc:: drivers/gpio/devres.c
+   :export:
+
+sysfs helpers
+=============
+
+.. kernel-doc:: drivers/gpio/gpiolib-sysfs.c
+   :export:
diff --git a/Documentation/driver-api/index.rst b/Documentation/driver-api/index.rst
index 7c94ab50afed..9c20624842b7 100644
--- a/Documentation/driver-api/index.rst
+++ b/Documentation/driver-api/index.rst
@@ -44,6 +44,7 @@ available subsections can be seen below.
    uio-howto
    firmware/index
    pinctl
+   gpio
    misc_devices
 
 .. only::  subproject and html
-- 
2.13.3

