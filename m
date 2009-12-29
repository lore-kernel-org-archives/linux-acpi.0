From: Paul Rolland <rol@as2917.net>
Subject: Re: [PATCH 1/2] dell-wmi - properly handle errors returned by
 wmi_install_notify_handler()
Date: Tue, 29 Dec 2009 09:57:06 +0100
Message-ID: <20091229095706.392debfb@tux.DEF.witbe.net>
References: <20091229083226.13097.22110.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.witbe.net ([81.88.96.48]:45252 "EHLO smtp.witbe.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752675AbZL2JIv (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 29 Dec 2009 04:08:51 -0500
In-Reply-To: <20091229083226.13097.22110.stgit@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Len Brown <lenb@kernel.org>, Matthew Garrett <mjg59@srcf.ucam.org>, linux-acpi@vger.kernel.org

Hello,

On Tue, 29 Dec 2009 00:34:14 -0800
Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:

> wmi_install_notify_handler() retruns ACPI error codes instead of standard
> Exxxx error codes and they should not be propagated unchanged to the upper
> layers.
> 
> Reported-by: Paul Rolland <rol@as2917.net>
> Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
Tested-by: Paul Rolland <rol@as2917.net>

This is causing :
[root@tux ~]# modprobe dell-wmi
FATAL: Error inserting dell_wmi (/lib/modules/2.6.33-rc2/kernel/drivers/platform/x86/dell-wmi.ko): Input/output error

and

Dec 29 09:54:54 tux kernel: ACPI: WMI: Mapper loaded
Dec 29 09:54:54 tux kernel: input: Dell WMI hotkeys as /devices/virtual/input/input13
Dec 29 09:54:54 tux kernel: dell-wmi: Unable to register notify handler - 6

which looks Ok as my machine doesn't seem to have the corresponding stuff.

Anyway, this still needs the changes I sent for wmi.c to avoid the Oops.

Paul

> ---
> 
>  drivers/platform/x86/dell-wmi.c |   11 ++++++-----
>  1 files changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/platform/x86/dell-wmi.c
> b/drivers/platform/x86/dell-wmi.c index ff67a78..79bb1f1 100644
> --- a/drivers/platform/x86/dell-wmi.c
> +++ b/drivers/platform/x86/dell-wmi.c
> @@ -265,6 +265,7 @@ static void __init find_hk_type(const struct
> dmi_header *dm, void *dummy) 
>  static int __init dell_wmi_init(void)
>  {
> +	acpi_status status;
>  	int err;
>  
>  	if (!wmi_has_guid(DELL_EVENT_GUID)) {
> @@ -279,12 +280,12 @@ static int __init dell_wmi_init(void)
>  	if (err)
>  		return err;
>  
> -	err = wmi_install_notify_handler(DELL_EVENT_GUID,
> -					 dell_wmi_notify, NULL);
> -	if (err) {
> +	status = wmi_install_notify_handler(DELL_EVENT_GUID,
> +					    dell_wmi_notify, NULL);
> +	if (!ACPI_SUCCESS(status)) {
>  		dell_wmi_input_destroy();
> -		pr_err("Unable to register notify handler - %d\n", err);
> -		return err;
> +		pr_err("Unable to register notify handler - %d\n",
> status);
> +		return -EIO;
>  	}
>  
>  	return 0;
> 


-- 
Paul Rolland                                E-Mail : rol(at)witbe.net
CTO - Witbe.net SA                          Tel. +33 (0)1 47 67 77 77
Les Collines de l'Arche                     Fax. +33 (0)1 47 67 77 99
F-92057 Paris La Defense                    RIPE : PR12-RIPE

Please no HTML, I'm not a browser - Pas d'HTML, je ne suis pas un
navigateur "Some people dream of success... while others wake up and work
hard at it" 

"I worry about my child and the Internet all the time, even though she's
too young to have logged on yet. Here's what I worry about. I worry that 10
or 15 years from now, she will come to me and say 'Daddy, where were you
when they took freedom of the press away from the Internet?'"
--Mike Godwin, Electronic Frontier Foundation 
