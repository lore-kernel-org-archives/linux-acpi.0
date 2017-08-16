From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v2 4/7] ghes_edac: avoid multiple calls to dmi_walk()
Date: Wed, 16 Aug 2017 13:29:07 +0200
Message-ID: <20170816112906.u32wlymfpw5don4v@pd.tnic>
References: <20170814180526.wtfjzgc6uye2qtx6@pd.tnic>
 <1502734083.2042.143.camel@hpe.com>
 <20170814183551.sgk2i7lxpmpyodhv@pd.tnic>
 <1502736750.2042.145.camel@hpe.com>
 <20170814193432.mjldfhfal5ba5dt7@pd.tnic>
 <1502741290.2042.147.camel@hpe.com>
 <20170814203942.6t3mrq3hc324blab@pd.tnic>
 <1502810766.2042.149.camel@hpe.com>
 <20170815154815.wy3dqwb4yi3feahg@intel.com>
 <20170816082931.p6rpvtlxwt5nccxr@pd.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.skyhub.de ([5.9.137.197]:46008 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751543AbdHPL3R (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 16 Aug 2017 07:29:17 -0400
Content-Disposition: inline
In-Reply-To: <20170816082931.p6rpvtlxwt5nccxr@pd.tnic>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Luck, Tony" <tony.luck@intel.com>, Steven Rostedt <rostedt@goodmis.org>
Cc: "Kani, Toshimitsu" <toshi.kani@hpe.com>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "lenb@kernel.org" <lenb@kernel.org>, "mchehab@kernel.org" <mchehab@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>

On Wed, Aug 16, 2017 at 10:29:31AM +0200, Borislav Petkov wrote:
> Anyway, I think I have a box to run it to, lemme go find it.

Seems to boot.

It's a whole another story whether it actually works. :-)

Need some EINJ capabilities urgently but finding a box where it works
reliably is like finding gold.

[    7.784960] ERST: Failed to get Error Log Address Range.
[    7.795905] EDAC DEBUG: edac_mc_alloc: allocating 2444 bytes for mci data (16 dimms, 16 csrows/ch
annels)
[    7.815266] ghes_edac: This EDAC driver relies on BIOS to enumerate memory and get error reports.
[    7.833372] ghes_edac: Unfortunately, not all BIOSes reflect the memory layout correctly.
[    7.850093] ghes_edac: So, the end result of using this driver varies from vendor to vendor.
[    7.867322] ghes_edac: If you find incorrect reports, please contact your hardware vendor
[    7.884034] ghes_edac: to correct its BIOS.
[    7.892599] ghes_edac: This system has 16 DIMM sockets.
[    7.903274] EDAC DEBUG: ghes_edac_dmidecode: DIMM8: Unbuffered DDR3 RAM size = 2048 MB(ECC)
[    7.920337] EDAC DEBUG: ghes_edac_dmidecode:         type 24, detail 0x80, width 72(total 64)
[    7.936532] EDAC DEBUG: ghes_edac_dmidecode: DIMM9: Unbuffered DDR3 RAM size = 2048 MB(ECC)
[    7.953591] EDAC DEBUG: ghes_edac_dmidecode:         type 24, detail 0x80, width 72(total 64)
[    7.969778] EDAC DEBUG: ghes_edac_dmidecode: DIMM10: Unbuffered DDR3 RAM size = 2048 MB(ECC)
[    7.987010] EDAC DEBUG: ghes_edac_dmidecode:         type 24, detail 0x80, width 72(total 64)
[    8.003199] EDAC DEBUG: ghes_edac_dmidecode: DIMM11: Unbuffered DDR3 RAM size = 2048 MB(ECC)
[    8.020432] EDAC DEBUG: ghes_edac_dmidecode:         type 24, detail 0x80, width 72(total 64)
[    8.036618] EDAC DEBUG: ghes_edac_dmidecode: DIMM12: Unbuffered DDR3 RAM size = 2048 MB(ECC)
[    8.053848] EDAC DEBUG: ghes_edac_dmidecode:         type 24, detail 0x80, width 72(total 64)
[    8.070038] EDAC DEBUG: ghes_edac_dmidecode: DIMM13: Unbuffered DDR3 RAM size = 2048 MB(ECC)
[    8.087268] EDAC DEBUG: ghes_edac_dmidecode:         type 24, detail 0x80, width 72(total 64)
[    8.103456] EDAC DEBUG: ghes_edac_dmidecode: DIMM14: Unbuffered DDR3 RAM size = 2048 MB(ECC)
[    8.120687] EDAC DEBUG: ghes_edac_dmidecode:         type 24, detail 0x80, width 72(total 64)
[    8.128053] tsc: Refined TSC clocksource calibration: 2099.999 MHz
[    8.128173] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x1e452fc488e, max_idle_ns: 44
0795307124 ns
[    8.169800] EDAC DEBUG: ghes_edac_dmidecode: DIMM15: Unbuffered DDR3 RAM size = 2048 MB(ECC)
[    8.187043] EDAC DEBUG: ghes_edac_dmidecode:         type 24, detail 0x80, width 72(total 64)
[    8.203230] EDAC DEBUG: edac_mc_add_mc_with_groups: 
[    8.213363] EDAC DEBUG: edac_create_sysfs_mci_device: creating bus mc1
[    8.226643] EDAC DEBUG: edac_create_sysfs_mci_device: creating device mc1
[    8.240450] EDAC DEBUG: edac_create_sysfs_mci_device: creating dimm8, located at memory 8 
[    8.257362] EDAC DEBUG: edac_create_dimm_object: creating rank/dimm device dimm8
[    8.272506] EDAC DEBUG: edac_create_sysfs_mci_device: creating dimm9, located at memory 9 
[    8.289409] EDAC DEBUG: edac_create_dimm_object: creating rank/dimm device dimm9
[    8.304556] EDAC DEBUG: edac_create_sysfs_mci_device: creating dimm10, located at memory 10 
[    8.321808] EDAC DEBUG: edac_create_dimm_object: creating rank/dimm device dimm10
[    8.337126] EDAC DEBUG: edac_create_sysfs_mci_device: creating dimm11, located at memory 11 
[    8.354377] EDAC DEBUG: edac_create_dimm_object: creating rank/dimm device dimm11
[    8.369697] EDAC DEBUG: edac_create_sysfs_mci_device: creating dimm12, located at memory 12 
[    8.386946] EDAC DEBUG: edac_create_dimm_object: creating rank/dimm device dimm12
[    8.402266] EDAC DEBUG: edac_create_sysfs_mci_device: creating dimm13, located at memory 13 
[    8.419516] EDAC DEBUG: edac_create_dimm_object: creating rank/dimm device dimm13
[    8.434835] EDAC DEBUG: edac_create_sysfs_mci_device: creating dimm14, located at memory 14 
[    8.452094] EDAC DEBUG: edac_create_dimm_object: creating rank/dimm device dimm14
[    8.467423] EDAC DEBUG: edac_create_sysfs_mci_device: creating dimm15, located at memory 15 
[    8.484674] EDAC DEBUG: edac_create_dimm_object: creating rank/dimm device dimm15
[    8.499994] EDAC DEBUG: edac_create_csrow_object: creating (virtual) csrow node csrow8
[    8.516215] EDAC DEBUG: edac_create_csrow_object: creating (virtual) csrow node csrow9
[    8.532433] EDAC DEBUG: edac_create_csrow_object: creating (virtual) csrow node csrow10
[    8.548824] EDAC DEBUG: edac_create_csrow_object: creating (virtual) csrow node csrow11
[    8.565203] EDAC DEBUG: edac_create_csrow_object: creating (virtual) csrow node csrow12
[    8.581585] EDAC DEBUG: edac_create_csrow_object: creating (virtual) csrow node csrow13
[    8.597964] EDAC DEBUG: edac_create_csrow_object: creating (virtual) csrow node csrow14
[    8.614347] EDAC DEBUG: edac_create_csrow_object: creating (virtual) csrow node csrow15
[    8.630744] EDAC MC1: Giving out device to module ghes_edac.c controller ghes_edac: DEV ghes (INTERRUPT)
[    8.650073] [Firmware Warn]: GHES: Poll interval is 0 for generic hardware error source: 1, disabled.
[    8.669012] GHES: APEI firmware first mode is enabled by WHEA _OSC.
[    8.681940] Serial: 8250/16550 driver, 32 ports, IRQ sharing disabled

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
