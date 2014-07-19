From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v3 0/3] Clean up ACPI core to prepare for running ACPI on ARM64
Date: Sun, 20 Jul 2014 01:45:29 +0200
Message-ID: <12808483.rIsXFzJSCT@vostro.rjw.lan>
References: <1405677774-16787-1-git-send-email-hanjun.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1405677774-16787-1-git-send-email-hanjun.guo@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Hanjun Guo <hanjun.guo@linaro.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Graeme Gregory <graeme.gregory@linaro.org>, Tony Luck <tony.luck@intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linaro-acpi@lists.linaro.org
List-Id: linux-acpi@vger.kernel.org

On Friday, July 18, 2014 06:02:51 PM Hanjun Guo wrote:
> This patch set have no function change for x86 and ia64 and
> just do some clean up to prepare for running ACPI on ARM64.
> 
> This patch set is splited out from the patch set [1]
> "[PATCH v4 00/13] Enable ACPI on ARM64 in Kconfig" and hope it
> can be merged first before ARM64 ACPI core patches.
> 
> [1]: https://lkml.org/lkml/2014/6/26/627
> 
> update from v2:
> Don not select ACPI_LEGACY_TABLES_LOOKUP on IA64 which
> is catched by Peter.
> 
> update from v1:
> 1. Drop "Make EC debugfs depend on X86 || IA64 in Kconfig";
> 2. Rename ACPI_SCAN_BIOS_NOT_EFI to ACPI_LEGACY_TABLES_LOOKUP
>    suggested by Rafael;
> 3. Rename ARCH_HAS_ACPI_PDC to ARCH_MIGHT_HAVE_ACPI_PDC suggested by Rafael;
> 4. Remove the help for ARCH_MIGHT_HAVE_ACPI_PDC because it can't be selected;
> 5. Rename acpi_arch_is_smp() to acpi_has_cpu_in_madt() to be more
>    explicit and easy understanding.
> 
> Graeme Gregory (2):
>   ACPI: ARM64 does not have a BIOS add config for BIOS table scan.
>   ACPI: Don't use acpi_lapic in ACPI core code
> 
> Hanjun Guo (1):
>   ACPI / processor: Introduce ARCH_HAS_ACPI_PDC

Series queued up for 3.17 with minor changes of patch subjects.  Thanks!

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
