From: "Zheng, Lv" <lv.zheng@intel.com>
Subject: RE: [PATCH 2/2] ACPICA: acpidump: Remove translation protection on
 integer types.
Date: Tue, 18 Feb 2014 00:57:29 +0000
Message-ID: <1AE640813FDE7649BE1B193DEA596E88024B105B@SHSMSX101.ccr.corp.intel.com>
References: <cover.1392086457.git.lv.zheng@intel.com>
 <55e016394ee9d4291e8c42e00383c93a3ace4b0b.1392086457.git.lv.zheng@intel.com>
 <1AE640813FDE7649BE1B193DEA596E88024B004C@SHSMSX101.ccr.corp.intel.com>
 <3908561D78D1C84285E8C5FCA982C28F31DC88AC@ORSMSX106.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <3908561D78D1C84285E8C5FCA982C28F31DC88AC@ORSMSX106.amr.corp.intel.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "Luck, Tony" <tony.luck@intel.com>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, "Brown, Len" <len.brown@intel.com>
Cc: Lv Zheng <zetalog@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Yu, Fenghua" <fenghua.yu@intel.com>
List-Id: linux-acpi@vger.kernel.org

Hi, Tony

> From: Luck, Tony
> Sent: Friday, February 14, 2014 7:35 AM
> 
> >    All definitions are equal except ACPI_UINT64_MAX for CONFIG_IA64.  It
> >    is changed from sizeof(unsigned long) to sizeof(unsigned long long).
> >    By investigation, 64bit Linux kernel build is LP64 compliant, i.e.,
> >    sizeof(long) and (pointer) are 64.  As sizeof(unsigned long) equals to
> >    sizeof(unsigned long long) on IA64 platform where CONFIG_64BIT cannot be
> >    disabled, this change actually will not affect the value of
> >    ACPI_UINT64_MAX on IA64 platforms.
> 
> This all looks correct to me - it really shouldn't make any difference
> to ia64 whether we use "long" or "long long" ... both are 8-byte entities.
> The compiler would complain in some places if you mixed & matched
> incorrectly (e.g. printk("val = %ld\n", val); will give a warning if val has
> been switched from "long" to "long long" and the format would need
> to change to "%lld").  But it looks like nothing like that happens as a
> result of this patch. All my ia64 configs build with no new warnings.
> 
> Boots OK too.

It looked scary to me that without applying this patch, Linux ACPICA was using the u64 defined by Linux but defining ACPI_UINT64_MAX to the value that could be different from sizeof(u64).
This patch can make them converged.  I was worrying about the regressions that could be triggered by this fix if there was something already dependent on this divergence.
Great to hear that there is no such dependency. :-)

Thanks and best regards
-Lv
 
> 
> -Tony
