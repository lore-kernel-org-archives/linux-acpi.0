From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [BISECTED] HP G7000 battery disappears after suspend
Date: Wed, 8 Jul 2009 23:45:20 +0200
Message-ID: <200907082345.22084.bzolnier@gmail.com>
References: <61b223ba0907081216q3813c8f0n677bcce8b24ae52c@mail.gmail.com> <200907082141.18135.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-bw0-f225.google.com ([209.85.218.225]:46766 "EHLO
	mail-bw0-f225.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754588AbZGHVkB (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 8 Jul 2009 17:40:01 -0400
In-Reply-To: <200907082141.18135.rjw@sisk.pl>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Alan Jenkins <alan-jenkins@tuffmail.co.uk>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>, Len Brown <lenb@kernel.org>

On Wednesday 08 July 2009 21:41:17 Rafael J. Wysocki wrote:
> On Wednesday 08 July 2009, Alan Jenkins wrote:
> > Hi,
> > 
> > I've borrowed this laptop for a few days.  Linux works pretty well,
> > but I found a problem on newer kernels.  After suspend it claims the
> > battery has been removed.  E.g. /proc/acpi/battery/BAT0/state claims
> > the battery is not present (but it is).
> > 
> > I've attached acpidump and dmidecode output at
> > <http://bugzilla.kernel.org/show_bug.cgi?id=13745>.  I still have
> > access to the laptop for further tests, but only until Friday.
> > 
> > I bisected it to the commit below.  Manually reverting the patch fixes
> > the problem (in both 2.6.30 and 2.6.31-rc2).
> 
> Well, the commit below can't be reverted, because that would cause the boxes
> it fixed to stop working.
> 
> Now, the only case this patch can make any difference is when the BIOS doesn't
> set SCI_EN before returning control the the kernel, which quite evidently is a
> BIOS bug.  The fact that the battery doesn't work with this patch applied means
> that the BIOS not only doesn't set SCI_EN, but also expects it to remain unset,
> which is insane.
> 
> IMO this is a "won't fix", sorry. 

Lets be pragmatic here..

Besides this is a regression and we are already handling some such insane
systems in STR case.  Moreover sending SMI ACPI_ENABLE command may result in
some things happening behind our back and not only setting of SCI_EN bit..

PS Looking at the set_sci_en_on_resume quirk history it seems that if we are
lucky we may may fix another issue (screaming IRQ one) at the same time :)

Alan, could you try this patch?

---
debug patch (needs to have both CONFIG_SUSPEND=y & CONFIG_HIBERNATION=y)

 drivers/acpi/sleep.c |   13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

Index: b/drivers/acpi/sleep.c
===================================================================
--- a/drivers/acpi/sleep.c
+++ b/drivers/acpi/sleep.c
@@ -383,6 +383,14 @@ static struct dmi_system_id __initdata a
 		},
 	},
 	{
+	.callback = init_set_sci_en_on_resume,
+	.ident = "Hewlett-Packard HP G7000 Notebook PC",
+	.matches = {
+		DMI_MATCH(DMI_SYS_VENDOR, "Hewlett-Packard"),
+		DMI_MATCH(DMI_PRODUCT_NAME, "HP G7000 Notebook PC"),
+		},
+	},
+	{
 	.callback = init_old_suspend_ordering,
 	.ident = "Panasonic CF51-2L",
 	.matches = {
@@ -472,7 +480,10 @@ static void acpi_hibernation_leave(void)
 	 * If ACPI is not enabled by the BIOS and the boot kernel, we need to
 	 * enable it here.
 	 */
-	acpi_enable();
+	if (set_sci_en_on_resume)
+		acpi_write_bit_register(ACPI_BITREG_SCI_ENABLE, 1);
+	else
+		acpi_enable();
 	/* Reprogram control registers and execute _BFS */
 	acpi_leave_sleep_state_prep(ACPI_STATE_S4);
 	/* Check the hardware signature */
