From: Thomas Renninger <trenn@suse.de>
Subject: Re: [RESEND] [PATCH 2/3] Introduce acpi_root_table=rsdt boot param and dmi list to force rsdt
Date: Tue, 21 Oct 2008 16:45:44 +0200
Message-ID: <200810211645.45945.trenn@suse.de>
References: <200810192350.57993.trenn@suse.de> <200810211625.47889.rjw@sisk.pl> <20081021142956.GA29837@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.suse.de ([195.135.220.2]:33989 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751605AbYJUOps (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 21 Oct 2008 10:45:48 -0400
In-Reply-To: <20081021142956.GA29837@srcf.ucam.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Len Brown <lenb@kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>, Zhao Yakui <yakui.zhao@intel.com>, me@markdoughty.co.uk, linux-thinkpad <linux-thinkpad@linux-thinkpad.org>, "devel@acpica.org" <devel@acpica.org>

On Tuesday 21 October 2008 16:29:56 Matthew Garrett wrote:
> On Tue, Oct 21, 2008 at 04:25:46PM +0200, Rafael J. Wysocki wrote:
> > On Tuesday, 21 of October 2008, Matthew Garrett wrote:
> > > We've no idea how many other systems may be affected in one way or
> > > another.
> >
> > Yes, and the list may help us to get an idea IMO.
>
> How? We *know* we're deviating from the behaviour of Windows here.
Matthew, there is no solution to stick to the Windows behaviour.
Even if hundreds of machines are affected, you have still not yet come up with 
a generic solution, but try to block the fix.
> What 
> we don't know is how that will affect different machines.
> we'll end up with a bunch of "Well, I added this boot option and then my
> system booted slightly faster" and have no ability to work out whether
> the problem's actually related. See the number of people who reported
> that acpi_apic_instance made a difference, or even the fact that Thomas
> included a bunch of systems with no real assurance that they were hit by
> this.
This is simply a fact of missing resources.
It cost me hours to debug it that far down and I still have to argue getting 
it finally fixed, even there is no alternative (presented yet) (there is no 
generic way to fix it). And yes the bugs are anoying, but not critical so I 
will probably not look at it any further.

> A static list will eventually end up either filled with false positives
> or missing several machines that should be there.

This is a problem of two broken ThinkPad BIOSes.
Go ahead and install some Windowses to prove the opposite. Until you do (and 
then still have no solution for a generic fix), pls do not further try to 
block getting this fixed.

   Thomas
