From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: [RFC] acpi: remove redundant NULL checks in acpi drivers
Date: Thu, 10 Sep 2009 16:36:55 -0600
Message-ID: <200909101636.56398.bjorn.helgaas@hp.com>
References: <4AA92CAD.8020208@tuffmail.co.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g5t0006.atlanta.hp.com ([15.192.0.43]:22362 "EHLO
	g5t0006.atlanta.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751304AbZIJWhP (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 10 Sep 2009 18:37:15 -0400
In-Reply-To: <4AA92CAD.8020208@tuffmail.co.uk>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
Cc: Len Brown <lenb@kernel.org>, linux acpi <linux-acpi@vger.kernel.org>

On Thursday 10 September 2009 10:43:25 am Alan Jenkins wrote:
> I noticed a pattern of unnecessary checks, and wrote some semantic
> patches to remove them (using the spatch tool).  Here are the
> results, modulo some manual adjustment of blank lines to try and
> preserve the coding style in different files.
> 
> Would you be interested in accepting this?  Can I submit it like
> this, or should I break it up somehow?

I'm generally in favor of removing these checks.  In most cases,
you can go even farther, for example:

> diff --git a/drivers/acpi/ac.c b/drivers/acpi/ac.c
> index 98b9690..57fbf70 100644
> --- a/drivers/acpi/ac.c
> +++ b/drivers/acpi/ac.c
> @@ -259,9 +259,6 @@ static int acpi_ac_add(struct acpi_device *device)
>  	struct acpi_ac *ac = NULL;

The initialization of "ac" is useless since the first thing we
do below is assign to it.

> -	if (!device)
> -		return -EINVAL;
> -
>  	ac = kzalloc(sizeof(struct acpi_ac), GFP_KERNEL);
>  	if (!ac)
>  		return -ENOMEM;
> @@ -306,11 +303,10 @@ static int acpi_ac_add(struct acpi_device *device)
>  
>  static int acpi_ac_resume(struct acpi_device *device)
>  {
> -	struct acpi_ac *ac;
> +	struct acpi_ac *ac = acpi_driver_data(device);
>  	unsigned old_state;
> -	if (!device || !acpi_driver_data(device))
> +	if (!ac)
>  		return -EINVAL;

I would also remove the test of "!ac".  acpi_ac_resume() can only
be called after acpi_ac_add() completes successfully, and acpi_ac_add()
always sets "device->driver_data = ac".

So testing "!ac" here will only find memory corruption or a bug in
the Linux/ACPI core.  In either case, I think it's better to oops
than to return -EINVAL, which will probably get ignored.

Bjorn

