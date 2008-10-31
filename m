From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Bisection result: eeepc hotk breakage
Date: Fri, 31 Oct 2008 15:58:53 +0100
Message-ID: <200810311558.53888.rjw@sisk.pl>
References: <4907A511.3040603@tuffmail.co.uk> <490B0D48.7040209@suse.de> <490B0DCB.40009@tuffmail.co.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:55725 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750978AbYJaOy1 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 31 Oct 2008 10:54:27 -0400
In-Reply-To: <490B0DCB.40009@tuffmail.co.uk>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
Cc: Alexey Starikovskiy <astarikovskiy@suse.de>, Alexey Starikovskiy <aystarik@gmail.com>, linux acpi <linux-acpi@vger.kernel.org>, Matthew Wilcox <willy@linux.intel.com>

On Friday, 31 of October 2008, Alan Jenkins wrote:
> Alexey Starikovskiy wrote:
> >
> > Alan Jenkins wrote:
> >> Alexey Starikovskiy wrote:
> >>> Alan Jenkins wrote:
> >>>> Well, that didn't work.
> >>> Pity...
> >>> Could you produce a debug log from EC?
> >>> Probably it's a good time to open a new bug report...
> >>
> >> <http://bugzilla.kernel.org/show_bug.cgi?id=11917>
> >> "Asus Eee PC hotkeys stop working after prolonged usage"
> >>
> >> I stuck at it, found a reliable test and bisected successfully.
> >> 2.6.28-rc2 is broken, but I can fix it by reverting the bad commit.
> >> (There were some conflicts, I fixed up the dock driver manually and
> >> avoided building the rest).
> > Alan, to make things clear -- reverting following commit makes EC work
> > without
> > a problem?
> >
> 
> 
> Yes, that's right.

Hm, so in fact it _is_ a regression from 2.6.27 (this commit could not be
present in that kernel).

Thanks,
Rafael


> >> 27663c5855b10af9ec67bc7dfba001426ba21222 is first bad commit
> >> commit 27663c5855b10af9ec67bc7dfba001426ba21222
> >> Author: Matthew Wilcox <willy@linux.intel.com>
> >> Date:   Fri Oct 10 02:22:59 2008 -0400
> >>
> >>     ACPI: Change acpi_evaluate_integer to support 64-bit on 32-bit
> >> kernels
> >>
> >>     As of version 2.0, ACPI can return 64-bit integers.  The current
> >>     acpi_evaluate_integer only supports 64-bit integers on 64-bit
> >> platforms.
> >>     Change the argument to take a pointer to an acpi_integer so we
> >> support
> >>     64-bit integers on all platforms.
> >>
> >>     lenb: replaced use of "acpi_integer" with "unsigned long long"
> >>     lenb: fixed bug in acpi_thermal_trips_update()
> >>
> >>     Signed-off-by: Matthew Wilcox <willy@linux.intel.com>
> >>     Signed-off-by: Len Brown <len.brown@intel.com>
> >
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 


