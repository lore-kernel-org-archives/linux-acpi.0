From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [RESEND] [PATCH 2/3] Introduce acpi_root_table=rsdt boot param and dmi list to force rsdt
Date: Tue, 21 Oct 2008 16:27:55 +0100
Message-ID: <20081021152755.GA30633@srcf.ucam.org>
References: <200810192350.57993.trenn@suse.de> <200810211625.47889.rjw@sisk.pl> <20081021142956.GA29837@srcf.ucam.org> <200810211710.32384.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:42970 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751118AbYJUP2C (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 21 Oct 2008 11:28:02 -0400
Content-Disposition: inline
In-Reply-To: <200810211710.32384.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Thomas Renninger <trenn@suse.de>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Len Brown <lenb@kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>, Zhao Yakui <yakui.zhao@intel.com>, me@markdoughty.co.uk, linux-thinkpad <linux-thinkpad@linux-thinkpad.org>, "devel@acpica.org" <devel@acpica.org>

On Tue, Oct 21, 2008 at 05:10:31PM +0200, Rafael J. Wysocki wrote:
> On Tuesday, 21 of October 2008, Matthew Garrett wrote:
> > How? We *know* we're deviating from the behaviour of Windows here. What 
> > we don't know is how that will affect different machines. I suspect 
> > we'll end up with a bunch of "Well, I added this boot option and then my 
> > system booted slightly faster" and have no ability to work out whether 
> > the problem's actually related.
> 
> Well, this is similar to suspend problems where many different issues may
> give the same symptom.  In these cases we also often have very limited
> possibility to figure out why some particular workaround actually works on
> given machine type, but with no access to the machine and with a bug reporter
> who can't compile the kernel himself all we can do is to verify that it sort of
> works.  By putting the machine into a blacklist we can at least make Linux more
> usable to the user in question, which also is important.

Right, but in this case we understand the root cause of the problem - we 
behave differently to Windows in a very specific way. What we don't 
understand are the precise circumstances in which Windows behaves that 
way. It could be that Vista always uses the 64-bit addresses if 
available, and in that case this is the best possible solution. But it 
could also be that Vista swaps addresses based on whether _INI requests 
the Vista OSI or not. It could be that Vista uses the 32-bit addresses 
on 32-bit CPUs. Or where the addresses differ and there's a valid 32-bit 
entry, perhaps they use that. When there's a simple test to perform, we 
should do that before adding a static list.

> > See the number of people who reported that acpi_apic_instance made a
> > difference, or even the fact that Thomas included a bunch of systems with no
> > real assurance that they were hit by this.
> 
> Hm, this is not a good thing.  Is there any reliable way to verify that?

We can verify whether the addresses are actually different, but it's 
possible that that's harmless on some machines. However, history 
suggests that there's a placebo effect in adding boot options...

-- 
Matthew Garrett | mjg59@srcf.ucam.org
