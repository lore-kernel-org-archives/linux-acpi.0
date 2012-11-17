From: Akinobu Mita <akinobu.mita@gmail.com>
Subject: Re: [PATCH] ACPICA: Use hweight8() and hweight16()
Date: Sat, 17 Nov 2012 19:57:13 +0900
Message-ID: <CAC5umygUDFC0vX8FPJTMtb6OCAyLXNV6YYRPZgTS3Yv68oTVAA@mail.gmail.com>
References: <1353144784-6717-1-git-send-email-akinobu.mita@gmail.com>
	<1500669.vRL5UXvquv@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-oa0-f46.google.com ([209.85.219.46]:43535 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751428Ab2KQK5O (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 17 Nov 2012 05:57:14 -0500
Received: by mail-oa0-f46.google.com with SMTP id h16so3575212oag.19
        for <linux-acpi@vger.kernel.org>; Sat, 17 Nov 2012 02:57:13 -0800 (PST)
In-Reply-To: <1500669.vRL5UXvquv@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>, Bob Moore <robert.moore@intel.com>

2012/11/17 Rafael J. Wysocki <rjw@sisk.pl>:
> On Saturday, November 17, 2012 06:33:03 PM Akinobu Mita wrote:
>> Replace homemade hamming weight function with hweight8() and hweight16().
>>
>> Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
>> Cc: Len Brown <lenb@kernel.org>
>> Cc: Rafael J. Wysocki <rjw@sisk.pl>
>> Cc: linux-acpi@vger.kernel.org
>
> Normally, it would be a good change, but in the case of ACPICA it is not.
>
> ACPICA is a separate project, which is used by multiple other operating
> system (basically everyone except for Windows) and we take that code
> from the ACPICA upstream.  If we make changes like this in the kernel
> alone, we'll start to diverge from the upstream which is not a good thing.
> We've done it for a few times and we're still feeling the pain.
>
> The right approach to do this change would be to modify the ACPICA upstream
> so that it uses OS-provided bit-counting primitives, if available.  I'm
> not sure if it's worth it, though.

Thanks for the explanation. I fully understood.
