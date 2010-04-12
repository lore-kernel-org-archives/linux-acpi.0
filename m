From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: commit 9630bdd9 changes behavior of the poweroff - bug?
Date: Tue, 13 Apr 2010 01:01:54 +0200
Message-ID: <201004130101.54117.rjw@sisk.pl>
References: <20100401133923.GA4104@tiehlicka.suse.cz> <1270848027.3071.0.camel@localhost> <201004102136.43246.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:50792 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754177Ab0DLV6z (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 12 Apr 2010 17:58:55 -0400
In-Reply-To: <201004102136.43246.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Tony Vroon <tony@linx.net>, Michal Hocko <mhocko@suse.cz>, Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, linux-kernel@vger.kernel.org, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>

On Saturday 10 April 2010, Rafael J. Wysocki wrote:
> On Friday 09 April 2010, Tony Vroon wrote:
> > On Fri, 2010-04-09 at 22:42 +0200, Rafael J. Wysocki wrote:
> > > Please check if the patch below changes anything.
> > >  drivers/acpi/wakeup.c |    4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > That didn't change the behaviour for me, sorry.
> 
> Well, I would be sorry if it did, because the patch removed some useful code. :-)
> 
> > (I made sure to go through a full power down session before trying the
> > patched kernel)
> 
> Thanks for testing.  So it looks like we don't disable the GPE during power off.
> 
> I'll try to figure out what's going on, please stay tuned.

Can you please check if the patch below changes the behavior?

Rafael

---
 drivers/acpi/wakeup.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

Index: linux-2.6/drivers/acpi/wakeup.c
===================================================================
--- linux-2.6.orig/drivers/acpi/wakeup.c
+++ linux-2.6/drivers/acpi/wakeup.c
@@ -63,17 +63,17 @@ void acpi_enable_wakeup_device(u8 sleep_
 	list_for_each_safe(node, next, &acpi_wakeup_device_list) {
 		struct acpi_device *dev =
 			container_of(node, struct acpi_device, wakeup_list);
+		u8 action = ACPI_GPE_ENABLE;
 
 		if (!dev->wakeup.flags.valid)
 			continue;
 
 		if ((!dev->wakeup.state.enabled && !dev->wakeup.prepare_count)
 		    || sleep_state > (u32) dev->wakeup.sleep_state)
-			continue;
+			action = ACPI_GPE_DISABLE;
 
-		/* The wake-up power should have been enabled already. */
 		acpi_set_gpe(dev->wakeup.gpe_device, dev->wakeup.gpe_number,
-				ACPI_GPE_ENABLE);
+				action);
 	}
 }
 
