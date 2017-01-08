From: Borislav Petkov <bp@alien8.de>
Subject: Re: 174cc7187e6f ACPICA: Tables: Back port
 acpi_get_table_with_size() and early_acpi_os_unmap_memory() from Linux
 kernel
Date: Sun, 8 Jan 2017 02:01:59 +0100
Message-ID: <20170108010158.b62eovaxsbmhfnkb@pd.tnic>
References: <20170107204227.bwdb5yzrjpiggkmo@pd.tnic>
 <4034dde8-ffc1-18e2-f40c-00cf37471793@intel.com>
 <20170108000702.wrov5ajeou2y3tuy@pd.tnic>
 <CAJZ5v0jtGo207YmBGDw55uCV+3sp-QX2Gx7cup-4e8ESjnHhrQ@mail.gmail.com>
 <20170108003730.hlcqkhdxtah65z66@pd.tnic>
 <CAJZ5v0jgdctHEEOaAUBNZZPb=ni_DLdkJtmiDkvVP4WQUYr3rA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAJZ5v0jgdctHEEOaAUBNZZPb=ni_DLdkJtmiDkvVP4WQUYr3rA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Lv Zheng <lv.zheng@intel.com>, Bob Moore <robert.moore@intel.com>, =?utf-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>, lkml <linux-kernel@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Sun, Jan 08, 2017 at 01:52:50AM +0100, Rafael J. Wysocki wrote:
> So we get the table, but apparently we crash when we attempt to put it.

Right, except on 4.10-rc2 we don't crash but we freeze early. These are
the last lines:

...
[    0.004778] mce: CPU supports 7 MCE banks
[    0.004861] LVT offset 1 assigned for vector 0xf9
[    0.004945] Last level iTLB entries: 4KB 512, 2MB 1024, 4MB 512
[    0.005025] Last level dTLB entries: 4KB 1024, 2MB 1024, 4MB 512, 1GB 0
[    0.005165] Freeing SMP alternatives memory: 24K
[    0.211154] ftrace: allocating 25022 entries in 98 pages
[    0.219614] smpboot: Max logical packages: 2
<EOF>

> Let's try to check the obvious just to rule it out (see attached), but
> honestly I'm not sure what's going on in there.

No change, same freeze.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
