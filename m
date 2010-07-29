From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [stable] Stable inclusion request - NVS changes from Matthew
Date: Fri, 30 Jul 2010 00:34:55 +0200
Message-ID: <201007300034.55730.rjw@sisk.pl>
References: <201006291128.44099.rjw@sisk.pl> <20100729220431.GI17470@kroah.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:44936 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756394Ab0G2Wf7 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 29 Jul 2010 18:35:59 -0400
In-Reply-To: <20100729220431.GI17470@kroah.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, linux-pm@lists.linux-foundation.org, Len Brown <lenb@kernel.org>, stable@kernel.org, Matthew Garrett <mjg59@srcf.ucam.org>

On Friday, July 30, 2010, Greg KH wrote:
> On Tue, Jun 29, 2010 at 11:28:43AM +0200, Rafael J. Wysocki wrote:
> > Hi Greg,
> > 
> > Please include
> > 
> > http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=dd4c4f17d722ffeb2515bf781400675a30fcead7
> > http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=2a6b69765ad794389f2fc3e14a0afa1a995221c2
> > 
> > (in this order) into the next 2.6.34.y release (and possibly older maintained
> > -stable kernels where they apply).
> > 
> > The first one requires a little fixup in kernel/power/Makefile , but apart from
> > this they apply to 2.6.34 just fine.
> 
> Now queued up.

Well, please drop these two.  They introduced regressions for people and
IMO -stable will be better off without them.

Rafael
