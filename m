From: Kristen Accardi <kristen.c.accardi@intel.com>
Subject: Re: 2.6.17-rc5-mm3: oops when ejecting dock
Date: Tue, 06 Jun 2006 15:54:54 -0700
Message-ID: <1149634494.13089.53.camel@whizzy>
References: <4483EB38.30609@goop.org> <1149554579.6006.10.camel@whizzy>
	 <4484D244.3010905@goop.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:23557 "EHLO
	orsmga101-1.jf.intel.com") by vger.kernel.org with ESMTP
	id S1751126AbWFFWof (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 6 Jun 2006 18:44:35 -0400
In-Reply-To: <4484D244.3010905@goop.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: linux-acpi@vger.kernel.org, Andrew Morton <akpm@osdl.org>

On Mon, 2006-06-05 at 17:54 -0700, Jeremy Fitzhardinge wrote:
> Kristen Accardi wrote:
> > I was able to reproduce this issue on an x40 - I found a bug in the
> > code, however, when I fixed that bug I seem to have uncovered another
> > one.  I'll send you a patch hopefully in the next day or so.
> >   
> Great, looking forward to it.  Do you know if this will properly 
> disconnect the optical drive, or does that need some more ata/ide support?
> 
> Thanks,
>     J

So, here is a patch which will fix the bug.  The problem that I found
after I fixed the bug occurs in this circumstance:
1.  boot in ultrabase
2.  undock

But not in this case:
1.  boot outside base
2.  dock/undock etc.

The symptom of the problem is that you will undock and your machine will
get a softlockup on a CPU and just hang.  Checking the log file (when
possible) shows lots errors from hdc: and ide: (this ultrabase has a
cdrom on it which would be hdc).  I am using an x40 to duplicate the
issue, so you may have a different experience than I do.  The problem
seems to be that the cdrom that is on the ultrabase is not unplugging
gracefully.  I may have to hook up with whoever is working on the ide
hotplug and see if this is something I can fix.

Incidentally, the reason it works fine when you boot outside the base
and then dock/undock is because the cdrom is also not getting properly
inserted.  So, it appears to power it on, but it is not actually being
hotplugged.

anyway, this bug fix is needed either way... Andrew can you apply it?

Thanks,
Kristen


Properly use return value from acpi_get_device

Signed-off-by: Kristen Carlson Accardi <kristen.c.accardi@intel.com>

---
 drivers/acpi/dock.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- 2.6-mm.orig/drivers/acpi/dock.c
+++ 2.6-mm/drivers/acpi/dock.c
@@ -273,7 +273,7 @@ static void dock_remove_acpi_device(acpi
 	struct acpi_device *device;
 	int ret;
 
-	if (acpi_bus_get_device(handle, &device)) {
+	if (!acpi_bus_get_device(handle, &device)) {
 		ret = acpi_bus_trim(device, 1);
 		if (ret)
 			pr_debug("error removing bus, %x\n", -ret);
