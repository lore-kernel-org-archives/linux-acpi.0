From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: IS_ERR_VALUE misuses
Date: Sat, 28 May 2016 14:13:07 +0200
Message-ID: <7925824.43sdZ8TD9E@vostro.rjw.lan>
References: <CA+55aFyi8_m0EJGcChe_SW_zzJUTJjPJjhEFbJzEL3gyhFNDLQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:55524 "HELO
	cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1750801AbcE1MJX (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sat, 28 May 2016 08:09:23 -0400
In-Reply-To: <CA+55aFyi8_m0EJGcChe_SW_zzJUTJjPJjhEFbJzEL3gyhFNDLQ@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Dan Williams <dan.j.williams@intel.com>, Len Brown <lenb@kernel.org>, "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, Linux ACPI <linux-acpi@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Lv Zheng <lv.zheng@intel.com>

On Friday, May 27, 2016 01:15:12 PM Linus Torvalds wrote:
> This is just a heads-up: for some reason the acpi layer and nvdimm use
> the IS_ERR_VALUE() macro, and they use it incorrectly.
> 
> To see warnings about it, change the macro from
> 
> #define IS_ERR_VALUE(x) unlikely((x) >= (unsigned long)-MAX_ERRNO)
> 
> to do a cast to a pointer and back (ie make the "(x)" part be
> "(unsigned long)(void *)(x)" instead, which then will cause warnings
> like
> 
>   warning: cast to pointer from integer of different size
> [-Wint-to-pointer-cast]
> 
> when passed an "int" argument.
> 
> The reason "int" arguments are wrong is that the macro really is
> designed to test the upper range of a pointer value. It happens to
> work for signed integers too, but looking at the users, pretty much
> none of them are right. The ACPI and nvdimm users are all about the
> perfectly standard "zero for success, negative error code for
> failure", and so using
> 
>     if (IS_ERROR_VALUE(rc))
>         return rc;
> 
> is just plain garbage. The code generally should just do
> 
>     if (rc)
>         return rc;
> 
> which is simpler, smaller, and generates better code.
> 
> This bug seems to have been so common in the power management code
> that we even have a coccinelle script for it. But for some reason
> several uses remain in acpi_debug.c and now there are cases in
> drivers/nvdimm/ too.
> 
> There are random various crap cases like that elsewhere too, but acpi
> and nvdimm were just more dense with this bug than most other places.

Under drivers/acpi/ I could only find IS_ERR_VALUE() in acpi_dbg.c, but
those instances should be removed by the Arnd's patch if I'm not mistaken.

Thanks,
Rafael

