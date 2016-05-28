From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: IS_ERR_VALUE misuses
Date: Sat, 28 May 2016 12:15:06 -0700
Message-ID: <CA+55aFwh79PohObOo4Y0=ZpK=Enhv+vQvQMOm+bvWnqv7-Zv=Q@mail.gmail.com>
References: <CA+55aFyi8_m0EJGcChe_SW_zzJUTJjPJjhEFbJzEL3gyhFNDLQ@mail.gmail.com>
	<7925824.43sdZ8TD9E@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-oi0-f47.google.com ([209.85.218.47]:34453 "EHLO
	mail-oi0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750742AbcE1TPI (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 28 May 2016 15:15:08 -0400
Received: by mail-oi0-f47.google.com with SMTP id b65so219905333oia.1
        for <linux-acpi@vger.kernel.org>; Sat, 28 May 2016 12:15:07 -0700 (PDT)
In-Reply-To: <7925824.43sdZ8TD9E@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Dan Williams <dan.j.williams@intel.com>, Len Brown <lenb@kernel.org>, "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, Linux ACPI <linux-acpi@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Lv Zheng <lv.zheng@intel.com>

On Sat, May 28, 2016 at 5:13 AM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>
> Under drivers/acpi/ I could only find IS_ERR_VALUE() in acpi_dbg.c, but
> those instances should be removed by the Arnd's patch if I'm not mistaken.

Yes, I only saw that Arnd had a patch for this and asked him to just
send it to me after I had already looked at this and sent the email
out..

The acpi/nvdimm misuses are gone now, although other suspect uses of
that macro do remain..

           Linus
