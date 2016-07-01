From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 4/6] ACPI / device_sysfs: make use of new strtolower() function
Date: Fri, 01 Jul 2016 22:44:33 +0200
Message-ID: <9679780.CKS7jhtgO8@vostro.rjw.lan>
References: <1467330612-26242-1-git-send-email-mmayer@broadcom.com> <1467330612-26242-5-git-send-email-mmayer@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:50345 "HELO
	cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751911AbcGAUkG (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 1 Jul 2016 16:40:06 -0400
In-Reply-To: <1467330612-26242-5-git-send-email-mmayer@broadcom.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Markus Mayer <mmayer@broadcom.com>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On Thursday, June 30, 2016 04:50:10 PM Markus Mayer wrote:
> Call strtolower() rather than walking the string explicitly to convert
> it to lowercase.
> 
> Signed-off-by: Markus Mayer <mmayer@broadcom.com>

ACK

> ---
>  drivers/acpi/device_sysfs.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/acpi/device_sysfs.c b/drivers/acpi/device_sysfs.c
> index 7b2c48f..1db38c7 100644
> --- a/drivers/acpi/device_sysfs.c
> +++ b/drivers/acpi/device_sysfs.c
> @@ -200,12 +200,10 @@ static int create_of_modalias(struct acpi_device *acpi_dev, char *modalias,
>  	const union acpi_object *of_compatible, *obj;
>  	int len, count;
>  	int i, nval;
> -	char *c;
>  
>  	acpi_get_name(acpi_dev->handle, ACPI_SINGLE_NAME, &buf);
>  	/* DT strings are all in lower case */
> -	for (c = buf.pointer; *c != '\0'; c++)
> -		*c = tolower(*c);
> +	strtolower(buf.pointer);
>  
>  	len = snprintf(modalias, size, "of:N%sT", (char *)buf.pointer);
>  	ACPI_FREE(buf.pointer);
> 

