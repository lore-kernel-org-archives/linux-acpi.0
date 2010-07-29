From: Greg KH <greg@kroah.com>
Subject: Re: [stable] Stable inclusion request - ACPI GPE regression fixes
Date: Thu, 29 Jul 2010 15:07:57 -0700
Message-ID: <20100729220757.GJ17470@kroah.com>
References: <201006291248.42552.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from kroah.org ([198.145.64.141]:39113 "EHLO coco.kroah.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757422Ab0G2WdC (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 29 Jul 2010 18:33:02 -0400
Content-Disposition: inline
In-Reply-To: <201006291248.42552.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, stable@kernel.org, Matthew Garrett <mjg59@srcf.ucam.org>, Len Brown <lenb@kernel.org>

On Tue, Jun 29, 2010 at 12:48:42PM +0200, Rafael J. Wysocki wrote:
> Hi Greg,
> 
> Please include the following commits
> 
> http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=e4e9a735991c80fb0fc1bd4a13a93681c3c17ce0
> http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=fd247447c1d94a79d5cfc647430784306b3a8323
> http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=c9a8bbb7704cbf515c0fc68970abbe4e91d68521
> http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=ce43ace02320a3fb9614ddb27edc3a8700d68b26
> http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=9d3c752de65dbfa6e522f1d666deb0ac152ef367
> 
> (in this order) into the next 2.6.34.y release.  They are not necessary for
> older -stable kernels.
> 
> The first one should apply to 2.6.34.  The second one
> (fd247447c1d94a79d5cfc647430784306b3a8323) unfortunately doesn't, so attached
> is a backport of it to the 2.6.34 code base.  The remaining 3 patches should
> apply on top of it.

Now all queued up.

thanks,

greg k-h
