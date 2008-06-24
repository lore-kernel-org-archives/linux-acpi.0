From: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Subject: Re: + fujitsu-laptop-depends-on-input.patch added to -mm tree
Date: Tue, 24 Jun 2008 10:11:04 +0930 (CST)
Message-ID: <200806240041.m5O0f46x014878@turbo.physics.adelaide.edu.au>
References: <200806240001.m5O01M6h023130@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from adelphi.physics.adelaide.edu.au ([129.127.102.1]:58741 "EHLO
	adelphi.physics.adelaide.edu.au" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751278AbYFXAoE (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Mon, 23 Jun 2008 20:44:04 -0400
Received: from turbo.physics.adelaide.edu.au (IDENT:0@turbo [129.127.102.108])
	by adelphi.physics.adelaide.edu.au (8.13.7/8.13.7/UofA-Physics-1.0) with ESMTP id m5O0i1GK003319
	for <linux-acpi@vger.kernel.org>; Tue, 24 Jun 2008 10:14:01 +0930
Received: from turbo.physics.adelaide.edu.au (IDENT:7157@localhost [127.0.0.1])
	by turbo.physics.adelaide.edu.au (8.13.4/8.13.4) with ESMTP id m5O0i1J3014964
	for <linux-acpi@vger.kernel.org>; Tue, 24 Jun 2008 10:14:01 +0930
Received: (from jwoithe@localhost)
	by turbo.physics.adelaide.edu.au (8.13.4/8.13.4/Submit) id m5O0i01k014963
	for linux-acpi@vger.kernel.org; Tue, 24 Jun 2008 10:14:00 +0930
In-Reply-To: <200806240001.m5O01M6h023130@imap1.linux-foundation.org> from "akpm@linux-foundation.org" at Jun 23, 2008 05:01:22 PM
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: akpm@linux-foundation.org
Cc: randy.dunlap@oracle.com, jwoithe@physics.adelaide.edu.au, lenb@kernel.org

Hi Len

> The patch titled
>      fujitsu-laptop: depends on INPUT
> has been added to the -mm tree.  Its filename is
>      fujitsu-laptop-depends-on-input.patch
> :
> ------------------------------------------------------
> Subject: fujitsu-laptop: depends on INPUT
> From: Randy Dunlap <randy.dunlap@oracle.com>
> 
> fujitsu-laptop uses input_* functions, so it should depend on INPUT.
> :
> Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
> Cc: <jwoithe@physics.adelaide.edu.au>
> Cc: Len Brown <lenb@kernel.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
> 
>  drivers/misc/Kconfig |    1 +
>  1 file changed, 1 insertion(+)
> 
> diff -puN drivers/misc/Kconfig~fujitsu-laptop-depends-on-input drivers/misc/Kconfig
> --- a/drivers/misc/Kconfig~fujitsu-laptop-depends-on-input
> +++ a/drivers/misc/Kconfig
> @@ -179,6 +179,7 @@ config FUJITSU_LAPTOP
>          tristate "Fujitsu Laptop Extras"
>          depends on X86
>          depends on ACPI
> +        depends on INPUT
>          depends on BACKLIGHT_CLASS_DEVICE
>          ---help---
>  	  This is a driver for laptops built by Fujitsu:

Ack.

Randy's right - fujitsu-laptop depends on INPUT.  Please apply to ACPI tree.

Signed-off-by: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>

Regards
  jonathan

