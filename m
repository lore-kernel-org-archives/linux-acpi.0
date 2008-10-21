From: Thomas Renninger <trenn@suse.de>
Subject: Re: [RESEND] [PATCH 2/3] Introduce acpi_root_table=rsdt boot param and dmi list to force rsdt
Date: Tue, 21 Oct 2008 15:05:33 +0200
Message-ID: <200810211505.34657.trenn@suse.de>
References: <200810192350.57993.trenn@suse.de> <200810211157.46134.trenn@suse.de> <20081021124604.GA27273@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.suse.de ([195.135.220.2]:54256 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751965AbYJUNFk (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 21 Oct 2008 09:05:40 -0400
In-Reply-To: <20081021124604.GA27273@srcf.ucam.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Len Brown <lenb@kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>, Zhao Yakui <yakui.zhao@intel.com>, me@markdoughty.co.uk, linux-thinkpad <linux-thinkpad@linux-thinkpad.org>, "devel@acpica.org" <devel@acpica.org>

On Tuesday 21 October 2008 14:46:04 Matthew Garrett wrote:
> On Tue, Oct 21, 2008 at 11:57:44AM +0200, Thomas Renninger wrote:
> > Yes we have:
> >  - XP uses 32 bit addresses
> >  - Vista uses the newer FADT revision and there the 64 bit addresses.
> >
> > This information is from BIOS engineers who should know Windows behaviour
> > much better than we ever could.
>
> If Vista is absolutely known to *always* use the 64-bit addresses under
> every single circumstance where they're present, then yes, I agree that
> this is probably the least bad situation. This is trivial to test -
> install Vista on an R40e and see if it hangs on boot. If it does, I
> withdraw my objection. If not, then we're not fixing it properly.

a) I don't have a R40e
b) I don't have a Vista
c) I wouldn't try anyway. I spend enough time on this one and I trust the
   people who told me Vista is using the 64 bit addresses
d) The commit Window is closing

If you have the time and knowledge to verify:
> If Vista is absolutely known to *always* use the 64-bit addresses under
> every single circumstance where they're present, then yes I agree that ...
then pls, go ahead.
Even if this is not proven, the patchset should still go in to get the 
machines fixed for now and to easily test others, there was enough discussion 
around it.

Thanks,

    Thomas
