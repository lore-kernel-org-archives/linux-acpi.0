From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: 2.6.26.[1-3] + x61 tablet + x6ultrabase: no resume after
	undocking
Date: Mon, 01 Sep 2008 11:17:28 +0800
Message-ID: <1220239048.24775.152.camel@rzhang-dt>
References: <200808301535.22419.sfking@fdwdc.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:63870 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751189AbYIADSQ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 31 Aug 2008 23:18:16 -0400
In-Reply-To: <200808301535.22419.sfking@fdwdc.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Steven King <sfking@fdwdc.com>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, ibm-acpi-devel@lists.sourceforge.net

On Sat, 2008-08-30 at 15:35 -0700, Steven King wrote:
> While 2.6.26 made my x61t work with the x6ultrabase, I find that once I have 
> docked the x61t, I can only resume after a suspend2ram if the x61t is docked.  
> That is:
> 
> Never have been docked: suspend & resume works fine.
> Docked: suspend & resume works fine.
> Docked, undocked, re-docked: suspend & resume works fine.
> 
> Docked, then undocked: never finishes resuming (the disk seems to spin up and 
> the sleep led goes off, but the system doesnt seem to get any further).
> 
> Any suggestions?
> 
I have an acpidump of a X61, and it may also send notifications in _STA
method.
Please please try the following patch and see if it helps.
and it would be great if you can attach the acpidump of your laptop.

In some BIOSes, every _STA method call will send a notification again,
this cause freeze. And in some BIOSes, it appears _STA should be called
after _DCK. This tries to avoid calls _STA, and still keep the device
present check.
http://bugzilla.kernel.org/show_bug.cgi?id=10431

Signed-off-by: Shaohua Li <shaohua.li@intel.com> 
---
 drivers/acpi/dock.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

Index: linux/drivers/acpi/dock.c
===================================================================
--- linux.orig/drivers/acpi/dock.c	2008-08-27 14:38:44.000000000 +0800
+++ linux/drivers/acpi/dock.c	2008-08-28 09:33:02.000000000 +0800
@@ -604,14 +604,17 @@ static int handle_eject_request(struct d
 static void dock_notify(acpi_handle handle, u32 event, void *data)
 {
 	struct dock_station *ds = data;
+	struct acpi_device *tmp;
 
 	switch (event) {
 	case ACPI_NOTIFY_BUS_CHECK:
-		if (!dock_in_progress(ds) && dock_present(ds)) {
+		if (!dock_in_progress(ds) && acpi_bus_get_device(ds->handle,
+		   &tmp)) {
 			begin_dock(ds);
 			dock(ds);
 			if (!dock_present(ds)) {
 				printk(KERN_ERR PREFIX "Unable to dock!\n");
+				complete_dock(ds);
 				break;
 			}
 			atomic_notifier_call_chain(&dock_notifier_list,


--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html


