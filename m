From: Thomas Renninger <trenn@suse.de>
Subject: Re: HP nx8220 psmouse vs ACPI at boot up
Date: Thu, 19 Apr 2007 18:00:26 +0200
Message-ID: <1176998427.1231.423.camel@queen.suse.de>
References: <1176986698.1231.390.camel@queen.suse.de>
	 <200704190918.54467.bjorn.helgaas@hp.com>
Reply-To: trenn@suse.de
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.suse.de ([195.135.220.2]:35788 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1766814AbXDSQA2 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 19 Apr 2007 12:00:28 -0400
In-Reply-To: <200704190918.54467.bjorn.helgaas@hp.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-acpi <linux-acpi@vger.kernel.org>, kssingvo@suse.de

On Thu, 2007-04-19 at 09:18 -0600, Bjorn Helgaas wrote:
> On Thursday 19 April 2007 06:44, Thomas Renninger wrote:
> > I first thought it's the "unload psmouse" or "cleanup psmouse ports"
> > at shutdown problem again.
> > 
> > I think this time EC gets confused at boot time.
> > Compiling psmouse as module helps again.
> > 
> > Symptom:
> > AC adapter status is wrong if booted with AC unplugged.
> > Replugging helps.
> > This sounds like a minor bug, but ACPI errors at other places
> > with AE_TIME errors also happen and theoretically all kind of
> > ACPI breakage could happen...
> 
> Is there a more complete bug report for this, with the whole dmesg
> log?  Is this related to suspend/resume, or does it happen on all
> shutdown and restart?  Any chance you could collect the DSDT?

This is the bug report:
https://bugzilla.novell.com/show_bug.cgi?id=260794

Klaus: Could you also attach acpidump output to the bug, pls.

This is not related to suspend/resume.

> Does it happen on all shutdown and restart
-> Good question, first I was sure to be able to always reproduce this
on 2.6.1[68] kernels with psmouse module compiled in. Latest .21-rc7 was
unaffected.
I then removed thermal, fan, processor module to not get loaded via
initrd (gets loaded later at init 3 or 2). Since then the symptom
vanished. (even after adding the modules again. Maybe I mixed something
up in the end, or the order of modules loaded in initrd changed, but I
doubt it was that...)

However, if someone should see any AE_TIME ACPI errors on an HP, I'd try
to compile psmouse as module or compile it out, chances are high that it
helps..., I wonder whether more people see this, would be nice to get
some more reports.

    Thomas

