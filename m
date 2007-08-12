From: Mattia Dongili <malattia@linux.it>
Subject: Re: [PATCH 2/2] sony-laptop: old Vaio models contain 2 IO port
	entries
Date: Sun, 12 Aug 2007 13:26:43 +0900
Message-ID: <20070812042643.GB10937@inferi.kami.home>
References: <1186796587433-git-send-email-malattia@linux.it> <11867965871757-git-send-email-malattia@linux.it> <11867965873858-git-send-email-malattia@linux.it> <200708112327.44755.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mtoichi12.ns.itscom.net ([219.110.2.182]:65319 "EHLO
	mtoichi12.ns.itscom.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750901AbXHLE1B (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 12 Aug 2007 00:27:01 -0400
Content-Disposition: inline
In-Reply-To: <200708112327.44755.lenb@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, Stelian Pop <stelian@popies.net>

On Sat, Aug 11, 2007 at 11:27:44PM -0400, Len Brown wrote:
> On Friday 10 August 2007 21:43, Mattia Dongili wrote:
> > Make the driver aware of this case and manage the existence of a
> > second separate IO port.
> > Fixes http://bugzilla.kernel.org/show_bug.cgi?id=8803
> 
> Why is this marked as a regression vs 2.6.21?
> Is the problem that sonypi supported this this type of box
> and sony-laptop did not, and that is when the submitter
> started using sony-laptop?
> 
> They can still build and use sonypi in 2.6.22, 3 if they want, yes?

yes but they can't use meye.ko which now (since .22) depends on
sony-laptop loading correctly on their boxes.

> I don't see a huge risk in applying this patch, because it
> seems that it (should) only have an effect on the boxes
> that were not properly supported before.

yep, that's the purpose :)

> But, it is pretty big for a post-rc2 type thing,
> particularly if they can still use sonypi per above.
> Probably appropriate to test it till 2.6.24.

as said the problem is meye, but I agree it's not very appropriate as a
post-rc2.
Oh, and I seem to have some randomic Oops when loading the module (most
probably unrelated to this patch). Let me re-doublecheck it all once
again.

-- 
mattia
:wq!
