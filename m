From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] acpi: bus: handle power manageable but no _PSC/_PRx case
Date: Fri, 7 Sep 2012 20:32:55 +0200
Message-ID: <201209072032.55469.rjw@sisk.pl>
References: <1346053126-7646-1-git-send-email-aaron.lu@intel.com> <201209071346.01900.rjw@sisk.pl> <504A0579.3000109@intel.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([193.178.161.156]:42570 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752530Ab2IGS0g (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 7 Sep 2012 14:26:36 -0400
In-Reply-To: <504A0579.3000109@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Aaron Lu <aaron.lu@intel.com>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org, Aaron Lu <aaron.lwe@gmail.com>

On Friday, September 07, 2012, Aaron Lu wrote:
> On 09/07/2012 07:46 PM, Rafael J. Wysocki wrote:
> >> Yes, on a test system, when I try to put a device into D3 cold and ACPI
> >> will complain that I can't due to its parent is in a even lower power
> >> state UNKNOWN(255), this parent device is power manageable but has no
> >> _PSC and _PRx defined.
> >
> > Perhaps we can force _PS0 for such devices to start with, so that we know
> > for sure that the initial state is D0?
> 
> Sounds good, I'll update the patch, thanks for the advice.

Actually, I suppose we can do something like the appended patch instead.

I wonder if it works around the particular problem you're seeing?

Rafael


---
 drivers/acpi/bus.c |   11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

Index: linux/drivers/acpi/bus.c
===================================================================
--- linux.orig/drivers/acpi/bus.c
+++ linux/drivers/acpi/bus.c
@@ -229,7 +229,16 @@ static int __acpi_bus_get_power(struct a
 		result = psc;
 	}
 	/* The test below covers ACPI_STATE_UNKNOWN too. */
-	if (result <= ACPI_STATE_D2) {
+	if (result == ACPI_STATE_D0) {
+		/*
+		 * If we were unsure about the device parent's power state up to
+		 * this point, the fact that the device is in D0 implies that
+		 * the parent has to be in D0 too.
+		 */
+		if (device->parent
+		    && device->parent->power.state == ACPI_STATE_UNKNOWN)
+			device->parent->power.state = ACPI_STATE_D0;
+	} else if (result <= ACPI_STATE_D2) {
 	  ; /* Do nothing. */
 	} else if (device->power.flags.power_resources) {
 		int error = acpi_power_get_inferred_state(device, &result);
