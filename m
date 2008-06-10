From: Len Brown <lenb@kernel.org>
Subject: Re: [patch 05/11] acpi video: blacklist Fujitsu Lifebook S6410
Date: Tue, 10 Jun 2008 12:51:56 -0400 (EDT)
Message-ID: <alpine.LFD.1.10.0806101250430.14381@localhost.localdomain>
References: <200806092322.m59NML9K013967@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173003pub.verizon.net ([206.46.173.3]:50791 "EHLO
	vms173003pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754567AbYFJQ5c (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 10 Jun 2008 12:57:32 -0400
Received: from localhost.localdomain ([72.93.254.151])
 by vms173003.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0K2900DSVAV1YAPX@vms173003.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Tue, 10 Jun 2008 11:52:17 -0500 (CDT)
In-reply-to: <200806092322.m59NML9K013967@imap1.linux-foundation.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: akpm@linux-foundation.org
Cc: linux-acpi@vger.kernel.org, nokos@gmx.net, mjg59@srcf.ucam.org, robert.moore@intel.com, trenn@suse.de


NAK,
bad idea to apply this workaround when a proper fix is in the works.

thanks,
-Len

On Mon, 9 Jun 2008, akpm@linux-foundation.org wrote:

> From: Peter Gruber <nokos@gmx.net>
> 
> Taken from http://bugzilla.kernel.org/show_bug.cgi?id=10454
> 
> On Thu, 1 May 2008 12:59:46 +0100 Matthew Garrett <mjg59@srcf.ucam.org> wrote:
> 
> > On Thu, May 01, 2008 at 02:52:04AM -0700, akpm@linux-foundation.org wrote:
> > 
> > > Taken from http://bugzilla.kernel.org/show_bug.cgi?id=10454
> > 
> > Checking the bug, it seems like discussion is ongoing and a better 
> > solution is possible - this seems to be a case of us differing in 
> > behaviour from Vista, so we probably want to fix it up properly.
> > 
> > -- 
> > Matthew Garrett | mjg59@srcf.ucam.org
> 
> Cc: Len Brown <lenb@kernel.org>
> Cc: "Moore, Robert" <robert.moore@intel.com>
> Cc: Thomas Renninger <trenn@suse.de>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
> 
>  drivers/acpi/blacklist.c |    8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff -puN drivers/acpi/blacklist.c~acpi-video-balcklist-fujitsu-lifebook-s6410 drivers/acpi/blacklist.c
> --- a/drivers/acpi/blacklist.c~acpi-video-balcklist-fujitsu-lifebook-s6410
> +++ a/drivers/acpi/blacklist.c
> @@ -448,6 +448,14 @@ static struct dmi_system_id acpi_osi_dmi
>  	 	     DMI_MATCH(DMI_PRODUCT_NAME, "ESPRIMO Mobile V5505"),
>  		},
>  	},
> +	{
> +	.callback = dmi_disable_osi_vista,
> +	.ident = "Fujitsu Siemens",
> +	.matches = {
> +		DMI_MATCH(DMI_SYS_VENDOR, "FUJITSU SIEMENS"),
> +		DMI_MATCH(DMI_PRODUCT_NAME, "LIFEBOOK S6410"),
> +		},
> +	},
>  	/*
>  	 * Disable OSI(Linux) warnings on all "Hewlett-Packard"
>  	 *
> _
> 
