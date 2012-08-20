From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 2/3] asus-laptop: HRWS/HWRS typo
Date: Mon, 20 Aug 2012 22:11:22 +0100
Message-ID: <20120820221122.56c11282@pyramind.ukuu.org.uk>
References: <1345496512-11780-1-git-send-email-corentin.chary@gmail.com>
	<1345496512-11780-3-git-send-email-corentin.chary@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:54290 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754967Ab2HTVG4 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 20 Aug 2012 17:06:56 -0400
In-Reply-To: <1345496512-11780-3-git-send-email-corentin.chary@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Corentin Chary <corentin.chary@gmail.com>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org, Matthew Garrett <mjg@redhat.com>, acpi4asus-user@lists.sourceforge.net, linux-kernel@vger.kernel.org

On Mon, 20 Aug 2012 23:01:51 +0200
Corentin Chary <corentin.chary@gmail.com> wrote:

> Signed-off-by: Corentin Chary <corentin.chary@gmail.com>
> ---
>  drivers/platform/x86/asus-laptop.c |    8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/platform/x86/asus-laptop.c b/drivers/platform/x86/asus-laptop.c
> index e38f91b..110c777 100644
> --- a/drivers/platform/x86/asus-laptop.c
> +++ b/drivers/platform/x86/asus-laptop.c
> @@ -863,9 +863,9 @@ static ssize_t show_infos(struct device *dev,
>  	 * The significance of others is yet to be found.
>  	 * If we don't find the method, we assume the device are present.
>  	 */
> -	rv = acpi_evaluate_integer(asus->handle, "HRWS", NULL, &temp);
> +	rv = acpi_evaluate_integer(asus->handle, "HWRS", NULL, &temp);
>  	if (!ACPI_FAILURE(rv))
> -		len += sprintf(page + len, "HRWS value         : %#x\n",
> +		len += sprintf(page + len, "HWRS value         : %#x\n",
>  			       (uint) temp);
>  	/*
>  	 * Another value for userspace: the ASYM method returns 0x02 for
> @@ -1751,9 +1751,9 @@ static int asus_laptop_get_info(struct asus_laptop *asus)
>  	 * The significance of others is yet to be found.
>  	 */
>  	status =
> -	    acpi_evaluate_integer(asus->handle, "HRWS", NULL, &hwrs_result);
> +	    acpi_evaluate_integer(asus->handle, "HWRS", NULL, &hwrs_result);
>  	if (!ACPI_FAILURE(status))
> -		pr_notice("  HRWS returned %x", (int)hwrs_result);
> +		pr_notice("  HWRS returned %x", (int)hwrs_result);
>  
>  	if (!acpi_check_handle(asus->handle, METHOD_WL_STATUS, NULL))
>  		asus->have_rsts = true;

Please also tag this commit

Resolves-bug: https://bugzilla.kernel.org/show_bug.cgi?id=24222

so we can track it back out of bugzilla.
