From: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Subject: Re: [RESEND] [PATCH] Fujitsu-laptop update
Date: Thu, 12 Jun 2008 09:32:53 +0930 (CST)
Message-ID: <200806120002.m5C02rQo014728@turbo.physics.adelaide.edu.au>
References: <alpine.LFD.1.10.0806110415380.4233@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from adelphi.physics.adelaide.edu.au ([129.127.102.1]:38827 "EHLO
	adelphi.physics.adelaide.edu.au" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753861AbYFLADL (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Wed, 11 Jun 2008 20:03:11 -0400
In-Reply-To: <alpine.LFD.1.10.0806110415380.4233@localhost.localdomain> from "Len Brown" at Jun 11, 2008 04:17:20 AM
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>, linux-acpi@vger.kernel.org

Len

> On Wed, 11 Jun 2008, Jonathan Woithe wrote:
> > > Thanks for the ping, yes, this one slipped through the cracks
> > > and I can drop it intot he acpi-test tree.
> > Thanks.
> > 
> > > Should we add you to MAINTAINERS for this driver?
> > I'm happy for this to happen if you feel it's a good idea.  A patch doing
> > this is included at the end of this email.
> > 
> > > this patch fails scripts/checkpatch.pl in an number of ways,
> > Oops, so it does.  Sorry about that.
> > 
> > > and it fails to apply due to a small patch that akpm sent to linus on this 
> > > file.
> > > please refresh and resend.
> > Done - see below.
> 
> applied to acpi-test

Thanks.

> (I'm don't going to worry about the 80-column violations -- don't tell 
> the style police:-)

:-) Yeah, sorry about the number of >80 column lines.  I looked at
addressing this (and did fix a few) but decided that in most of the cases
reducing the lines to <80 characters would mean breaking indentation style
or line-breaking code in strange places.  Either would make the code harder
to read so I left the lines as is.

Regards
  jonathan
