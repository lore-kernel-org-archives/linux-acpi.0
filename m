From: Mattia Dongili <malattia@linux.it>
Subject: Re: [PATCH] [446/2many] MAINTAINERS - SONY VAIO CONTROL DEVICE
	DRIVER
Date: Tue, 14 Aug 2007 22:07:19 +0900
Message-ID: <20070814130718.GA1612@inferi.kami.home>
References: <46bffbdb.CiCc1bB4g9HMdx0f%joe@perches.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mtoichi12.ns.itscom.net ([219.110.2.182]:35257 "EHLO
	mtoichi12.ns.itscom.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756864AbXHNNIE (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 14 Aug 2007 09:08:04 -0400
Content-Disposition: inline
In-Reply-To: <46bffbdb.CiCc1bB4g9HMdx0f%joe@perches.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: joe@perches.com
Cc: torvalds@linux-foundation.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, akpm@linux-foundation.org

On Sun, Aug 12, 2007 at 11:36:11PM -0700, joe@perches.com wrote:
> Add file pattern to MAINTAINER entry
> 
> Signed-off-by: Joe Perches <joe@perches.com>

Acked-by: Mattia Dongili <malattia@linux.it>

> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 6175c77..ea4d9d9 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4241,6 +4241,8 @@ M:	malattia@linux.it
>  L:	linux-acpi@vger.kernel.org
>  W:	http://www.linux.it/~malattia/wiki/index.php/Sony_drivers
>  S:	Maintained
> +F:	drivers/char/sonypi.c
> +F:	drivers/misc/sony-laptop.c
>  
>  SOUND
>  P:	Jaroslav Kysela
> 
-- 
mattia
:wq!
