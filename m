From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RESEND] [PATCH 2/3] Introduce acpi_root_table=rsdt boot param and dmi list to force rsdt
Date: Tue, 21 Oct 2008 17:10:31 +0200
Message-ID: <200810211710.32384.rjw@sisk.pl>
References: <200810192350.57993.trenn@suse.de> <200810211625.47889.rjw@sisk.pl> <20081021142956.GA29837@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:53869 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751339AbYJUPGQ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 21 Oct 2008 11:06:16 -0400
In-Reply-To: <20081021142956.GA29837@srcf.ucam.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Thomas Renninger <trenn@suse.de>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Len Brown <lenb@kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>, Zhao Yakui <yakui.zhao@intel.com>, me@markdoughty.co.uk, linux-thinkpad <linux-thinkpad@linux-thinkpad.org>, "devel@acpica.org" <devel@acpica.org>

On Tuesday, 21 of October 2008, Matthew Garrett wrote:
> On Tue, Oct 21, 2008 at 04:25:46PM +0200, Rafael J. Wysocki wrote:
> > On Tuesday, 21 of October 2008, Matthew Garrett wrote:
> > > We've no idea how many other systems may be affected in one way or another.
> > 
> > Yes, and the list may help us to get an idea IMO.
> 
> How? We *know* we're deviating from the behaviour of Windows here. What 
> we don't know is how that will affect different machines. I suspect 
> we'll end up with a bunch of "Well, I added this boot option and then my 
> system booted slightly faster" and have no ability to work out whether 
> the problem's actually related.

Well, this is similar to suspend problems where many different issues may
give the same symptom.  In these cases we also often have very limited
possibility to figure out why some particular workaround actually works on
given machine type, but with no access to the machine and with a bug reporter
who can't compile the kernel himself all we can do is to verify that it sort of
works.  By putting the machine into a blacklist we can at least make Linux more
usable to the user in question, which also is important.

Technically, this doesn't _fix_ the problem, but it vastly improves user
experience.

> See the number of people who reported that acpi_apic_instance made a
> difference, or even the fact that Thomas included a bunch of systems with no
> real assurance that they were hit by this.

Hm, this is not a good thing.  Is there any reliable way to verify that?

> A static list will eventually end up either filled with false positives 
> or missing several machines that should be there.

While there may be false positives and missing items in the list, at least we
can learn from it which machines _may_ be affected and what's the number of
such machines (the order of magnitude).
