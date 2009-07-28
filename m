From: Paulo Marques <pmarques@grupopie.com>
Subject: Re: [PATCH 6/12] drivers/platform/x86: Correct redundant test
Date: Tue, 28 Jul 2009 18:52:42 +0100
Message-ID: <4A6F3AEA.7090102@grupopie.com>
References: <Pine.LNX.4.64.0907271813490.2682@ask.diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from bipbip.grupopie.com ([195.23.16.24]:37214 "EHLO
	bipbip.grupopie.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755358AbZG1SYf (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 28 Jul 2009 14:24:35 -0400
In-Reply-To: <Pine.LNX.4.64.0907271813490.2682@ask.diku.dk>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Julia Lawall <julia@diku.dk>
Cc: jwoithe@physics.adelaide.edu.au, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org

Julia Lawall wrote:
> [...]
> ---
>  drivers/platform/x86/fujitsu-laptop.c          |    3 ---
>  1 files changed, 0 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/platform/x86/fujitsu-laptop.c b/drivers/platform/x86/fujitsu-laptop.c
> index 218b9a1..5306901 100644
> --- a/drivers/platform/x86/fujitsu-laptop.c
> +++ b/drivers/platform/x86/fujitsu-laptop.c
> @@ -745,9 +745,6 @@ static int acpi_fujitsu_remove(struct acpi_device *device, int type)
>  
>  	fujitsu = acpi_driver_data(device);
>  
> -	if (!device || !acpi_driver_data(device))
> -		return -EINVAL;
> -

Shouldn't this still do a:

   if (!fujitsu)
     return -EINVAL;

to avoid dereferencing a NULL pointer below?

>  	fujitsu->acpi_handle = NULL;
>  
>  	return 0;

-- 
Paulo Marques - www.grupopie.com

"All I ask is a chance to prove that money can't make me happy."
