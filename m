From: Len Brown <lenb@kernel.org>
Subject: Re: suspend order - again
Date: Thu, 27 Mar 2008 11:43:28 -0400
Message-ID: <200803271143.28972.lenb@kernel.org>
References: <1205482960.23855.4.camel@sli10-desk.sh.intel.com> <200803141254.55597.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:33105 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753453AbYC0PoG (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 27 Mar 2008 11:44:06 -0400
In-Reply-To: <200803141254.55597.rjw@sisk.pl>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Shaohua Li <shaohua.li@intel.com>, linux acpi <linux-acpi@vger.kernel.org>

On Friday 14 March 2008, Rafael J. Wysocki wrote:
> On Friday, 14 of March 2008, Shaohua Li wrote:
> > I just found a system (Asus A6B00VC) suffers a regression of suspend
> > order adjust. In the system, if _PTS is called before pci device
> > suspend, pci config read of slot 01:01.0 will always return 0xffffffff
> > (only this slot, not other devices). Adding acpi_new_pts_ordering fixes
> > this. I checked the log, _PTS itself doesn't generate any pci config
> > access, it appears _PTS call into SMBIOS and changes something. Note,
> > this is ACPI 1.0 table. Should we just blacklist the system or re-think
> > the suspend order?
> 
> I don't want to change the ordering of code.  It's been changed for many times
> and it always turned out that some systems didn't work.
> 
> If we can implement the blacklisting in a reasonable fashion, I'd prefer to do
> just that.

It isn't obvious to me why this regression is exempt from the
normal response we have to regressions found during -rc.
Particullarly sinced it was root caused to show that
we did the right thing before and we do the wrong thing now.

-Len
