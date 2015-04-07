From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] ACPI / HOTPLUG: fix device->physical_node_lock deadlock
Date: Tue, 07 Apr 2015 13:50:48 +0200
Message-ID: <12760195.2odgqTkKju@vostro.rjw.lan>
References: <1428397392-26200-1-git-send-email-xiexiuqi@huawei.com> <5219717.RxvSXtBaZ8@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:60471 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752661AbbDGL0Z (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 7 Apr 2015 07:26:25 -0400
In-Reply-To: <5219717.RxvSXtBaZ8@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Xie XiuQi <xiexiuqi@huawei.com>
Cc: lenb@kernel.org, guohanjun@huawei.com, hanjun.guo@linaro.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On Tuesday, April 07, 2015 01:22:52 PM Rafael J. Wysocki wrote:
> On Tuesday, April 07, 2015 05:03:12 PM Xie XiuQi wrote:
> > I meet a deadlock during cpu hotplug. The code path is bellow:
> > 
> > Call Trace:
> >  [<ffffffff816e373c>] dump_stack+0x19/0x1b
> >  [<ffffffff810fd85a>] validate_chain.isra.43+0xf4a/0x1120
> >  [<ffffffff810236c9>] ? sched_clock+0x9/0x10
> >  [<ffffffff810ca8bd>] ? sched_clock_local+0x1d/0x80
> >  [<ffffffff810caa88>] ? sched_clock_cpu+0xa8/0x100
> >  [<ffffffff810fe846>] __lock_acquire+0x3c6/0xb70
> >  [<ffffffff810caa88>] ? sched_clock_cpu+0xa8/0x100
> >  [<ffffffff810ff7e2>] lock_acquire+0xa2/0x1f0
> >  [<ffffffff813ba132>] ? acpi_scan_is_offline+0x2c/0xa3
> >  [<ffffffff816e7a14>] mutex_lock_nested+0x94/0x3f0
> >  [<ffffffff813ba132>] ? acpi_scan_is_offline+0x2c/0xa3
> >  [<ffffffff813ba132>] ? acpi_scan_is_offline+0x2c/0xa3
> >  [<ffffffff810fe0fd>] ? trace_hardirqs_on+0xd/0x10
> >  [<ffffffff813ba132>] acpi_scan_is_offline+0x2c/0xa3	--> LOCK (DEADLOCK)
> 
> Is it the same device, actually?  acpi_container_offline() walks the *children*
> of the container while acpi_bus_offline() locks the container itself.

So the patch below should make the splat go away too if I'm not mistaken.

---
 drivers/acpi/scan.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

Index: linux-pm/drivers/acpi/scan.c
===================================================================
--- linux-pm.orig/drivers/acpi/scan.c
+++ linux-pm/drivers/acpi/scan.c
@@ -298,7 +298,11 @@ bool acpi_scan_is_offline(struct acpi_de
 	struct acpi_device_physical_node *pn;
 	bool offline = true;
 
-	mutex_lock(&adev->physical_node_lock);
+	/*
+	 * acpi_container_offline() calls this for all of the container's
+	 * children under the container's physical_node_lock lock.
+	 */
+	mutex_lock_nested(&adev->physical_node_lock, SINGLE_DEPTH_NESTING);
 
 	list_for_each_entry(pn, &adev->physical_node_list, node)
 		if (device_supports_offline(pn->dev) && !pn->dev->offline) {

