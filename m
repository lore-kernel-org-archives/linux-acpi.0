From: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Subject: Re: [Resend][PATCH 1/3] Platform / x86: Make fujitsu_laptop use acpi_bus_update_power()
Date: Sat, 1 Jan 2011 13:04:03 +1030 (CST)
Message-ID: <201101010234.p012Y3F0019523@mercury.physics.adelaide.edu.au>
References: <201012112343.26591.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from adelphi.physics.adelaide.edu.au ([129.127.102.1]:36649 "EHLO
	adelphi.physics.adelaide.edu.au" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751768Ab1AACxq (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Fri, 31 Dec 2010 21:53:46 -0500
In-Reply-To: <201012112343.26591.rjw@sisk.pl> from "Rafael J. Wysocki" at Dec 11, 2010 11:43:26 PM
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Len Brown <lenb@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Matthew Garrett <mjg59@srcf.ucam.org>

Hi guys

For a whole variety of reasons which are too complicated to go into now
(including but not limited to me not being on the direct "to" list), I
missed this when it was posted in early-to-mid December.

> From: Rafael J. Wysocki <rjw@sisk.pl>
> 
> Use the new function acpi_bus_update_power(), which is safer than
> acpi_bus_get_power(), for getting device power state in
> acpi_fujitsu_add() and acpi_fujitsu_hotkey_add().
> 
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> Reported-and-Tested-by: Sedat Dilek <sedat.dilek@gmail.com>
> ---
>  drivers/platform/x86/fujitsu-laptop.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> Index: linux-2.6/drivers/platform/x86/fujitsu-laptop.c
> ===================================================================
> --- linux-2.6.orig/drivers/platform/x86/fujitsu-laptop.c
> +++ linux-2.6/drivers/platform/x86/fujitsu-laptop.c
> @@ -689,7 +689,7 @@ static int acpi_fujitsu_add(struct acpi_
>  	if (error)
>  		goto err_free_input_dev;
>  
> -	result = acpi_bus_get_power(fujitsu->acpi_handle, &state);
> +	result = acpi_bus_update_power(fujitsu->acpi_handle, &state);
>  	if (result) {
>  		printk(KERN_ERR "Error reading power state\n");
>  		goto err_unregister_input_dev;
> @@ -857,7 +857,7 @@ static int acpi_fujitsu_hotkey_add(struc
>  	if (error)
>  		goto err_free_input_dev;
>  
> -	result = acpi_bus_get_power(fujitsu_hotkey->acpi_handle, &state);
> +	result = acpi_bus_update_power(fujitsu_hotkey->acpi_handle, &state);
>  	if (result) {
>  		printk(KERN_ERR "Error reading power state\n");
>  		goto err_unregister_input_dev;
> 

For what it's worth and in case it's important, here's a belated ack:

Acked-by: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>

Regards
  jonathan
