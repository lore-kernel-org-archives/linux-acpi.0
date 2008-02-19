From: Mattia Dongili <malattia@linux.it>
Subject: Re: [2.6 patch] sony-laptop.c: fix off-by-one
Date: Wed, 20 Feb 2008 08:27:56 +0900
Message-ID: <20080219232756.GA19495@inferi.kami.home>
References: <20080219225903.GS31955@cs181133002.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mtoichi12.ns.itscom.net ([219.110.2.182]:59041 "EHLO
	mtoichi12.ns.itscom.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754348AbYBSX2O (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 19 Feb 2008 18:28:14 -0500
Content-Disposition: inline
In-Reply-To: <20080219225903.GS31955@cs181133002.pp.htv.fi>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Adrian Bunk <bunk@kernel.org>
Cc: Len Brown <len.brown@intel.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, Feb 20, 2008 at 12:59:03AM +0200, Adrian Bunk wrote:
> This patch fixes an off-by-one spotted by the Coverity checker.
> 
> Signed-off-by: Adrian Bunk <bunk@kernel.org>

Acked-by: Mattia Dongili <malattia@linux.it>

> ---
> --- linux-2.6/drivers/misc/sony-laptop.c.old	2008-02-20 00:26:21.000000000 +0200
> +++ linux-2.6/drivers/misc/sony-laptop.c	2008-02-20 00:26:38.000000000 +0200
> @@ -314,9 +314,9 @@ static void sony_laptop_report_input_eve
>  		kp.dev = jog_dev;
>  		break;
>  
>  	default:
> -		if (event > ARRAY_SIZE(sony_laptop_input_index)) {
> +		if (event >= ARRAY_SIZE(sony_laptop_input_index)) {
>  			dprintk("sony_laptop_report_input_event, event not known: %d\n", event);
>  			break;
>  		}
>  		if (sony_laptop_input_index[event] != -1) {
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
-- 
mattia
:wq!
