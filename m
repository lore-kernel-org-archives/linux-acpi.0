From: Thomas Renninger <trenn@suse.de>
Subject: Re: Fan speeds on HP nc6400 and nc8430
Date: Mon, 05 Feb 2007 19:59:00 +0100
Message-ID: <1170701940.25027.422.camel@d36.suse.de>
References: <C3FA62B1A90D7440B9B6C7C31895994F0366363A@zadbn02100.vodacom.corp>
	 <3877989d0701232019g45af8feaxabdcf6ba77170a5d@mail.gmail.com>
	 <200701232138.54758.bjorn.helgaas@hp.com>
	 <200701240954.32742.bjorn.helgaas@hp.com>
Reply-To: trenn@suse.de
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ns.suse.de ([195.135.220.2]:46482 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933360AbXBES7C (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 5 Feb 2007 13:59:02 -0500
In-Reply-To: <200701240954.32742.bjorn.helgaas@hp.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Luming Yu <luming.yu@gmail.com>, emisca <emisca.ml@gmail.com>, Alexey Starikovskiy <alexey.y.starikovskiy@linux.intel.com>, Pieter De Wit <Pieter.DeWit@vodacom.co.za>, linux-acpi@vger.kernel.org, dtor@mail.ru

On Wed, 2007-01-24 at 09:54 -0700, Bjorn Helgaas wrote:
> On Tuesday 23 January 2007 21:38, Bjorn Helgaas wrote:
> > On Tuesday 23 January 2007 21:19, Luming Yu wrote:
> > > On 1/19/07, emisca <emisca.ml@gmail.com> wrote:
> > > > The TZ4 thermal zone on all the hp compaq line nx**** and nc**** is
> > > > not a temperature but the fan speed. You can see this information on
> > > > the web and on hp forums.
> > > 
> > > Where is the hp forums.
> > 
> > I don't work on laptops, so I can't confirm this, but Google found
> > this (from "tz4 thermal zone fan speed hp"):
> > 
> > http://forums1.itrc.hp.com/service/forums/bizsupport/questionanswer.do?threadId=1052925
> 
> Someone also sent me this, which I'll include in case it helps anybody
> else.  Obviously, scripts like the one mentioned below are stop-gaps
> that shouldn't be necessary.  But the script might have useful hints
> about how to fix the kernel so the script would no longer be needed.
> 
> > Take a look at this:
> > http://daniel.graziotin.net/2006/12/02/hp-nx6325-and-friends-thermal-problems-solved this fixed my thermal problem.
> > And make sure you unload the psmouse module during halt/reboot
> > otherwise you have problemes when you start your notebook again.
> > (symptom's: very long BIOS-Boot, ACPI-problems (thermal)..)

I have a patch that should fix the psmouse unload thing (at the end).
Not sure whether it's still needed in 2.6.20-rcX, there was some work
done... it definitely helps on 2.6.18 and 2.6.16 kernels.
Ok, I quickly tried on 2.6.20-rc7 and it seems to work without the
patch.
Maybe Dmitry can comment on that and push this one if still needed?

It's quite difficult to get the overview over the HP problems, as there
are several, some quite weird, and a lot different reports.

I've found out that the psmouse thing really fixes things.

and I got a lot reports that Alexeys patch (and the
unregister_serio_drivers attached) fixes up things:
https://bugzilla.novell.com/show_bug.cgi?id=179702
https://bugzilla.novell.com/show_bug.cgi?id=234475
As this patch broke Linus' machine, I understand that Len is a bit
anxious, but a lot people tested the reworked patch (it's currently in
10.2 and SLE10-SP1 SuSE branches), it would be great if Len can push it
at least for the next kernel cycle...

What is still broken, but patches are available, is fan state after
suspend/resume.

Thanks to Rafael, there is a list of patches that seem to help
(including Alexey's and some others) here:
http://www.sisk.pl/kernel/patches/2.6.20-rc5/

Most of them seem to come from:
http://bugzilla.kernel.org/show_bug.cgi?id=5534
and
http://bugzilla.kernel.org/show_bug.cgi?id=7122

Can someone give an overview about what is already submitted, what is
going to be merged and where/when (-mm, rcX, 2.6.21-rc1, ...).
All kind of comments/review/tests are very welcome...

Some of the patches miss a comment...

Thanks,

    Thomas

-----------------------------------------------------------

Subject: Unregister serio drivers on shutdown
From: Thomas Renninger <trenn@suse.de>


Unproved theory:
It seems that the Embedded Controller needs this at ACPI shutdown time:
    psmouse_set_state(psmouse, PSMOUSE_CMD_MODE);
    psmouse_set_state(psmouse, PSMOUSE_IGNORE);
done in psmouse_disconnect in psmouse module.

If this is not done on shutdown it leads to very strange BIOS/EC behaviour
on latest HP laptops which even survives a reboot (cpufreq cannot reach max
freq, BIOS takes long to boot, etc.). Then the fixed kernel needs to
be booted twice, that machine reaches max freq and behaves normal again.

Ref: http://bugzilla.kernel.org/show_bug.cgi?id=7689
https://bugzilla.novell.com/show_bug.cgi?id=179702


Signed-off-by: Thomas Renninger <trenn@suse.de>


 drivers/input/serio/serio.c |    1 +
 1 files changed, 1 insertion(+)

Index: linux-2.6.19/drivers/input/serio/serio.c
===================================================================
--- linux-2.6.19.orig/drivers/input/serio/serio.c
+++ linux-2.6.19/drivers/input/serio/serio.c
@@ -973,6 +973,7 @@ static struct bus_type serio_bus = {
 	.probe		= serio_driver_probe,
 	.remove		= serio_driver_remove,
 	.resume		= serio_resume,
+	.shutdown	= serio_driver_remove,
 };
 
 static int __init serio_init(void)


