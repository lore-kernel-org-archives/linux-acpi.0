From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: [patch 2/2] PNPACPI: fix shareable IRQ encode/decode
Date: Wed, 28 May 2008 16:05:22 -0600
Message-ID: <200805281605.23556.bjorn.helgaas@hp.com>
References: <20080527224915.412211349@ldl.fc.hp.com> <20080527224938.681457358@ldl.fc.hp.com> <483DC787.6070700@keyaccess.nl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g5t0009.atlanta.hp.com ([15.192.0.46]:33640 "EHLO
	g5t0009.atlanta.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752466AbYE1WFU (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 28 May 2008 18:05:20 -0400
In-Reply-To: <483DC787.6070700@keyaccess.nl>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Rene Herman <rene.herman@keyaccess.nl>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, Adam Belay <ambx1@neo.rr.com>, Adam M Belay <abelay@mit.edu>, Li Shaohua <shaohua.li@intel.com>, Matthieu Castet <castet.matthieu@free.fr>, Thomas Renninger <trenn@suse.de>, Andrew Morton <akpm@linux-foundation.org>, Tom Jaeger <ThJaeger@gmail.com>

On Wednesday 28 May 2008 02:58:47 pm Rene Herman wrote:
> On 28-05-08 00:49, Bjorn Helgaas wrote:
> 
> > When we encode IRQ resources, we should use the "shareable"
> > flag we got from _PRS rather than guessing based on the
> > IRQ trigger mode.
> > 
> > This is based on a patch by Tom Jaeger <ThJaeger@gmail.com>:
> >     http://bugzilla.kernel.org/show_bug.cgi?id=9487#c32
> > 
> > Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
> 
> Not-commented-on-by: Rene Herman <rene.herman@gmail.com>
> 
> Makes sense patchwise but one would expect that it wasn't that way to 
> start with due to perhaps some/many/most BIOSen not encoding the flag 
> correctly in _PRS. Don't know ACPI though...

I added IORESOURCE_IRQ_SHAREABLE recently:
  http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=c32928c579d88acd43981b59e86900da65f40762

and I just didn't notice these places at the time.  If I had,
I would have made this change then.  It's possible we could
trip over a BIOS issue, but I don't *think* that's why it's
been this way in the past.

Bjorn
