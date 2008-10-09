From: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Subject: Re: [PATCH] fujitsu-laptop: fix section mismatch warning
Date: Thu, 9 Oct 2008 10:33:11 +0930 (CST)
Message-ID: <200810090103.m9913Bnt030709@turbo.physics.adelaide.edu.au>
References: <48ED249B.7050908@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from adelphi.physics.adelaide.edu.au ([129.127.102.1]:56647 "EHLO
	adelphi.physics.adelaide.edu.au" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751690AbYJIBDw (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 8 Oct 2008 21:03:52 -0400
In-Reply-To: <48ED249B.7050908@oracle.com> from "Randy Dunlap" at Oct 08, 2008 02:22:35 PM
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Randy Dunlap <randy.dunlap@oracle.com>
Cc: linux-acpi@vger.kernel.org, lenb@kernel.org, akpm <akpm@linux-foundation.org>, Jonathan Woithe <jwoithe@physics.adelaide.edu.au>

> From: Randy Dunlap <randy.dunlap@oracle.com>
> 
> Could fix a bug in a hotplug add scenario.
> 
> WARNING: drivers/misc/fujitsu-laptop.o(.text+0xbde): Section mismatch in reference from the function acpi_fujitsu_add() to the variable .init.data:fujitsu_dmi_table
> The function acpi_fujitsu_add() references
> the variable __initdata fujitsu_dmi_table.
> This is often because acpi_fujitsu_add lacks a __initdata 
> annotation or the annotation of fujitsu_dmi_table is wrong.
> 
> Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
> cc: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
> ---
>  drivers/misc/fujitsu-laptop.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- lin2627-r9g1-sections.orig/drivers/misc/fujitsu-laptop.c
> +++ lin2627-r9g1-sections/drivers/misc/fujitsu-laptop.c
> @@ -455,7 +455,7 @@ static int dmi_check_cb_s6410(const stru
>  	return 0;
>  }
>  
> -static struct dmi_system_id __initdata fujitsu_dmi_table[] = {
> +static struct dmi_system_id fujitsu_dmi_table[] = {
>  	{
>  	 .ident = "Fujitsu Siemens",
>  	 .matches = {

Ack.

Regards
  jonathan
