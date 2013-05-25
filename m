From: Josh Triplett <josh@joshtriplett.org>
Subject: Re: [PATCH] efi: Work around bogus pointers in BGRT
Date: Sat, 25 May 2013 12:50:37 -0700
Message-ID: <20130525195037.GA30094@leaf>
References: <CALCETrX2yUzVLTAabrdDM1zgZnRL+KWEJoqSu2VM5jMaArAjpg@mail.gmail.com>
 <7ccd9d84f7407ba65c1f03d144e2113dee0d797a.1368824585.git.luto@amacapital.net>
 <20130524053737.GB6380@leaf>
 <CALCETrVz0W--YybyLatG1MW=pkdGa2PdR0d2hrfXUSXT0=K4fw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from slow1-d.mail.gandi.net ([217.70.178.86]:51088 "EHLO
	slow1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757763Ab3EYTw4 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 25 May 2013 15:52:56 -0400
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	by slow1-d.mail.gandi.net (Postfix) with ESMTP id 37B7A47B289
	for <linux-acpi@vger.kernel.org>; Sat, 25 May 2013 21:51:14 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <CALCETrVz0W--YybyLatG1MW=pkdGa2PdR0d2hrfXUSXT0=K4fw@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andy Lutomirski <luto@amacapital.net>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>, Matthew Garrett <mjg59@srcf.ucam.org>

On Fri, May 24, 2013 at 06:15:16PM -0700, Andy Lutomirski wrote:
> On Thu, May 23, 2013 at 10:37 PM, Josh Triplett <josh@joshtriplett.org> wrote:
> > On Fri, May 17, 2013 at 02:05:33PM -0700, Andy Lutomirski wrote:
> >> The MSI MS-7760 supplies a BGRT marked "invalid" that contains a
> >> pointer to nowhere.  Since an "invalid" BGRT isn't particularly
> >> useful (userspace isn't supposed to use it anyway), ignore the BGRT
> >> if it's marked "invalid" and the pointer points outside of EFI boot
> >> services space.
> >>
> >> Signed-off-by: Andy Lutomirski <luto@amacapital.net>
> >
> > I'd suggest generalizing the comment to not just mention the one system
> > you observed it on.  In any case, I'm fine with this patch, but I seem
> > to recall Matthew Garrett having some objections to ignoring the BGRT
> > when the valid bit is not set.  Also, if you're going to do so, you
> > might as well not expose the valid bit to userspace.
> 
> Hmm.
> 
> Not exposing the valid bit to userspace would be a bit odd -- it's
> part of a bitfield which (in principle, I think) could have other bits
> defined.
> 
> One option would be to still load the bgrt table if invalid but to not
> try to load the image and to therefore not show that sysfs attribute.
> I don't know what this would break because I don't know what userspace
> programs actually use bgrt.

That sounds sensible to me: there's a BGRT, so load it and expose it,
but with "valid" not set, don't attempt to look at the image.

- Josh Triplett
