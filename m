From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v3 00/26] ACPICA: 20150619 Release
Date: Thu, 02 Jul 2015 22:00:01 +0200
Message-ID: <3129114.ObelseX9CZ@vostro.rjw.lan>
References: <cover.1434684719.git.lv.zheng@intel.com> <2361328.v5Zb2Dbn0O@vostro.rjw.lan> <1AE640813FDE7649BE1B193DEA596E880273517D@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:44363 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754580AbbGBTdk (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 2 Jul 2015 15:33:40 -0400
In-Reply-To: <1AE640813FDE7649BE1B193DEA596E880273517D@SHSMSX101.ccr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Zheng, Lv" <lv.zheng@intel.com>
Cc: "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, "Brown, Len" <len.brown@intel.com>, Lv Zheng <zetalog@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Thursday, July 02, 2015 06:10:28 AM Zheng, Lv wrote:
> Hi,
> 
> > From: Rafael J. Wysocki [mailto:rjw@rjwysocki.net]
> > Sent: Thursday, July 02, 2015 7:15 AM
> > 
> > On Wednesday, July 01, 2015 02:42:39 PM Lv Zheng wrote:
> > > The 20150619 ACPICA kernel-resident subsystem updates are linuxized based
> > > on the linux-pm/linux-next branch.
> > >
> > > The patchset has passed the following build/boot tests.
> > > Build tests are performed as follows:
> > > 1. i386 + default + COFNIG_ACPI=y
> > > 2. i386 + allyes + CONFIG_ACPI=y
> > > 3. i386 + default + COFNIG_ACPI=n
> > > 4. i386 + allyes + CONFIG_ACPI=n
> > > 5. x86_64 + default + COFNIG_ACPI=y
> > > 6. x86_64 + allyes + CONFIG_ACPI=y
> > > 7. x86_64 + default + COFNIG_ACPI=n
> > > 8. x86_64 + allyes + CONFIG_ACPI=n
> > > Boot tests are performed as follows:
> > > 1. i386 + default + COFNIG_ACPI=y
> > > 2. x86_64 + default + COFNIG_ACPI=y
> > > Where:
> > > 1. i386: machine named as "Dell Inspiron Mini 1010"
> > > 2. x86_64: machine named as "HP Compaq 8200 Elite SFF PC"
> > > 3. default: kernel configuration with following items enabled:
> > >    All hardware drivers related to the machines of i386/x86_64
> > >    All drivers/acpi configurations
> > >    All platform drivers
> > >
> > > The divergences checking result:
> > > Before applying (20150515 Release):
> > >   565 lines
> > > After applying (20150619 Release):
> > >   539 lines
> > >
> > > Bob Moore (8):
> > >   ACPICA: Namespace: Add support of OSDT table.
> > >   ACPICA: Namespace: Change namespace override to avoid node deletion.
> > >   ACPICA: Cleanup output for the ASL Debug object.
> > >   ACPICA: De-macroize calls to standard C library functions.
> > >   ACPICA: Split C library prototypes to new header.
> > >   ACPICA: Update definitions for the TCPA and TPM2 ACPI tables.
> > >   ACPICA: Update TPM2 ACPI table.
> > >   ACPICA: Update version to 20150619.
> > >
> > > Hanjun Guo (1):
> > >   ACPICA: ACPI 6.0: Add values for MADT GIC version field.
> > >
> > > Lv Zheng (13):
> > >   ACPICA: Linuxize: Reduce divergences for 20150619 release.
> > >   ACPICA: Linuxize: Replace __FUNCTION__ with __func__.
> > >   ACPICA: Hardware: Enable 64-bit firmware waking vector for selected
> > >     FACS.
> > >   ACPICA: Tables: Enable both 32-bit and 64-bit FACS.
> > >   ACPICA: Hardware: Enable firmware waking vector for both 32-bit and
> > >     64-bit FACS.
> > >   ACPICA: Tables: Fix an issue that FACS initialization is performed
> > >     twice.
> > >   ACPICA: Tables: Enable default 64-bit FADT addresses favor.
> > >   ACPICA: MSVC6: Fix build issue for variable argument macros.
> > >   ACPICA: EFI: Add EFI interface definitions to eliminate dependency of
> > >     GNU EFI.
> > >   ACPICA: Namespace: Add support to allow overriding objects.
> > >   ACPICA: acpidump: Allow customized tables to be dumped without
> > >     accessing /dev/mem.
> > >   ACPICA: acpidump: Convert the default behavior to dump from
> > >     /sys/firmware/acpi/tables.
> > >   ACPI / acpidump: Update acpidump manual.
> > >
> > > Sascha Wildner (1):
> > >   ACPICA: Add dragon_fly support to unix file mapping file.
> > >
> > > Suravee Suthikulpanit (1):
> > >   ACPICA: Utilities: Add _CLS processing
> > >
> > > Zhang Rui (1):
> > >   ACPICA: Update for acpi_install_table memory types.
> > >
> > > gongzg (1):
> > >   ACPICA: Comment update, no functional change.
> > 
> > Applied, thanks!
> > 
> > I needed to fix up two patches manually (to remove an extra empty line
> > that is not present in the kernel source), though, so please check if the
> > result is correct in my linux-next branch.
> 
> I checked and didn't see issues.

Awesome, thanks!

Rafael

