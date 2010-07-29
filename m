From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [stable] Stable inclusion request - ACPI GPE regression fixes
Date: Fri, 30 Jul 2010 00:35:19 +0200
Message-ID: <201007300035.19182.rjw@sisk.pl>
References: <201006291248.42552.rjw@sisk.pl> <20100729220757.GJ17470@kroah.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:44941 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757841Ab0G2WgW (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 29 Jul 2010 18:36:22 -0400
In-Reply-To: <20100729220757.GJ17470@kroah.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, stable@kernel.org, Matthew Garrett <mjg59@srcf.ucam.org>, Len Brown <lenb@kernel.org>

On Friday, July 30, 2010, Greg KH wrote:
> On Tue, Jun 29, 2010 at 12:48:42PM +0200, Rafael J. Wysocki wrote:
> > Hi Greg,
> > 
> > Please include the following commits
> > 
> > http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=e4e9a735991c80fb0fc1bd4a13a93681c3c17ce0
> > http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=fd247447c1d94a79d5cfc647430784306b3a8323
> > http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=c9a8bbb7704cbf515c0fc68970abbe4e91d68521
> > http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=ce43ace02320a3fb9614ddb27edc3a8700d68b26
> > http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=9d3c752de65dbfa6e522f1d666deb0ac152ef367
> > 
> > (in this order) into the next 2.6.34.y release.  They are not necessary for
> > older -stable kernels.
> > 
> > The first one should apply to 2.6.34.  The second one
> > (fd247447c1d94a79d5cfc647430784306b3a8323) unfortunately doesn't, so attached
> > is a backport of it to the 2.6.34 code base.  The remaining 3 patches should
> > apply on top of it.
> 
> Now all queued up.

Thanks!

Rafael
