From: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: Re: [PATCH v4 18/63] Documentation: ACPI: move aml-debugger.txt to
 firmware-guide/acpi and convert to reST
Date: Wed, 24 Apr 2019 11:28:06 -0300
Message-ID: <20190424112806.3581d0a4@coco.lan>
References: <20190423162932.21428-1-changbin.du@gmail.com>
        <20190423162932.21428-19-changbin.du@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190423162932.21428-19-changbin.du@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Changbin Du <changbin.du@gmail.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Bjorn Helgaas <bhelgaas@google.com>, rjw@rjwysocki.net, linux-pci@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com, x86@kernel.org, fenghua.yu@intel.com, linuxppc-dev@lists.ozlabs.org, linux-acpi@vger.kernel.org, linux-gpio@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Em Wed, 24 Apr 2019 00:28:47 +0800
Changbin Du <changbin.du@gmail.com> escreveu:

> This converts the plain text documentation to reStructuredText format and
> add it to Sphinx TOC tree. No essential content change.
> 
> Signed-off-by: Changbin Du <changbin.du@gmail.com>

For the conversion changes:

Reviewed-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>

> ---
>  Documentation/acpi/aml-debugger.txt           | 66 ----------------
>  .../firmware-guide/acpi/aml-debugger.rst      | 75 +++++++++++++++++++
>  Documentation/firmware-guide/acpi/index.rst   |  1 +
>  3 files changed, 76 insertions(+), 66 deletions(-)
>  delete mode 100644 Documentation/acpi/aml-debugger.txt
>  create mode 100644 Documentation/firmware-guide/acpi/aml-debugger.rst
> 
> diff --git a/Documentation/acpi/aml-debugger.txt b/Documentation/acpi/aml-debugger.txt
> deleted file mode 100644
> index 75ebeb64ab29..000000000000
> --- a/Documentation/acpi/aml-debugger.txt
> +++ /dev/null
> @@ -1,66 +0,0 @@
> -The AML Debugger
> -
> -Copyright (C) 2016, Intel Corporation
> -Author: Lv Zheng <lv.zheng@intel.com>
> -
> -
> -This document describes the usage of the AML debugger embedded in the Linux
> -kernel.
> -
> -1. Build the debugger
> -
> -   The following kernel configuration items are required to enable the AML
> -   debugger interface from the Linux kernel:
> -
> -   CONFIG_ACPI_DEBUGGER=y
> -   CONFIG_ACPI_DEBUGGER_USER=m
> -
> -   The userspace utilities can be built from the kernel source tree using
> -   the following commands:
> -
> -   $ cd tools
> -   $ make acpi
> -
> -   The resultant userspace tool binary is then located at:
> -
> -     tools/power/acpi/acpidbg
> -
> -   It can be installed to system directories by running "make install" (as a
> -   sufficiently privileged user).
> -
> -2. Start the userspace debugger interface
> -
> -   After booting the kernel with the debugger built-in, the debugger can be
> -   started by using the following commands:
> -
> -   # mount -t debugfs none /sys/kernel/debug
> -   # modprobe acpi_dbg
> -   # tools/power/acpi/acpidbg
> -
> -   That spawns the interactive AML debugger environment where you can execute
> -   debugger commands.
> -
> -   The commands are documented in the "ACPICA Overview and Programmer Reference"
> -   that can be downloaded from
> -
> -   https://acpica.org/documentation
> -
> -   The detailed debugger commands reference is located in Chapter 12 "ACPICA
> -   Debugger Reference".  The "help" command can be used for a quick reference.
> -
> -3. Stop the userspace debugger interface
> -
> -   The interactive debugger interface can be closed by pressing Ctrl+C or using
> -   the "quit" or "exit" commands.  When finished, unload the module with:
> -
> -   # rmmod acpi_dbg
> -
> -   The module unloading may fail if there is an acpidbg instance running.
> -
> -4. Run the debugger in a script
> -
> -   It may be useful to run the AML debugger in a test script. "acpidbg" supports
> -   this in a special "batch" mode.  For example, the following command outputs
> -   the entire ACPI namespace:
> -
> -   # acpidbg -b "namespace"
> diff --git a/Documentation/firmware-guide/acpi/aml-debugger.rst b/Documentation/firmware-guide/acpi/aml-debugger.rst
> new file mode 100644
> index 000000000000..a889d43bc6c5
> --- /dev/null
> +++ b/Documentation/firmware-guide/acpi/aml-debugger.rst
> @@ -0,0 +1,75 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +.. include:: <isonum.txt>
> +
> +================
> +The AML Debugger
> +================
> +
> +:Copyright: |copy| 2016, Intel Corporation
> +:Author: Lv Zheng <lv.zheng@intel.com>
> +
> +
> +This document describes the usage of the AML debugger embedded in the Linux
> +kernel.
> +
> +1. Build the debugger
> +=====================
> +
> +The following kernel configuration items are required to enable the AML
> +debugger interface from the Linux kernel::
> +
> +   CONFIG_ACPI_DEBUGGER=y
> +   CONFIG_ACPI_DEBUGGER_USER=m
> +
> +The userspace utilities can be built from the kernel source tree using
> +the following commands::
> +
> +   $ cd tools
> +   $ make acpi
> +
> +The resultant userspace tool binary is then located at::
> +
> +   tools/power/acpi/acpidbg
> +
> +It can be installed to system directories by running "make install" (as a
> +sufficiently privileged user).
> +
> +2. Start the userspace debugger interface
> +=========================================
> +
> +After booting the kernel with the debugger built-in, the debugger can be
> +started by using the following commands::
> +
> +   # mount -t debugfs none /sys/kernel/debug
> +   # modprobe acpi_dbg
> +   # tools/power/acpi/acpidbg
> +
> +That spawns the interactive AML debugger environment where you can execute
> +debugger commands.
> +
> +The commands are documented in the "ACPICA Overview and Programmer Reference"
> +that can be downloaded from
> +
> +https://acpica.org/documentation
> +
> +The detailed debugger commands reference is located in Chapter 12 "ACPICA
> +Debugger Reference".  The "help" command can be used for a quick reference.
> +
> +3. Stop the userspace debugger interface
> +========================================
> +
> +The interactive debugger interface can be closed by pressing Ctrl+C or using
> +the "quit" or "exit" commands.  When finished, unload the module with::
> +
> +   # rmmod acpi_dbg
> +
> +The module unloading may fail if there is an acpidbg instance running.
> +
> +4. Run the debugger in a script
> +===============================
> +
> +It may be useful to run the AML debugger in a test script. "acpidbg" supports
> +this in a special "batch" mode.  For example, the following command outputs
> +the entire ACPI namespace::
> +
> +   # acpidbg -b "namespace"
> diff --git a/Documentation/firmware-guide/acpi/index.rst b/Documentation/firmware-guide/acpi/index.rst
> index 287a7cbd82ac..e9f253d54897 100644
> --- a/Documentation/firmware-guide/acpi/index.rst
> +++ b/Documentation/firmware-guide/acpi/index.rst
> @@ -16,6 +16,7 @@ ACPI Support
>     method-tracing
>     DSD-properties-rules
>     debug
> +   aml-debugger
>     gpio-properties
>     i2c-muxes
>     acpi-lid



Thanks,
Mauro
