From: Randy Dunlap <randy.dunlap@oracle.com>
Subject: Re: [PATCH 19/22] Swap W3V and W5A
Date: Tue, 19 Dec 2006 13:46:04 -0800
Message-ID: <20061219134604.5331de02.randy.dunlap@oracle.com>
References: <200612192220.35487.corentincj@iksaif.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from rgminet02.oracle.com ([148.87.113.119]:54783 "EHLO
	rgminet02.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932962AbWLSVyy (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 19 Dec 2006 16:54:54 -0500
Received: from rgminet01.oracle.com (rgminet01.oracle.com [148.87.113.118])
	by rgminet02.oracle.com (Switch-3.2.4/Switch-3.1.7) with ESMTP id kBJLsrPZ020244
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-acpi@vger.kernel.org>; Tue, 19 Dec 2006 14:54:53 -0700
In-Reply-To: <200612192220.35487.corentincj@iksaif.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: corentincj@iksaif.net
Cc: len.brown@intel.com, linux-acpi@vger.kernel.org

On Tue, 19 Dec 2006 22:20:35 +0100 Corentin CHARY wrote:

> 
> Signed-off-by: Corentin Chary <corentincj@iksaif.net>
> ---

Please tell us _why_ you are making a change, not just what
the change is.


>  asus_acpi.c |   16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> 
> --- a/drivers/acpi/asus_acpi.c  2006-12-15 16:19:24.000000000 +0100
> +++ b/drivers/acpi/asus_acpi.c  2006-12-15 16:19:08.000000000 +0100
> @@ -177,8 +177,8 @@
>                 V6J,            //V6J
>                 V6V,            //V6V
>                 W1N,            //W1000N
> -               W5A,            //W5A
>                 W3V,            //W3030V
> +               W5A,            //W5A
>                 xxN,            //M2400N, M3700N, M5200N, M6800N, S1300N, 
> S5200N
>                 //(Centrino)
>                 DEF,            //Default values
> @@ -636,25 +636,25 @@
>          .display_get = "\\ADVG"},
> 
>         {
> -        .name = "W5A",
> -        .bt_switch = "BLED",
> +        .name = "W3V",
> +        .mled_set = "MLED",
>          .wled_set = "WLED",
>          .lcd_switch = xxN_PREFIX "_Q10",
> +        .lcd_status = "\\BKLT",
>          .brightness_set = "SPLV",
>          .brightness_get = "GPLV",
>          .display_set = "SDSP",
> -        .display_get = "\\ADVG"},
> +        .display_get = "\\INFB"},
> 
>         {
> -        .name = "W3V",
> -        .mled_set = "MLED",
> +        .name = "W5A",
> +        .bt_switch = "BLED",
>          .wled_set = "WLED",
>          .lcd_switch = xxN_PREFIX "_Q10",
> -        .lcd_status = "\\BKLT",
>          .brightness_set = "SPLV",
>          .brightness_get = "GPLV",
>          .display_set = "SDSP",
> -        .display_get = "\\INFB"},
> +        .display_get = "\\ADVG"},
> 
>         {
>          .name = "xxN",
> 
> -- 

---
~Randy
