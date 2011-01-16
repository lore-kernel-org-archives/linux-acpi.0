From: Jesper Juhl <jj@chaosbits.net>
Subject: Re: [PATCH] ACPI: Fix memory leak in
 acpi_ev_asynch_execute_gpe_method().
Date: Sun, 16 Jan 2011 20:51:27 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1101162050532.13377@swampdragon.chaosbits.net>
References: <alpine.LNX.2.00.1101162033531.13377@swampdragon.chaosbits.net> <201101162048.29781.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from swampdragon.chaosbits.net ([90.184.90.115]:16052 "EHLO
	swampdragon.chaosbits.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753245Ab1APTv3 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 16 Jan 2011 14:51:29 -0500
In-Reply-To: <201101162048.29781.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Lin Ming <ming.m.lin@intel.com>

On Sun, 16 Jan 2011, Rafael J. Wysocki wrote:

> On Sunday, January 16, 2011, Jesper Juhl wrote:
> > We will leak the memory allocated to 'local_gpe_event_info' if 
> > 'acpi_ut_acquire_mutex()' fails or if 'acpi_ev_valid_gpe_event()' fails in 
> > drivers/acpi/acpica/evgpe.c::acpi_ev_asynch_execute_gpe_method().
> > 
> > Signed-off-by: Jesper Juhl <jj@chaosbits.net>
> 
> Good catch!  How did you find it?
> 

This one was found with the help of Coverity prevent.


> Reviewed-by: Rafael Wysocki <rjw@sisk.pl>
> 
> Len, please apply and push to Linus ASAP.
> 
> Thanks,
> Rafael
> 

-- 
Jesper Juhl <jj@chaosbits.net>            http://www.chaosbits.net/
Don't top-post http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please.

