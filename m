From: Matt Fleming <matt@codeblueprint.co.uk>
Subject: Re: [PATCH 0/6] Apple device properties
Date: Mon, 15 Aug 2016 12:54:14 +0100
Message-ID: <20160815115414.GE30909@codeblueprint.co.uk>
References: <cover.1469616641.git.lukas@wunner.de>
 <20160804145710.GL3636@codeblueprint.co.uk>
 <20160809133816.GA6571@wunner.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wm0-f51.google.com ([74.125.82.51]:36532 "EHLO
	mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752984AbcHOLyR (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 15 Aug 2016 07:54:17 -0400
Received: by mail-wm0-f51.google.com with SMTP id q128so85731857wma.1
        for <linux-acpi@vger.kernel.org>; Mon, 15 Aug 2016 04:54:16 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20160809133816.GA6571@wunner.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lukas Wunner <lukas@wunner.de>
Cc: linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org, Andreas Noever <andreas.noever@gmail.com>, x86@kernel.org, linux-acpi@vger.kernel.org

On Tue, 09 Aug, at 03:38:16PM, Lukas Wunner wrote:
> @@ -208,7 +201,10 @@ struct efi_config {
>  __pure const struct efi_config *__efi_early(void);
>  
>  #define efi_call_early(f, ...)						\
> -	__efi_early()->call(__efi_early()->f, __VA_ARGS__);
> +	__efi_early()->call(__efi_early()->is64 ?			\
> +	((efi_boot_services_64_t *)__efi_early()->boot_services)->f :	\
> +	((efi_boot_services_32_t *)__efi_early()->boot_services)->f,	\
> +						       __VA_ARGS__);
>  

You cannot use pointers from the firmware directly in mixed mode
because the kernel is compiled for 64-bits but the firmware is using
32-bit addresses, so dereferencing a pointer causes a 64-bit load.

That's the reason we deconstruct the tables and copy the addresses
from the last level - so we don't have to jump through multiple
pointers.
