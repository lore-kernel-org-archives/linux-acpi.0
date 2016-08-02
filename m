From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] ACPI / EC: Fix a regression by reducing parallel _Qxx evaluations
Date: Tue, 02 Aug 2016 02:54:44 +0200
Message-ID: <1679499.0i0bVJIctl@vostro.rjw.lan>
References: <ca8220945184c65f3cd16418de5cfd34bf0b31ab.1469608346.git.lv.zheng@intel.com> <1AE640813FDE7649BE1B193DEA596E883BC07E41@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:54082 "HELO
	cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1750991AbcHBAue (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 1 Aug 2016 20:50:34 -0400
In-Reply-To: <1AE640813FDE7649BE1B193DEA596E883BC07E41@SHSMSX101.ccr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Zheng, Lv" <lv.zheng@intel.com>
Cc: "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, "Brown, Len" <len.brown@intel.com>, Lv Zheng <zetalog@gmail.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Friday, July 29, 2016 03:58:20 AM Zheng, Lv wrote:
> Hi, Rafael
> 
> > From: Zheng, Lv
> > Subject: [PATCH] ACPI / EC: Fix a regression by reducing parallel _Qxx
> > evaluations
> > 
> > A regression is caused by the following commit:
> >   Commit: 02b771b64b73226052d6e731a0987db3b47281e9
> >   Subject: ACPI / EC: Fix an issue caused by the serialized _Qxx evaluations
> > In this commit, using system workqueue causes that the maximum parallel
> > executions of _Qxx can exceed 255. This violates the method reentrancy
> > limit in ACPICA and generates the following error log:
> >   ACPI Error: Method reached maximum reentrancy limit (255)
> > (20150818/dsmethod-341)
> > 
> > This patch creates a seperate workqueue and limits the number of parallel
> > _Qxx evaluations down to a configurable value (can be tuned against
> > number
> > of online CPUs).
> > 
> > Since EC events are handled after driver probe, we can create the
> > workqueue
> > in acpi_ec_init().
> > 
> > Fixes: 02b771b64b73 (ACPI / EC: Fix an issue caused by the serialized _Qxx
> > evaluations)
> > Cc: <stable@vger.kernel.org> # 4.3+
> > Reported-and-tested-by: Helen Buus <ubuntu@hbuus.com>
> [Lv Zheng] 
> I'm sorry that I forgot to mention the bug link.
> It's actually recorded in kernel Bugzilla.
> The bug can be found here:
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=135691
> Hope you can help to add this useful information if this patch is acceptable.

I did that, but due to the problem reported against this patch
(https://patchwork.kernel.org/patch/9252645/), I'm going to drop it from
linux-next and I'll be waiting for an update with that problem addressed.

Thanks,
Rafael

