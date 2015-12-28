From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v2 1/3] device property: add spaces to PROPERTY_ENTRY_STRING macro
Date: Mon, 28 Dec 2015 02:12:21 +0100
Message-ID: <4285778.gtB2L18Hsx@vostro.rjw.lan>
References: <1450877684-76316-1-git-send-email-andriy.shevchenko@linux.intel.com> <1450877684-76316-2-git-send-email-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:44228 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751117AbbL1Aly (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 27 Dec 2015 19:41:54 -0500
In-Reply-To: <1450877684-76316-2-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linux-next@vger.kernel.org, akpm@linux-foundation.org, linux-kernel@vger.kernel.org, heikki.krogerus@linux.intel.com, linux-acpi@vger.kernel.org

On Wednesday, December 23, 2015 03:34:42 PM Andy Shevchenko wrote:
> Just a style fix, no functional changes.
> 
> To be folded to Andrew's patch.

What patch?

> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  include/linux/property.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/property.h b/include/linux/property.h
> index b8c4e42..b51fcd3 100644
> --- a/include/linux/property.h
> +++ b/include/linux/property.h
> @@ -230,7 +230,7 @@ struct property_entry {
>  	.name = _name_,					\
>  	.length = sizeof(_val_),			\
>  	.is_string = true,				\
> -	{ .value = {.str = _val_} },			\
> +	{ .value = { .str = _val_ } },			\
>  }
>  
>  #define PROPERTY_ENTRY_BOOL(_name_)		\
> 

Thanks,
Rafael

