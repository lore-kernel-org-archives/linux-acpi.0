From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [PATCH 5/6] X86 platform drivers: Remove EC dump from
 thinkpad_acpi
Date: Thu, 1 Jul 2010 20:26:03 -0300
Message-ID: <20100701232603.GA15824@khazad-dum.debian.net>
References: <1277996570-2686-1-git-send-email-trenn@suse.de>
 <1277996570-2686-6-git-send-email-trenn@suse.de>
 <20100701162741.GC4789@khazad-dum.debian.net>
 <201007012131.20031.trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:35726 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752493Ab0GAX0I (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 1 Jul 2010 19:26:08 -0400
Content-Disposition: inline
In-Reply-To: <201007012131.20031.trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: lenb@kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org, astarikovskiy@suse.de, ibm-acpi-devel@lists.sourceforge.net

On Thu, 01 Jul 2010, Thomas Renninger wrote:
> > Soes your helper userspace util do the "differential" analysis that
> > thinkpad-acpi used to (the "*" after values that changed since last read)?
> No.
> But this should not be important enough to not get this removed.

Consider it a feature request ;-)

> It's hard to re-implement the exact behaviour (which can be handy for
> specific problems, I agree).
> With:
> watch -n1 ec_access -r
> you can have a close look at specific registers and see them changing.
> Whatabout:
> ec_access -r -s time(s)
> Reads the table once and again after "time" seconds with stars
> where modifications happened. Then someone can plug AC or hit a button
> and look at the diff in EC registers afterwards.
> This should be sufficient?

Yes.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
