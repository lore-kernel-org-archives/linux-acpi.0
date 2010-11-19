From: Randy Dunlap <randy.dunlap@oracle.com>
Subject: Re: [PATCH] ACPI: Fix <acpi/video.h> when CONFIG_ACPI_VIDEO=n
Date: Fri, 19 Nov 2010 08:36:24 -0800
Message-ID: <20101119083624.83817dcb.randy.dunlap@oracle.com>
References: <20101119170200.2db4ab81@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from rcsinet10.oracle.com ([148.87.113.121]:38047 "EHLO
	rcsinet10.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753190Ab0KSQhO (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 19 Nov 2010 11:37:14 -0500
In-Reply-To: <20101119170200.2db4ab81@endymion.delvare>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jean Delvare <khali@linux-fr.org>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org

On Fri, 19 Nov 2010 17:02:00 +0100 Jean Delvare wrote:

> Building the kernel (2.6.37-rc2-git5) with CONFIG_ACPI_VIDEO=n fails
> for me because of these errors:
> 
> include/acpi/video.h:22:11: warning: "struct acpi_device" declared inside parameter list
> include/acpi/video.h:22:11: warning: its scope is only this definition or declaration, which is probably not what you want
> include/acpi/video.h: In function "acpi_video_get_edid":
> include/acpi/video.h:24:10: error: "ENODEV" undeclared (first use in this function)
> include/acpi/video.h:24:10: note: each undeclared identifier is reported only once for each function it appears in
> 
> Adding the missing include and structure declaration fixes it.
> 
> Signed-off-by: Jean Delvare <khali@linux-fr.org>

Acked-by: Randy Dunlap <randy.dunlap@oracle.com>

This is the third patch like this.  Please apply one of them.


> ---
>  include/acpi/video.h |    4 ++++
>  1 file changed, 4 insertions(+)
> 
> --- linux-2.6.37-rc2.orig/include/acpi/video.h	2010-11-19 14:56:45.000000000 +0100
> +++ linux-2.6.37-rc2/include/acpi/video.h	2010-11-19 15:00:23.000000000 +0100
> @@ -1,6 +1,8 @@
>  #ifndef __ACPI_VIDEO_H
>  #define __ACPI_VIDEO_H
>  
> +#include <linux/errno.h>
> +
>  #define ACPI_VIDEO_DISPLAY_CRT  1
>  #define ACPI_VIDEO_DISPLAY_TV   2
>  #define ACPI_VIDEO_DISPLAY_DVI  3
> @@ -10,6 +12,8 @@
>  #define ACPI_VIDEO_DISPLAY_LEGACY_PANEL   0x0110
>  #define ACPI_VIDEO_DISPLAY_LEGACY_TV      0x0200
>  
> +struct acpi_device;
> +
>  #if (defined CONFIG_ACPI_VIDEO || defined CONFIG_ACPI_VIDEO_MODULE)
>  extern int acpi_video_register(void);
>  extern void acpi_video_unregister(void);
> 
> 
> -- 


---
~Randy
*** Remember to use Documentation/SubmitChecklist when testing your code ***
