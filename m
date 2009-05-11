From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: [PATCH 0/6] ACPI: button: minor cleanups
Date: Mon, 11 May 2009 16:13:42 -0600
Message-ID: <200905111613.44542.bjorn.helgaas@hp.com>
References: <20090408153427.12354.62167.stgit@bob.kio> <200905081453.02556.bjorn.helgaas@hp.com> <200905110856.37626.trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g1t0026.austin.hp.com ([15.216.28.33]:34892 "EHLO
	g1t0026.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756398AbZEKWNs (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 11 May 2009 18:13:48 -0400
In-Reply-To: <200905110856.37626.trenn@suse.de>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>

On Monday 11 May 2009 12:56:37 am Thomas Renninger wrote:
> On Friday 08 May 2009 10:53:01 pm Bjorn Helgaas wrote:
> > On Wednesday 06 May 2009 11:20:52 am Bjorn Helgaas wrote:
> > > On Wednesday 06 May 2009 09:13:07 am Thomas Renninger wrote:
> > > > Below is the outcome of the patch which fixes a fixed feature button
> > > > s2ram issue.
> > > >
> > > > This does not work anymore since Bjoern's patches.
> > > > Comparing the with the HID of the acpi device looks ugly.
> > > >
> > > > Shall I revive the fixed feature vs GPE button types?
> > > > ACPI_BUTTON_TYPE_POWERF and ACPI_BUTTON_TYPE_SLEEPF?
> > >
> > > I don't understand exactly how I broke this.
> Ahh, sorry.
> You did not break anything.
> 
> The patch is a fix (not for a regression), but is now (with your change)
> somewhat harder/uncleaner to integrate.

Oh, I see.  I was getting worried, so thanks for clarifying that!

The problem is that on some laptops, the button driver doesn't
receive fixed hardware power button events after resuming from
hibernation.  Here's my guess at what's happening:

    <first boot>

	disable button event in PM1_EN (acpi_ev_fixed_event_initialize())
	load button driver
	install fixed hardware event handler
	clear button event status in PM1_STS (acpi_install_fixed_event_handler())
	enable button event in PM1_EN (acpi_install_fixed_event_handler())

	<write hibernation image to disk and power off>

    <second boot>

	disable button event in PM1_EN (acpi_ev_fixed_event_initialize())
	read hibernation image from disk
	branch into hibernation image

Now the button driver is present because it was in the hibernation
image, but we didn't call acpi_install_fixed_event_handler() in the
second boot, so the fixed hardware event has never been enabled in
PM1_EN.

If my guess were correct, fixed hardware power buttons shouldn't work
on *any* systems after hibernation.  But maybe there's more that I
don't understand.

Maybe we need something along the lines of the patch below.  I notice
that there are several other places where we disable/enable GPEs in the
suspend/resume path, and I suppose we should consider fixed hardware
events at those places, too.

Bjorn


diff --git a/drivers/acpi/acpica/evxfevnt.c b/drivers/acpi/acpica/evxfevnt.c
index d0a0807..b590ce5 100644
--- a/drivers/acpi/acpica/evxfevnt.c
+++ b/drivers/acpi/acpica/evxfevnt.c
@@ -812,6 +812,29 @@ acpi_ev_get_gpe_device(struct acpi_gpe_xrupt_info *gpe_xrupt_info,
 	return (AE_OK);
 }
 
+acpi_status acpi_enable_fixed_events(void)
+{
+	acpi_status status;
+	u32 i;
+
+	ACPI_FUNCTION_TRACE(acpi_disable_all_gpes);
+
+	status = acpi_ut_acquire_mutex(ACPI_MTX_EVENTS);
+	if (ACPI_FAILURE(status)) {
+		return_ACPI_STATUS(status);
+	}
+
+	for (i = 0; i < ACPI_NUM_FIXED_EVENTS; i++) {
+		if (acpi_gbl_fixed_event_handlers[i].handler) {
+			acpi_enable_event(i, 0);
+		}
+	}
+
+	(void)acpi_ut_release_mutex(ACPI_MTX_EVENTS);
+
+	return_ACPI_STATUS(AE_OK);
+}
+
 /******************************************************************************
  *
  * FUNCTION:    acpi_disable_all_gpes
diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
index 01574a0..85aa8be 100644
--- a/drivers/acpi/sleep.c
+++ b/drivers/acpi/sleep.c
@@ -501,6 +501,7 @@ static void acpi_hibernation_leave(void)
 
 static void acpi_pm_enable_gpes(void)
 {
+	acpi_enable_fixed_events();
 	acpi_enable_all_runtime_gpes();
 }
 
