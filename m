From: Thomas Renninger <trenn@suse.de>
Subject: Re: [RESEND] [PATCH 2/3] Introduce acpi_root_table=rsdt boot param and dmi list to force rsdt
Date: Tue, 21 Oct 2008 11:57:44 +0200
Message-ID: <200810211157.46134.trenn@suse.de>
References: <200810192350.57993.trenn@suse.de> <20081020175124.GH18277@khazad-dum.debian.net> <20081020175814.GA13067@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ns2.suse.de ([195.135.220.15]:55871 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753562AbYJUJ5s (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 21 Oct 2008 05:57:48 -0400
In-Reply-To: <20081020175814.GA13067@srcf.ucam.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Len Brown <lenb@kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>, Zhao Yakui <yakui.zhao@intel.com>, me@markdoughty.co.uk, linux-thinkpad <linux-thinkpad@linux-thinkpad.org>, "devel@acpica.org" <devel@acpica.org>

On Monday 20 October 2008 19:58:14 Matthew Garrett wrote:
> On Mon, Oct 20, 2008 at 03:51:24PM -0200, Henrique de Moraes Holschuh wrote:
> > On Mon, 20 Oct 2008, Matthew Garrett wrote:
> > > But *why* is Vista not showing the symptoms?
> >
> > I very much doubt anyone ever attempted to run Vista on a R40e or a R50e.
> > It probably won't work well on the T4x/R51/R52 either, but I haven't
> > tried.
>
> I'd be surprised if nobody has done it. The hardware is above the
> minimum spec.
>
> > > values in the table were never caught because, for some reason, Windows
> > > never used them. The bug is that we're not using the same heuristic as
> > > Windows. Applying a static list of hardware just results in it being
> > > likely that we'll never fix that bug.
> >
> > I am a bit lost, now.  Are you talking about newer ThinkPads with
> > Vista-capable BIOSes, or the older ones that can't handle it and thus are
> > only subject to some ACPI access patterns when running Linux?
>
> The R40e and R50e have differing values in the RSDT and XSDT tables.
> Linux uses the values from the XSDT, which apparently results in a
> system hang whenever you attempt to perform C-state manipulation. Using
> the RSDT values instead avoids this. Windows works fine, so is clearly
> using the RSDT values. However, we have no knowledge of what mechanism
> Windows uses to choose between the two sets of values.

Yes we have:
 - XP uses 32 bit addresses
 - Vista uses the newer FADT revision and there the 64 bit addresses.

This information is from BIOS engineers who should know Windows behaviour much 
better than we ever could.

You may still want to install Windows and do some tests, I won't.
Until you find a better solution (I really tried and I doubt there is one), 
please don't block these patches again.

The problem is known for a year now, the patches are posted the third time and 
still the machines are broken mainline, because some people don't like the 
blacklist, want to do it more generic, but have no idea how to do that. Maybe 
you have, then please speak up.

The problem you try to solve is:
Can it be detected whether the system supports Vista at FADT parse time.
Do you have a solution or at least an idea for that?
Do you have another (unintrusive for old machines) idea?

IMO:
  - This is not possible.
  - This shouldn't be done anyway. You would change the behaviour of all
    old machines (Be aware that there may be server BIOSes which
    explicitly did it the right thing for Linux, not caring about Windows XP).
    All this for two BIOSes for which Lenovo admits that they are broken.

The right thing to do (at least for now) is to blacklist these two broken 
BIOSes.
If there really should be other machines having such an issue you now have the 
boot param to test easily, but I doubt you find more machines with this 
problem.

Thanks,

      Thomas
