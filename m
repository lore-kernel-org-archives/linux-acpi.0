From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: ACPI: EC: GPE storm detected, transactions will use polling mode
Date: Sun, 16 Nov 2008 13:44:07 +0100
Message-ID: <200811161344.07872.rjw@sisk.pl>
References: <1226722577.3104.4.camel@LiNuX> <1226817681.3133.7.camel@LiNuX> <491FECAE.6050005@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:42110 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751873AbYKPMjG (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 16 Nov 2008 07:39:06 -0500
In-Reply-To: <491FECAE.6050005@gmail.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <aystarik@gmail.com>, "Justin P. Mattock" <justinmattock@gmail.com>
Cc: Alan Jenkins <alan-jenkins@tuffmail.co.uk>, Andrew Morton <akpm@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>

On Sunday, 16 of November 2008, Alexey Starikovskiy wrote:
> Justin P. Mattock wrote:
> > Well; reverting:
> > http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=06cf7d3c7af902939cd1754abcafb2464060cba8
> > is keeping the system from having a gpe storm
> > (for at least four hours now);
> > haven't had a chance to drain the battery and see
> > the affects from that scenario.
> >
> >   
> Justin, by decreasing threshold, we just change how often _detection_ of 
> the storm fires, not the storm itself.

Yes, I think what happens is that we just detect the interrupt storm with the
lower threshold, so the storm occured anyway previously, but it went unnoticed
(not necessarily a good thing).

There is nothing to worry about as long as the box works as expected.

Thanks,
Rafael
