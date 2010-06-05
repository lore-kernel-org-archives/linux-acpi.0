From: Maxim Levitsky <maximlevitsky@gmail.com>
Subject: Re: [PATCH 1/2] suspend: Move NVS save/restore code to generic
 suspend functionality
Date: Sat, 05 Jun 2010 18:28:38 +0300
Message-ID: <1275751718.10792.0.camel@maxim-laptop>
References: <1275078735-1866-1-git-send-email-mjg@redhat.com>
	 <1275230238.14907.8.camel@maxim-laptop>
	 <alpine.LFD.2.00.1006041508190.4073@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.152]:11265 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757398Ab0FEP2o (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 5 Jun 2010 11:28:44 -0400
In-Reply-To: <alpine.LFD.2.00.1006041508190.4073@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Matthew Garrett <mjg@redhat.com>, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, Alan Stern <stern@rowland.harvard.edu>

On Fri, 2010-06-04 at 15:11 -0400, Len Brown wrote: 
> > Since the other patch 'ACPI / EC / PM: Fix race between EC transactions
> > and system suspend' is now merged, this should be rebased on top of it
> > (I did the opposite....)
> 
> Maxim,
> Since your system needs both these fixes, and they are merged together
> in the acpi git tree, it would be great if you could test that tree
> and let me know if we got it right.
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux-acpi-2.6.git test
> 
> thanks,
> Len Brown, Intel Open Source Technology Center
> 

Which kernel do you expect these patches to land on?

Best regards,
Maxim Levitsky

