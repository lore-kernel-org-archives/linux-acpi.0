From: Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v6 05/24] Documentation: ACPI: move linuxized-acpica.txt to driver-api/acpi and convert to  reST
Date: Thu, 25 Apr 2019 23:30:58 +0800
Message-ID: <20190425153117.16057-6-changbin.du@gmail.com>
References: <20190425153117.16057-1-changbin.du@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190425153117.16057-1-changbin.du@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@rjwysocki.net, Jonathan Corbet <corbet@lwn.net>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, fenghua.yu@intel.com, linuxppc-dev@lists.ozlabs.org, linux-acpi@vger.kernel.org, linux-gpio@vger.kernel.org, mchehab+samsung@kernel.org, Changbin Du <changbin.du@gmail.com>
List-Id: linux-acpi@vger.kernel.org

This converts the plain text documentation to reStructuredText format and
add it to Sphinx TOC tree. No essential content change.

Signed-off-by: Changbin Du <changbin.du@gmail.com>
Reviewed-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 Documentation/driver-api/acpi/index.rst       |   1 +
 .../acpi/linuxized-acpica.rst}                | 109 ++++++++++--------
 2 files changed, 64 insertions(+), 46 deletions(-)
 rename Documentation/{acpi/linuxized-acpica.txt => driver-api/acpi/linuxized-acpica.rst} (80%)

diff --git a/Documentation/driver-api/acpi/index.rst b/Documentation/driver-api/acpi/index.rst
index 898b0c60671a..12649947b19b 100644
--- a/Documentation/driver-api/acpi/index.rst
+++ b/Documentation/driver-api/acpi/index.rst
@@ -5,3 +5,4 @@ ACPI Support
 .. toctree::
    :maxdepth: 2
 
+   linuxized-acpica
diff --git a/Documentation/acpi/linuxized-acpica.txt b/Documentation/driver-api/acpi/linuxized-acpica.rst
similarity index 80%
rename from Documentation/acpi/linuxized-acpica.txt
rename to Documentation/driver-api/acpi/linuxized-acpica.rst
index 3ad7b0dfb083..0ca8f1538519 100644
--- a/Documentation/acpi/linuxized-acpica.txt
+++ b/Documentation/driver-api/acpi/linuxized-acpica.rst
@@ -1,31 +1,37 @@
+.. SPDX-License-Identifier: GPL-2.0
+.. include:: <isonum.txt>
+
+============================================================
 Linuxized ACPICA - Introduction to ACPICA Release Automation
+============================================================
 
-Copyright (C) 2013-2016, Intel Corporation
-Author: Lv Zheng <lv.zheng@intel.com>
+:Copyright: |copy| 2013-2016, Intel Corporation
 
+:Author: Lv Zheng <lv.zheng@intel.com>
 
-Abstract:
 
+Abstract
+========
 This document describes the ACPICA project and the relationship between
 ACPICA and Linux.  It also describes how ACPICA code in drivers/acpi/acpica,
 include/acpi and tools/power/acpi is automatically updated to follow the
 upstream.
 
+ACPICA Project
+==============
 
-1. ACPICA Project
-
-   The ACPI Component Architecture (ACPICA) project provides an operating
-   system (OS)-independent reference implementation of the Advanced
-   Configuration and Power Interface Specification (ACPI).  It has been
-   adapted by various host OSes.  By directly integrating ACPICA, Linux can
-   also benefit from the application experiences of ACPICA from other host
-   OSes.
+The ACPI Component Architecture (ACPICA) project provides an operating
+system (OS)-independent reference implementation of the Advanced
+Configuration and Power Interface Specification (ACPI).  It has been
+adapted by various host OSes.  By directly integrating ACPICA, Linux can
+also benefit from the application experiences of ACPICA from other host
+OSes.
 
-   The homepage of ACPICA project is: www.acpica.org, it is maintained and
-   supported by Intel Corporation.
+The homepage of ACPICA project is: www.acpica.org, it is maintained and
+supported by Intel Corporation.
 
-   The following figure depicts the Linux ACPI subsystem where the ACPICA
-   adaptation is included:
+The following figure depicts the Linux ACPI subsystem where the ACPICA
+adaptation is included::
 
       +---------------------------------------------------------+
       |                                                         |
@@ -71,21 +77,27 @@ upstream.
 
                  Figure 1. Linux ACPI Software Components
 
-   NOTE:
+.. note::
     A. OS Service Layer - Provided by Linux to offer OS dependent
        implementation of the predefined ACPICA interfaces (acpi_os_*).
+       ::
+
          include/acpi/acpiosxf.h
          drivers/acpi/osl.c
          include/acpi/platform
          include/asm/acenv.h
     B. ACPICA Functionality - Released from ACPICA code base to offer
        OS independent implementation of the ACPICA interfaces (acpi_*).
+       ::
+
          drivers/acpi/acpica
          include/acpi/ac*.h
          tools/power/acpi
     C. Linux/ACPI Functionality - Providing Linux specific ACPI
        functionality to the other Linux kernel subsystems and user space
        programs.
+       ::
+
          drivers/acpi
          include/linux/acpi.h
          include/linux/acpi*.h
@@ -95,24 +107,27 @@ upstream.
        ACPI subsystem to offer architecture specific implementation of the
        ACPI interfaces.  They are Linux specific components and are out of
        the scope of this document.
+       ::
+
          include/asm/acpi.h
          include/asm/acpi*.h
          arch/*/acpi
 
-2. ACPICA Release
+ACPICA Release
+==============
 
-   The ACPICA project maintains its code base at the following repository URL:
-   https://github.com/acpica/acpica.git. As a rule, a release is made every
-   month.
+The ACPICA project maintains its code base at the following repository URL:
+https://github.com/acpica/acpica.git. As a rule, a release is made every
+month.
 
-   As the coding style adopted by the ACPICA project is not acceptable by
-   Linux, there is a release process to convert the ACPICA git commits into
-   Linux patches.  The patches generated by this process are referred to as
-   "linuxized ACPICA patches".  The release process is carried out on a local
-   copy the ACPICA git repository.  Each commit in the monthly release is
-   converted into a linuxized ACPICA patch.  Together, they form the monthly
-   ACPICA release patchset for the Linux ACPI community.  This process is
-   illustrated in the following figure:
+As the coding style adopted by the ACPICA project is not acceptable by
+Linux, there is a release process to convert the ACPICA git commits into
+Linux patches.  The patches generated by this process are referred to as
+"linuxized ACPICA patches".  The release process is carried out on a local
+copy the ACPICA git repository.  Each commit in the monthly release is
+converted into a linuxized ACPICA patch.  Together, they form the monthly
+ACPICA release patchset for the Linux ACPI community.  This process is
+illustrated in the following figure::
 
     +-----------------------------+
     | acpica / master (-) commits |
@@ -153,7 +168,7 @@ upstream.
 
                 Figure 2. ACPICA -> Linux Upstream Process
 
-   NOTE:
+.. note::
     A. Linuxize Utilities - Provided by the ACPICA repository, including a
        utility located in source/tools/acpisrc folder and a number of
        scripts located in generate/linux folder.
@@ -170,19 +185,20 @@ upstream.
    following kernel configuration options:
    CONFIG_ACPI/CONFIG_ACPI_DEBUG/CONFIG_ACPI_DEBUGGER
 
-3. ACPICA Divergences
+ACPICA Divergences
+==================
 
-   Ideally, all of the ACPICA commits should be converted into Linux patches
-   automatically without manual modifications, the "linux / master" tree should
-   contain the ACPICA code that exactly corresponds to the ACPICA code
-   contained in "new linuxized acpica" tree and it should be possible to run
-   the release process fully automatically.
+Ideally, all of the ACPICA commits should be converted into Linux patches
+automatically without manual modifications, the "linux / master" tree should
+contain the ACPICA code that exactly corresponds to the ACPICA code
+contained in "new linuxized acpica" tree and it should be possible to run
+the release process fully automatically.
 
-   As a matter of fact, however, there are source code differences between
-   the ACPICA code in Linux and the upstream ACPICA code, referred to as
-   "ACPICA Divergences".
+As a matter of fact, however, there are source code differences between
+the ACPICA code in Linux and the upstream ACPICA code, referred to as
+"ACPICA Divergences".
 
-   The various sources of ACPICA divergences include:
+The various sources of ACPICA divergences include:
    1. Legacy divergences - Before the current ACPICA release process was
       established, there already had been divergences between Linux and
       ACPICA. Over the past several years those divergences have been greatly
@@ -213,11 +229,12 @@ upstream.
       rebased on the ACPICA side in order to offer better solutions, new ACPICA
       divergences are generated.
 
-4. ACPICA Development
+ACPICA Development
+==================
 
-   This paragraph guides Linux developers to use the ACPICA upstream release
-   utilities to obtain Linux patches corresponding to upstream ACPICA commits
-   before they become available from the ACPICA release process.
+This paragraph guides Linux developers to use the ACPICA upstream release
+utilities to obtain Linux patches corresponding to upstream ACPICA commits
+before they become available from the ACPICA release process.
 
    1. Cherry-pick an ACPICA commit
 
@@ -225,7 +242,7 @@ upstream.
    you want to cherry pick must be committed into the local repository.
 
    Then the gen-patch.sh command can help to cherry-pick an ACPICA commit
-   from the ACPICA local repository:
+   from the ACPICA local repository::
 
    $ git clone https://github.com/acpica/acpica
    $ cd acpica
@@ -240,7 +257,7 @@ upstream.
    changes that haven't been applied to Linux yet.
 
    You can generate the ACPICA release series yourself and rebase your code on
-   top of the generated ACPICA release patches:
+   top of the generated ACPICA release patches::
 
    $ git clone https://github.com/acpica/acpica
    $ cd acpica
@@ -254,7 +271,7 @@ upstream.
    3. Inspect the current divergences
 
    If you have local copies of both Linux and upstream ACPICA, you can generate
-   a diff file indicating the state of the current divergences:
+   a diff file indicating the state of the current divergences::
 
    # git clone https://github.com/acpica/acpica
    # git clone http://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
-- 
2.20.1
