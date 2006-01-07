From: "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: [patch 8/9] acpi: remove Kconfig ACPI laptop default settings
Date: Sat, 7 Jan 2006 05:21:28 -0500
Message-ID: <F7DC2337C7631D4386A2DF6E8FB22B3005A1336B@hdsmsx401.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-class: urn:content-classes:message
Sender: linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: akpm-3NddpPZAyC0@public.gmane.org
Cc: linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, bbpetkov-LWAfsSFWpa4@public.gmane.org, petkov-xhPu7QH+N+StU9/U+hoEgQ@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

applied.

thanks,
-len  

>-----Original Message-----
>From: akpm-3NddpPZAyC0@public.gmane.org [mailto:akpm-3NddpPZAyC0@public.gmane.org] 
>Sent: Friday, January 06, 2006 1:31 AM
>To: Brown, Len
>Cc: linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; akpm-3NddpPZAyC0@public.gmane.org; 
>bbpetkov-LWAfsSFWpa4@public.gmane.org; petkov-xhPu7QH+N+StU9/U+hoEgQ@public.gmane.org
>Subject: [patch 8/9] acpi: remove Kconfig ACPI laptop default settings
>
>
>From: Borislav Petkov <bbpetkov-LWAfsSFWpa4@public.gmane.org>
>
>Remove the default (y|m) ACPI settings for laptops in order to speed up
>automated kbuilds without compiling unneeded stuff - I'm 
>pretty certain the
>majority of machines running lnx are not laptops after all :)
>
>Signed-off-by: Borislav Petkov <petkov-xhPu7QH+N+StU9/U+hoEgQ@public.gmane.org>
>Signed-off-by: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>
>---
>
> drivers/acpi/Kconfig |    2 --
> 1 files changed, 2 deletions(-)
>
>diff -puN 
>drivers/acpi/Kconfig~acpi-remove-kconfig-acpi-laptop-default-se
>ttings drivers/acpi/Kconfig
>--- 
>devel/drivers/acpi/Kconfig~acpi-remove-kconfig-acpi-laptop-defa
>ult-settings	2006-01-05 22:28:52.000000000 -0800
>+++ devel-akpm/drivers/acpi/Kconfig	2006-01-05 
>22:28:52.000000000 -0800
>@@ -168,7 +168,6 @@ config ACPI_NUMA
> config ACPI_ASUS
>         tristate "ASUS/Medion Laptop Extras"
> 	depends on X86
>-	default y
>         ---help---
>           This driver provides support for extra features of 
>ACPI-compatible
>           ASUS laptops. As some of Medion laptops are made by 
>ASUS, it may also
>@@ -209,7 +208,6 @@ config ACPI_IBM
> config ACPI_TOSHIBA
> 	tristate "Toshiba Laptop Extras"
> 	depends on X86
>-	default y
> 	---help---
> 	  This driver adds support for access to certain system settings
> 	  on "legacy free" Toshiba laptops.  These laptops can 
>be recognized by
>_
>
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
