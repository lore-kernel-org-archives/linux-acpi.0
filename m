From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: suspend order - again
Date: Thu, 27 Mar 2008 17:42:17 +0100
Message-ID: <200803271742.17714.rjw@sisk.pl>
References: <1205482960.23855.4.camel@sli10-desk.sh.intel.com> <200803141254.55597.rjw@sisk.pl> <200803271143.28972.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:46034 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756287AbYC0Qma (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 27 Mar 2008 12:42:30 -0400
In-Reply-To: <200803271143.28972.lenb@kernel.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Shaohua Li <shaohua.li@intel.com>, linux acpi <linux-acpi@vger.kernel.org>

On Thursday, 27 of March 2008, Len Brown wrote:
> On Friday 14 March 2008, Rafael J. Wysocki wrote:
> > On Friday, 14 of March 2008, Shaohua Li wrote:
> > > I just found a system (Asus A6B00VC) suffers a regression of suspend
> > > order adjust. In the system, if _PTS is called before pci device
> > > suspend, pci config read of slot 01:01.0 will always return 0xffffffff
> > > (only this slot, not other devices). Adding acpi_new_pts_ordering fixes
> > > this. I checked the log, _PTS itself doesn't generate any pci config
> > > access, it appears _PTS call into SMBIOS and changes something. Note,
> > > this is ACPI 1.0 table. Should we just blacklist the system or re-think
> > > the suspend order?
> > 
> > I don't want to change the ordering of code.  It's been changed for many times
> > and it always turned out that some systems didn't work.
> > 
> > If we can implement the blacklisting in a reasonable fashion, I'd prefer to do
> > just that.
> 
> It isn't obvious to me why this regression is exempt from the
> normal response we have to regressions found during -rc.
> Particullarly sinced it was root caused to show that
> we did the right thing before and we do the wrong thing now.

Hm, is it a post-2.6.24 one?  Ah, it is.

Well, ok.  In fact we have examples both ways now, but I really won't be
comfortable with changing the default ordering once again.

OTOH, the "ACPI 2.0" ordering is more logical IMO ...

Thanks,
Rafael
