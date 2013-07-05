From: Adam Langley <agl@imperialviolet.org>
Subject: Re: ACPI errors from TPM PPI
Date: Fri, 5 Jul 2013 10:03:10 -0400
Message-ID: <CAMfhd9U6qvm2kTb2D8PgzR8qCqZnDWhLNC4Ojzftc8PdmKwjnA@mail.gmail.com>
References: <CAMfhd9XWfp420M9wF-ACya9hbQGUSkneRB6sry9=nj1KtB_ygw@mail.gmail.com>
	<10172565.WQexNecTHe@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:61685 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751588Ab3GEODM (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 5 Jul 2013 10:03:12 -0400
Received: by mail-lb0-f174.google.com with SMTP id x10so2088026lbi.33
        for <linux-acpi@vger.kernel.org>; Fri, 05 Jul 2013 07:03:10 -0700 (PDT)
In-Reply-To: <10172565.WQexNecTHe@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: xiaoyan.zhang@intel.com, Bob Moore <robert.moore@intel.com>, Lv Zheng <lv.zheng@intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>

On Thu, Jul 4, 2013 at 9:07 PM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>> This appears to be coming from acpi_evaluate_object_typed in
>> http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/drivers/char/tpm/tpm_ppi.c#n75,
>> so I added a printk to get the actual value of |status| when it fails
>> and it's 5 (aka AE_NOT_FOUND I believe).

In hindsight, the error was somewhat obvious. The driver is locating
the TPM object in the ACPI tables by walking the tables with a
callback [1]. The callback is using strstr to look for the substring
"TPM" in the handle of the object and returns the first that it finds.
On my system, if I alter the callback to print each match and not
abort the walk I find three values:

\_SB_.PCI0.TPMX
\_SB_.PCI0.LPCB.TPM_
\_SB_.PCI0.ITPM

Of these, the second is the right one.

(I note that the callback also appears to have a memory leak in the
case that the string doesn't contain "TPM".)

I'm sure that the strstr() worked on the computer that it was
developed on, but it's rather fragile. I can get it working for me by
using "LPCB.TPM" as the argument to strstr(), but who's to say that
doesn't break someone else?

So I would submit a patch if I was more confident that I was actually
improving matters by doing so!

[1] http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/drivers/char/tpm/tpm_ppi.c#n27


Cheers

AGL
