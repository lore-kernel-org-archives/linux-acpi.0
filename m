From: Changbin Du <changbin.du@gmail.com>
Subject: [PATCH 21/23] acpi doc: convert acpi/lpit.txt to rst format
Date: Fri, 29 Mar 2019 00:27:19 +0800
Message-ID: <20190328162721.26138-22-changbin.du@gmail.com>
References: <20190328162721.26138-1-changbin.du@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190328162721.26138-1-changbin.du@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jonathan Corbet <corbet@lwn.net>
Cc: rjw@rjwysocki.net, lenb@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, Changbin Du <changbin.du@gmail.com>
List-Id: linux-acpi@vger.kernel.org

This converts the plain text documentation to reStructuredText format and
add it to Sphinx TOC tree. No essential content change.

Signed-off-by: Changbin Du <changbin.du@gmail.com>
---
 Documentation/acpi/index.rst              |  1 +
 Documentation/acpi/{lpit.txt => lpit.rst} | 16 +++++++++++-----
 2 files changed, 12 insertions(+), 5 deletions(-)
 rename Documentation/acpi/{lpit.txt => lpit.rst} (70%)

diff --git a/Documentation/acpi/index.rst b/Documentation/acpi/index.rst
index f59e6ddb0f99..407b7e0aa54b 100644
--- a/Documentation/acpi/index.rst
+++ b/Documentation/acpi/index.rst
@@ -25,3 +25,4 @@ Linux ACPI (Advanced Configuration and Power Interface)
    apei/output_format
    apei/einj
    cppc_sysfs
+   lpit
diff --git a/Documentation/acpi/lpit.txt b/Documentation/acpi/lpit.rst
similarity index 70%
rename from Documentation/acpi/lpit.txt
rename to Documentation/acpi/lpit.rst
index b426398d2e97..f4e76b8519da 100644
--- a/Documentation/acpi/lpit.txt
+++ b/Documentation/acpi/lpit.rst
@@ -1,3 +1,7 @@
+===========================
+Low Power Idle Table (LPIT)
+===========================
+
 To enumerate platform Low Power Idle states, Intel platforms are using
 “Low Power Idle Table” (LPIT). More details about this table can be
 downloaded from:
@@ -8,13 +12,15 @@ Residencies for each low power state can be read via FFH
 
 On platforms supporting S0ix sleep states, there can be two types of
 residencies:
-- CPU PKG C10 (Read via FFH interface)
-- Platform Controller Hub (PCH) SLP_S0 (Read via memory mapped interface)
+
+  - CPU PKG C10 (Read via FFH interface)
+  - Platform Controller Hub (PCH) SLP_S0 (Read via memory mapped interface)
 
 The following attributes are added dynamically to the cpuidle
-sysfs attribute group:
-	/sys/devices/system/cpu/cpuidle/low_power_idle_cpu_residency_us
-	/sys/devices/system/cpu/cpuidle/low_power_idle_system_residency_us
+sysfs attribute group::
+
+  /sys/devices/system/cpu/cpuidle/low_power_idle_cpu_residency_us
+  /sys/devices/system/cpu/cpuidle/low_power_idle_system_residency_us
 
 The "low_power_idle_cpu_residency_us" attribute shows time spent
 by the CPU package in PKG C10
-- 
2.20.1
