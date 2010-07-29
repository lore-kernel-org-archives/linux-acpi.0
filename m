From: Greg KH <greg@kroah.com>
Subject: Re: [stable] Stable inclusion request - NVS changes from Matthew
Date: Thu, 29 Jul 2010 15:04:31 -0700
Message-ID: <20100729220431.GI17470@kroah.com>
References: <201006291128.44099.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from kroah.org ([198.145.64.141]:39107 "EHLO coco.kroah.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757362Ab0G2WdB (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 29 Jul 2010 18:33:01 -0400
Content-Disposition: inline
In-Reply-To: <201006291128.44099.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, linux-pm@lists.linux-foundation.org, Len Brown <lenb@kernel.org>, stable@kernel.org, Matthew Garrett <mjg59@srcf.ucam.org>

On Tue, Jun 29, 2010 at 11:28:43AM +0200, Rafael J. Wysocki wrote:
> Hi Greg,
> 
> Please include
> 
> http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=dd4c4f17d722ffeb2515bf781400675a30fcead7
> http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=2a6b69765ad794389f2fc3e14a0afa1a995221c2
> 
> (in this order) into the next 2.6.34.y release (and possibly older maintained
> -stable kernels where they apply).
> 
> The first one requires a little fixup in kernel/power/Makefile , but apart from
> this they apply to 2.6.34 just fine.

Now queued up.

thanks,

greg k-h
