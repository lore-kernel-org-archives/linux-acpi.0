From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH -v2 -for driver-core-next] ACPI: remove duplicated lines
 of merging problems with acpi_processor_start
Date: Tue, 7 Feb 2012 19:29:14 -0800
Message-ID: <20120208032914.GA12385@kroah.com>
References: <1328643957-15677-1-git-send-email-yinghai@kernel.org>
 <201202080239.31338.trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:43403 "EHLO
	out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754808Ab2BHDcG (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 7 Feb 2012 22:32:06 -0500
Received: from compute2.internal (compute2.nyi.mail.srv.osa [10.202.2.42])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id C4AB220713
	for <linux-acpi@vger.kernel.org>; Tue,  7 Feb 2012 22:32:05 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <201202080239.31338.trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: Yinghai Lu <yinghai@kernel.org>, sfr@canb.auug.org.au, linux-acpi@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Len Brown <lenb@kernel.org>

On Wed, Feb 08, 2012 at 02:39:30AM +0100, Thomas Renninger wrote:
> Hi,
> 
> this looks like the missing bits, Thanks!
> I had a look at Stephan's mergers, but did not realize that (I expect
> there) it slip in.
> Greg, can you queue this one in your driver-core-next branch, please.

Ok, will do.

greg k-h
