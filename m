From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] driver core / ACPI: Avoid device removal locking problems
Date: Tue, 27 Aug 2013 14:36:44 -0400
Message-ID: <20130827183644.GC12212@mtj.dyndns.org>
References: <1543475.L7gSB7lLAu@vostro.rjw.lan>
 <4785337.sqQqDSPcpL@vostro.rjw.lan>
 <3389643.Fdir3g6c6B@vostro.rjw.lan>
 <1430120.G7JdUKlgj6@vostro.rjw.lan>
 <521C6FA8.4070804@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-qc0-f179.google.com ([209.85.216.179]:49882 "EHLO
	mail-qc0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752276Ab3H0Sgt (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 27 Aug 2013 14:36:49 -0400
Content-Disposition: inline
In-Reply-To: <521C6FA8.4070804@cn.fujitsu.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Gu Zheng <guz.fnst@cn.fujitsu.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Toshi Kani <toshi.kani@hp.com>, LKML <linux-kernel@vger.kernel.org>, Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>

Hello,

On Tue, Aug 27, 2013 at 05:21:44PM +0800, Gu Zheng wrote:
> >> OK, so the patch below is quick and dirty and overkill, but it should make the
> >> splat go away at least.
> > 
> > And if this patch does make the splat go away for you, please also test the
> > appended one (Tejun, thanks for the hint!).
> > 
> > I'll address the ACPI part differently later.
> 
> What about changing device_hotplug_lock and acpi_scan_lock to rwsem? like the
> attached one(With a preliminary test, it also can make the splat go away).:)

Hmmm.. I don't get it.  How is introducing another rwlock whic may
cause the operation, even reading the status, to fail randomly a
better option?  It's harier and more brittle.  We probably want to
implement better solution in sysfs for files which interact with
device addition / removal paths but for now I think Rafael's patch is
the right direction.

Thanks.

-- 
tejun
