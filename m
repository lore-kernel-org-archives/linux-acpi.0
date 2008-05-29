From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: [patch 2/2] PNPACPI: fix shareable IRQ encode/decode
Date: Thu, 29 May 2008 08:41:12 -0600
Message-ID: <200805290841.13561.bjorn.helgaas@hp.com>
References: <20080527224915.412211349@ldl.fc.hp.com> <200805281605.23556.bjorn.helgaas@hp.com> <483DE769.8070208@keyaccess.nl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g5t0009.atlanta.hp.com ([15.192.0.46]:9998 "EHLO
	g5t0009.atlanta.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752924AbYE2Olc (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 29 May 2008 10:41:32 -0400
In-Reply-To: <483DE769.8070208@keyaccess.nl>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Rene Herman <rene.herman@keyaccess.nl>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, Adam Belay <ambx1@neo.rr.com>, Adam M Belay <abelay@mit.edu>, Li Shaohua <shaohua.li@intel.com>, Matthieu Castet <castet.matthieu@free.fr>, Thomas Renninger <trenn@suse.de>, Andrew Morton <akpm@linux-foundation.org>, Tom Jaeger <ThJaeger@gmail.com>

On Wednesday 28 May 2008 05:14:49 pm Rene Herman wrote:
> On 29-05-08 00:05, Bjorn Helgaas wrote:
> 
> > On Wednesday 28 May 2008 02:58:47 pm Rene Herman wrote:
> >> On 28-05-08 00:49, Bjorn Helgaas wrote:
> >>
> >>> When we encode IRQ resources, we should use the "shareable"
> >>> flag we got from _PRS rather than guessing based on the
> >>> IRQ trigger mode.
> >>>
> >>> This is based on a patch by Tom Jaeger <ThJaeger@gmail.com>:
> >>>     http://bugzilla.kernel.org/show_bug.cgi?id=9487#c32
> >>>
> >>> Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
> >> Not-commented-on-by: Rene Herman <rene.herman@gmail.com>
> >>
> >> Makes sense patchwise but one would expect that it wasn't that way to 
> >> start with due to perhaps some/many/most BIOSen not encoding the flag 
> >> correctly in _PRS. Don't know ACPI though...
> > 
> > I added IORESOURCE_IRQ_SHAREABLE recently:
> >   http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=c32928c579d88acd43981b59e86900da65f40762
> > 
> > and I just didn't notice these places at the time.  If I had,
> > I would have made this change then.  It's possible we could
> > trip over a BIOS issue, but I don't *think* that's why it's
> > been this way in the past.
> 
> Ah, I see. Was likely just a matter of originally not having a place to 
> stash it then (by the way, time flies; "recently" is almost two years 
> ago...)

Yep.  Time does fly when you're having fun :-)

