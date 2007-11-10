From: Mattia Dongili <malattia@linux.it>
Subject: Re: [PATCH] drivers/misc/sony-laptop.c: remove duplicated define
Date: Sat, 10 Nov 2007 11:46:33 +0900
Message-ID: <20071110024632.GA22417@inferi.kami.home>
References: <20071109140832.4f2a145c@lucky.kitzblitz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mfbichi11.ns.itscom.net ([219.110.2.189]:33832 "EHLO
	mfbichi11.ns.itscom.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750839AbXKJIaW (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 10 Nov 2007 03:30:22 -0500
Content-Disposition: inline
In-Reply-To: <20071109140832.4f2a145c@lucky.kitzblitz>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Nicolas Kaiser <nikai@nikai.net>
Cc: linux-acpi@vger.kernel.org, kernel-janitors@vger.kernel.org

On Fri, Nov 09, 2007 at 02:08:32PM +0100, Nicolas Kaiser wrote:
> Remove duplicated define.
> 
> Signed-off-by: Nicolas Kaiser <nikai@nikai.net>

Acked-by: Mattia Dongili <malattia@linux.it>

> ---
> 
>  drivers/misc/sony-laptop.c |    1 -
>  1 file changed, 1 deletion(-)
> 
> --- a/drivers/misc/sony-laptop.c	2007-11-07 11:26:12.000000000 +0100
> +++ b/drivers/misc/sony-laptop.c	2007-11-09 13:56:36.000000000 +0100
> @@ -1504,7 +1504,6 @@
>  #define SONYPI_CAMERA_SHUTTER_MASK 		0x7
>  
>  #define SONYPI_CAMERA_SHUTDOWN_REQUEST		7
> -#define SONYPI_CAMERA_CONTROL			0x10
>  
>  #define SONYPI_CAMERA_STATUS 			7
>  #define SONYPI_CAMERA_STATUS_READY 		0x2
> 
-- 
mattia
:wq!
