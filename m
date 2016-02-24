From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 12/15] ACPICA: ACPI 6.1: Add full support for this version of ACPI spec
Date: Thu, 25 Feb 2016 00:18:44 +0100
Message-ID: <1483423.tgSEpob6r3@vostro.rjw.lan>
References: <cover.1455857575.git.lv.zheng@intel.com> <56C8DD6F.5070506@codeaurora.org> <94F2FBAB4432B54E8AACC7DFDE6C92E37E44BCF7@ORSMSX110.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:64803 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1750937AbcBXXRM (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 24 Feb 2016 18:17:12 -0500
In-Reply-To: <94F2FBAB4432B54E8AACC7DFDE6C92E37E44BCF7@ORSMSX110.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Moore, Robert" <robert.moore@intel.com>
Cc: "Abdulhamid, Harb" <harba@codeaurora.org>, "Zheng, Lv" <lv.zheng@intel.com>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, "Brown, Len" <len.brown@intel.com>, Lv Zheng <zetalog@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Al Stone <ahs3@redhat.com>, "fu.wei@linaro.org" <fu.wei@linaro.org>, "tbaicar@codeaurora.org" <tbaicar@codeaurora.org>, "rruigrok@codeaurora.org" <rruigrok@codeaurora.org>

Hi Bob,

On Wednesday, February 24, 2016 05:39:14 PM Moore, Robert wrote:
> 
> > There are few things I see missing in this patch in your updates made to
> > actbl1.h, I list them below:
> > 
> > 1) Adding time stamp as you did breaks backwards compatibility (something
> > we discovered during our testing).  We tried to remedy this by adding a
> > new version of the acpi_hest_generic_data structure.  Note that we named
> > it v3 to reflect this was the updated version number in ACPI 6.1. (see
> > https://lkml.org/lkml/2016/2/5/549)
> 
> I used V300 in case there is ever some other 3xx version.
> 
> Plus, I made a full struct for the V300 case.
> 
> > 
> > 2) Missing definition of generic error data validation bits, needed to
> > determine whether or not field being read are valid or not (see
> > https://lkml.org/lkml/2016/2/5/549)
> 
> Done.
> 
> > 
> > 3) Need to extend acpi_hest_notify_types to add GPIO, SEA, SEI, and GSIV
> > (see https://lkml.org/lkml/2016/2/5/545)
> 
> Done.

OK

Should I expect an update of the $subject patch, then, or will there be a new
patch on top of it?

Thanks,
Rafael

