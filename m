From: Andi Kleen <ak@suse.de>
Subject: Re: [RFC] [PATCH] ACPI :Modify timer override connection in Some NVIDIA systems
Date: Wed, 17 Oct 2007 11:58:19 +0200
Message-ID: <200710171158.19578.ak@suse.de>
References: <1192172655.27194.29.camel@yakui_zhao.sh.intel.com> <200710162351.32953.ak@suse.de> <1192611639.15762.7.camel@yakui_zhao.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:35828 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756288AbXJQJ60 (ORCPT <rfc822;Linux-acpi@vger.kernel.org>);
	Wed, 17 Oct 2007 05:58:26 -0400
In-Reply-To: <1192611639.15762.7.camel@yakui_zhao.sh.intel.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhao Yakui <yakui.zhao@intel.com>
Cc: Chuck Ebbert <cebbert@redhat.com>, Linux-acpi@vger.kernel.org, lenb@kernel.org, Thomas Gleixner <tglx@linutronix.de>

On Wednesday 17 October 2007 11:00:39 Zhao Yakui wrote:
> On Tue, 2007-10-16 at 23:51 +0200, Andi Kleen wrote:
> > On Tuesday 16 October 2007 23:07:29 Chuck Ebbert wrote:
> > 
> > > Do I need something more than early-quirks-unification and nvidia-timer-quirk?
> > > Because those two don't fix anything; I have to manually force
> > > acpi_use_timer_override to get things to work right. The RFC patch seems to
> > > be doing the right thing automatically.
> > > 
> > > Hardware: nVidia MCP51/C51 (with HPET)
> > > Host Bridge PCI ID: 10de:02f0
> > 
> > Do you see the "Nvidia board detected. Ignoring ACPI timer override." message?
> When booted with acpi=off, the system will print the message ---Nvidia
> board detected .Ignoring ACPI timer override. 
> But when booted with acpi on, the system won't print the above message. 

That was a NF5 system right? If yes the nvidia-timer-quirk patch should
work on it.

It didn't work on Chuck's system because that wasn't a NF5.
The main change nvidia-timer-quirk adds is to run the override ignore logic 
only on NF4 and NF3.

His system seems to be in a new situation: a NF4 system which needs
a timer override (that wasn't the case before!) and since most NF4 overrides
are wrong and Linux is ignoring them it won't work.

I don't really see how to handle this short of a DMI quirk for the board.
Your patch essentially hard codes the timer override for all of Nvidia which is surely
not the correct thing to do -- we have lots of evidence that those varies 
widely. Or at least if you really want to hard code you should only do it with a 
explicit DMI entry for a specific board.

> The chipset of NVIDIA is used and HPET exists. So the timer_override is
> required. But unfortunately the timer override info provided by BIOS is
> uncorrect. 

Most NF5 systems need timer override -- if some of them supply the wrong
one I don't see how to detect this short of a DMI quirk.

-Andi
