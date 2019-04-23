From: Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v4 01/63] Documentation: add Linux ACPI to Sphinx TOC tree
Date: Wed, 24 Apr 2019 00:28:30 +0800
Message-ID: <20190423162932.21428-2-changbin.du@gmail.com>
References: <20190423162932.21428-1-changbin.du@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190423162932.21428-1-changbin.du@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jonathan Corbet <corbet@lwn.net>
Cc: Bjorn Helgaas <bhelgaas@google.com>, rjw@rjwysocki.net, linux-pci@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com, x86@kernel.org, fenghua.yu@intel.com, linuxppc-dev@lists.ozlabs.org, linux-acpi@vger.kernel.org, linux-gpio@vger.kernel.org, mchehab+samsung@kernel.org, Changbin Du <changbin.du@gmail.com>
List-Id: linux-acpi@vger.kernel.org

Add below index.rst files for ACPI subsystem. More docs will be added later.
  o admin-guide/acpi/index.rst
  o driver-api/acpi/index.rst
  o firmware-guide/index.rst

Signed-off-by: Changbin Du <changbin.du@gmail.com>
---
 Documentation/admin-guide/acpi/index.rst    | 10 ++++++++++
 Documentation/admin-guide/index.rst         |  1 +
 Documentation/driver-api/acpi/index.rst     |  7 +++++++
 Documentation/driver-api/index.rst          |  1 +
 Documentation/firmware-guide/acpi/index.rst |  9 +++++++++
 Documentation/firmware-guide/index.rst      | 13 +++++++++++++
 Documentation/index.rst                     | 10 ++++++++++
 7 files changed, 51 insertions(+)
 create mode 100644 Documentation/admin-guide/acpi/index.rst
 create mode 100644 Documentation/driver-api/acpi/index.rst
 create mode 100644 Documentation/firmware-guide/acpi/index.rst
 create mode 100644 Documentation/firmware-guide/index.rst

diff --git a/Documentation/admin-guide/acpi/index.rst b/Documentation/admin-guide/acpi/index.rst
new file mode 100644
index 000000000000..3e041206089d
--- /dev/null
+++ b/Documentation/admin-guide/acpi/index.rst
@@ -0,0 +1,10 @@
+============
+ACPI Support
+============
+
+Here we document in detail how to interact with various mechanisms in
+the Linux ACPI support.
+
+.. toctree::
+   :maxdepth: 1
+
diff --git a/Documentation/admin-guide/index.rst b/Documentation/admin-guide/index.rst
index 0a491676685e..5b8286fdd91b 100644
--- a/Documentation/admin-guide/index.rst
+++ b/Documentation/admin-guide/index.rst
@@ -77,6 +77,7 @@ configure specific aspects of kernel behavior to your liking.
    LSM/index
    mm/index
    perf-security
+   acpi/index
 
 .. only::  subproject and html
 
diff --git a/Documentation/driver-api/acpi/index.rst b/Documentation/driver-api/acpi/index.rst
new file mode 100644
index 000000000000..898b0c60671a
--- /dev/null
+++ b/Documentation/driver-api/acpi/index.rst
@@ -0,0 +1,7 @@
+============
+ACPI Support
+============
+
+.. toctree::
+   :maxdepth: 2
+
diff --git a/Documentation/driver-api/index.rst b/Documentation/driver-api/index.rst
index c0b600ed9961..aa87075c7846 100644
--- a/Documentation/driver-api/index.rst
+++ b/Documentation/driver-api/index.rst
@@ -56,6 +56,7 @@ available subsections can be seen below.
    slimbus
    soundwire/index
    fpga/index
+   acpi/index
 
 .. only::  subproject and html
 
diff --git a/Documentation/firmware-guide/acpi/index.rst b/Documentation/firmware-guide/acpi/index.rst
new file mode 100644
index 000000000000..0ec7d072ba22
--- /dev/null
+++ b/Documentation/firmware-guide/acpi/index.rst
@@ -0,0 +1,9 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+============
+ACPI Support
+============
+
+.. toctree::
+   :maxdepth: 1
+
diff --git a/Documentation/firmware-guide/index.rst b/Documentation/firmware-guide/index.rst
new file mode 100644
index 000000000000..5355784ca0a2
--- /dev/null
+++ b/Documentation/firmware-guide/index.rst
@@ -0,0 +1,13 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+===============================
+The Linux kernel firmware guide
+===============================
+
+This section describes the ACPI subsystem in Linux from firmware perspective.
+
+.. toctree::
+   :maxdepth: 1
+
+   acpi/index
+
diff --git a/Documentation/index.rst b/Documentation/index.rst
index 80a421cb935e..fdfa85c56a50 100644
--- a/Documentation/index.rst
+++ b/Documentation/index.rst
@@ -35,6 +35,16 @@ trying to get it to work optimally on a given system.
 
    admin-guide/index
 
+Firmware-related documentation
+------------------------------
+The following holds information on the kernel's expectations regarding the
+platform firmwares.
+
+.. toctree::
+   :maxdepth: 2
+
+   firmware-guide/index
+
 Application-developer documentation
 -----------------------------------
 
-- 
2.20.1
