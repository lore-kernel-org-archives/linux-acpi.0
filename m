From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] sony-laptop: MAINTAINERS fix entry, add L: and W:
Date: Tue, 13 Mar 2007 03:02:28 -0400
Message-ID: <200703130302.28527.lenb@kernel.org>
References: <20070312204357.GJ3071@inferi.kami.home>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:54265 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753157AbXCMHDw (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 13 Mar 2007 03:03:52 -0400
In-Reply-To: <20070312204357.GJ3071@inferi.kami.home>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mattia Dongili <malattia@linux.it>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, stelian@popies.net

applied.

thanks,
-Len

On Monday 12 March 2007 16:43, Mattia Dongili wrote:
> Probably the wrong MAINTAINERS patch has been picked up (sorry for not
> checking earlier), the following fix that and adds WWW and list contacts
> for the Sony drivers.
> 
> Signed-off-by: Mattia Dongili <malattia@linux.it>
> ---
> 
> Sorry for the inconvenience Len.
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 17555bb..f3a79d4 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3066,11 +3066,10 @@ L:	netdev@vger.kernel.org
>  S:	Maintained
>  
>  SONY VAIO CONTROL DEVICE DRIVER
> -P:	Stelian Pop
> -M:	stelian@popies.net
>  P:	Mattia Dongili
>  M:	malattia@linux.it
> -W:	http://popies.net/sonypi/
> +L:	linux-acpi@vger.kernel.org
> +W:	http://www.linux.it/~malattia/wiki/index.php/Sony_drivers
>  S:	Maintained
>  
>  SOUND
> -
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
