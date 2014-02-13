From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 2/2] ACPICA: acpidump: Remove translation protection on integer types.
Date: Fri, 14 Feb 2014 00:55:42 +0100
Message-ID: <3736900.Ik2hhBZqKa@vostro.rjw.lan>
References: <cover.1392086457.git.lv.zheng@intel.com> <1AE640813FDE7649BE1B193DEA596E88024B004C@SHSMSX101.ccr.corp.intel.com> <3908561D78D1C84285E8C5FCA982C28F31DC88AC@ORSMSX106.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:64137 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752659AbaBMXlA (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 13 Feb 2014 18:41:00 -0500
In-Reply-To: <3908561D78D1C84285E8C5FCA982C28F31DC88AC@ORSMSX106.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Luck, Tony" <tony.luck@intel.com>
Cc: "Zheng, Lv" <lv.zheng@intel.com>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, "Brown, Len" <len.brown@intel.com>, Lv Zheng <zetalog@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Yu, Fenghua" <fenghua.yu@intel.com>

On Thursday, February 13, 2014 11:34:45 PM Luck, Tony wrote:
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

Great, thanks for the confirmation!

I'm going to queue this up for 3.15.

Rafael

