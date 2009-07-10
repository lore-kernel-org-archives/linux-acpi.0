From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [BISECTED] HP G7000 battery disappears after suspend
Date: Fri, 10 Jul 2009 18:37:26 +0200
Message-ID: <200907101837.29026.bzolnier@gmail.com>
References: <61b223ba0907081216q3813c8f0n677bcce8b24ae52c@mail.gmail.com> <61b223ba0907090619ld35b51eqe3ace5aad7fde821@mail.gmail.com> <200907092211.31250.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.154]:39234 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751376AbZGJQbg (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 10 Jul 2009 12:31:36 -0400
In-Reply-To: <200907092211.31250.rjw@sisk.pl>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Alan Jenkins <alan-jenkins@tuffmail.co.uk>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>

On Thursday 09 July 2009 22:11:30 Rafael J. Wysocki wrote:
> On Thursday 09 July 2009, Alan Jenkins wrote:
> > 2009/7/8 Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>:
> > > On Wednesday 08 July 2009 21:41:17 Rafael J. Wysocki wrote:
> > >> On Wednesday 08 July 2009, Alan Jenkins wrote:
> > >> > Hi,
> > >> >
> > >> > I've borrowed this laptop for a few days.  Linux works pretty well,
> > >> > but I found a problem on newer kernels.  After suspend it claims the
> > >> > battery has been removed.  E.g. /proc/acpi/battery/BAT0/state claims
> > >> > the battery is not present (but it is).
> > >> >
> > >> > I've attached acpidump and dmidecode output at
> > >> > <http://bugzilla.kernel.org/show_bug.cgi?id=13745>.  I still have
> > >> > access to the laptop for further tests, but only until Friday.
> > >> >
> > >> > I bisected it to the commit below.  Manually reverting the patch fixes
> > >> > the problem (in both 2.6.30 and 2.6.31-rc2).
> > >>
> > >> Well, the commit below can't be reverted, because that would cause the boxes
> > >> it fixed to stop working.
> > >>
> > >> Now, the only case this patch can make any difference is when the BIOS doesn't
> > >> set SCI_EN before returning control the the kernel, which quite evidently is a
> > >> BIOS bug.  The fact that the battery doesn't work with this patch applied means
> > >> that the BIOS not only doesn't set SCI_EN, but also expects it to remain unset,
> > >> which is insane.
> > >>
> > >> IMO this is a "won't fix", sorry.
> > >
> > > Lets be pragmatic here..
> > >
> > > Besides this is a regression and we are already handling some such insane
> > > systems in STR case.  Moreover sending SMI ACPI_ENABLE command may result in
> > > some things happening behind our back and not only setting of SCI_EN bit..
> > >
> > > PS Looking at the set_sci_en_on_resume quirk history it seems that if we are
> > > lucky we may may fix another issue (screaming IRQ one) at the same time :)
> > >
> > > Alan, could you try this patch?
> > >
> > > ---
> > > debug patch (needs to have both CONFIG_SUSPEND=y & CONFIG_HIBERNATION=y)
> > >
> > >  drivers/acpi/sleep.c |   13 ++++++++++++-
> > >  1 file changed, 12 insertions(+), 1 deletion(-)
> > >
> > > Index: b/drivers/acpi/sleep.c
> > > ===================================================================
> > > --- a/drivers/acpi/sleep.c
> > > +++ b/drivers/acpi/sleep.c
> > > @@ -383,6 +383,14 @@ static struct dmi_system_id __initdata a
> > >                },
> > >        },
> > >        {
> > > +       .callback = init_set_sci_en_on_resume,
> > > +       .ident = "Hewlett-Packard HP G7000 Notebook PC",
> > > +       .matches = {
> > > +               DMI_MATCH(DMI_SYS_VENDOR, "Hewlett-Packard"),
> > > +               DMI_MATCH(DMI_PRODUCT_NAME, "HP G7000 Notebook PC"),
> > > +               },
> > > +       },
> > > +       {
> > >        .callback = init_old_suspend_ordering,
> > >        .ident = "Panasonic CF51-2L",
> > >        .matches = {
> > 
> > Thanks for coding this up for me in full.  It works, the battery now
> > survives, and it does indeed remove the IRQ warning.
> 
> Great, thanks for testing, Bart, thanks for the patch!
> 
> Len, can you add the Bart's patch to your 2.6.31 queue, please?

Here is the final patch version:

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] acpi: HP G7000 Notebook needs a SCI_EN resume quirk

This fixes regression (battery "vanishing" on resume) introduced by
commit d0c71fe7ebc180f1b7bc7da1d39a07fc19eec768 ("ACPI Suspend: Enable
ACPI during resume if SCI_EN is not set") and also the issue with
the "screaming" IRQ 9.

Fixes:
	http://bugzilla.kernel.org/show_bug.cgi?id=13745

Reported-and-tested-by: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
Acked-by: Rafael J. Wysocki <rjw@sisk.pl>
Cc: stable@kernel.org
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
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


