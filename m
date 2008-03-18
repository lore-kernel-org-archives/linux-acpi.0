From: Pavel Machek <pavel@suse.cz>
Subject: Re: suspend slow in 2.6.25-rc6 (was Re: Suspend and hibernation
	patchset against -rc6)
Date: Tue, 18 Mar 2008 14:07:10 +0100
Message-ID: <20080318130710.GB1609@elf.ucw.cz>
References: <200803120129.25585.rjw@sisk.pl> <200803172317.33745.rjw@sisk.pl> <20080318130642.GA1609@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:51139 "EHLO
	gprs189-60.eurotel.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752622AbYCRNba (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 18 Mar 2008 09:31:30 -0400
Content-Disposition: inline
In-Reply-To: <20080318130642.GA1609@elf.ucw.cz>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: pm list <linux-pm@lists.linux-foundation.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Alan Stern <stern@rowland.harvard.edu>, David Brownell <david-b@pacbell.net>, Greg KH <greg@kroah.com>, Len Brown <lenb@kernel.org>, LKML <linux-kernel@vger.kernel.org>, Shaohua Li <shaohua.li@intel.com>, Alexey Starikovskiy <astarikovskiy@suse.de>, Johannes Berg <johannes@sipsolutions.net>

On Tue 2008-03-18 14:06:42, Pavel Machek wrote:
> 
> Confirmed, suspend slowness is in 2.6.25-rc6, too. It takes 15 seconds
> to suspend/resume, while 2.6.24 takes 9. Thinkpad x60.

IIRC 2.6.25-rc5 was "fast".
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
pomozte zachranit klanovicky les:  http://www.ujezdskystrom.info/
