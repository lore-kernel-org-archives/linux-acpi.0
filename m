From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 1/3] ACPI / processor: remove incorrect comparison of phys_id
Date: Wed, 26 Nov 2014 00:11:59 +0100
Message-ID: <27257905.ShLUYyq0Be@vostro.rjw.lan>
References: <1416926930-792-1-git-send-email-sudeep.holla@arm.com> <1416926930-792-2-git-send-email-sudeep.holla@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:50079 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751061AbaKYWup (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 25 Nov 2014 17:50:45 -0500
In-Reply-To: <1416926930-792-2-git-send-email-sudeep.holla@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: linux-acpi@vger.kernel.org

On Tuesday, November 25, 2014 02:48:48 PM Sudeep Holla wrote:
> phys_id in acpi_processor structure is unsigned 32-bit integer,
> comparing it with signed value is incorrect.
> 
> This patch removes that incorrect comparision in acpi_processor_hotadd_init
> as the lone user of this function is already checking for correctness
> of phys_id before calling it.
> 
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>

This one depens on commits I've dropped due to conflicts with the tip tree.

They'll need to be rebased on top of current linux-next and resent.

I can take patches [2-3/3], though.

> ---
>  drivers/acpi/acpi_processor.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/acpi_processor.c
> index c4a8a5666298..eaf56f6ce1eb 100644
> --- a/drivers/acpi/acpi_processor.c
> +++ b/drivers/acpi/acpi_processor.c
> @@ -170,9 +170,6 @@ static int acpi_processor_hotadd_init(struct acpi_processor *pr)
>  	acpi_status status;
>  	int ret;
>  
> -	if (pr->phys_id == -1)
> -		return -ENODEV;
> -
>  	status = acpi_evaluate_integer(pr->handle, "_STA", NULL, &sta);
>  	if (ACPI_FAILURE(status) || !(sta & ACPI_STA_DEVICE_PRESENT))
>  		return -ENODEV;
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
