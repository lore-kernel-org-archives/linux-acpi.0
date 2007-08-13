From: Alexey Starikovskiy <aystarik@gmail.com>
Subject: Re: [PATCH] [23/2many] MAINTAINERS - ACPI BATTERY DRIVERS
Date: Mon, 13 Aug 2007 10:43:02 +0400
Message-ID: <46BFFD76.9020909@gmail.com>
References: <46bff88f.DlQUzlREkbeqr4cb%joe@perches.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.173]:31791 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S967757AbXHMGnI (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 13 Aug 2007 02:43:08 -0400
Received: by ug-out-1314.google.com with SMTP id j3so553356ugf
        for <linux-acpi@vger.kernel.org>; Sun, 12 Aug 2007 23:43:05 -0700 (PDT)
In-Reply-To: <46bff88f.DlQUzlREkbeqr4cb%joe@perches.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: joe@perches.com
Cc: torvalds@linux-foundation.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, astarikovskiy@suse.de, akpm@linux-foundation.org

joe@perches.com wrote:
> Add file pattern to MAINTAINER entry
> 
> Signed-off-by: Joe Perches <joe@perches.com>
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 93a100b..6bb5785 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -261,6 +261,7 @@ M:	astarikovskiy@suse.de
>  L:	linux-acpi@vger.kernel.org
>  W:	http://acpi.sourceforge.net/
>  S:	Supported
> +F:	drivers/acpi/battery.c
>  
>  ACPI EC DRIVER
>  P:	Alexey Starikovskiy
> -
Please add *sbs* to the line.

Thanks,
Alex.
