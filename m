From: Toshi Kani <toshi.kani@hp.com>
Subject: Re: [PATCH] driver core / ACPI: Avoid device removal locking
 problems
Date: Tue, 27 Aug 2013 15:38:49 -0600
Message-ID: <1377639529.10300.847.camel@misato.fc.hp.com>
References: <1543475.L7gSB7lLAu@vostro.rjw.lan>
	 <4785337.sqQqDSPcpL@vostro.rjw.lan> <3389643.Fdir3g6c6B@vostro.rjw.lan>
	 <1430120.G7JdUKlgj6@vostro.rjw.lan> <521C6FA8.4070804@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g4t0015.houston.hp.com ([15.201.24.18]:12759 "EHLO
	g4t0015.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752326Ab3H0VkY (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 27 Aug 2013 17:40:24 -0400
In-Reply-To: <521C6FA8.4070804@cn.fujitsu.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Gu Zheng <guz.fnst@cn.fujitsu.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, LKML <linux-kernel@vger.kernel.org>, Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>, Tejun Heo <tj@kernel.org>

On Tue, 2013-08-27 at 17:21 +0800, Gu Zheng wrote:
> Hi Rafael,
> 
> On 08/26/2013 11:02 PM, Rafael J. Wysocki wrote:
> 
> > On Monday, August 26, 2013 04:43:26 PM Rafael J. Wysocki wrote:
> >> On Monday, August 26, 2013 02:42:09 PM Rafael J. Wysocki wrote:
> >>> On Monday, August 26, 2013 11:13:13 AM Gu Zheng wrote:
> >>>> Hi Rafael,
> > 
> > [...]
> > 
> >>
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

I am curious how msleep(10) & restart_syscall() work in the change
below.  Doesn't the msleep() make s_active held longer time, which can
lead the thread holding device_hotplug_lock to wait it for deletion?
Also, does restart_syscall() release s_active and reopen this file
again?

@@ -408,9 +408,13 @@ static ssize_t show_online(struct device *dev,
struct device_attribute *attr,
 {
        bool val;

-       lock_device_hotplug();
+       if (!read_lock_device_hotplug()) {
+               msleep(10);
+               return restart_syscall();
+       }
+

Thanks,
-Toshi

