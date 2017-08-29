From: Kees Cook <keescook@google.com>
Subject: Re: [PATCH] ACPI / sysfs: Extend ACPI sysfs to provide access to boot
 error region
Date: Mon, 28 Aug 2017 17:10:33 -0700
Message-ID: <CAGXu5jLXGwbzxMEfbe-aaRos_kxnpnhOuErJx1j2qNwZvZZTag@mail.gmail.com>
References: <CAJZ5v0gML6bX2QW65Kv+huJtM4ZUjhw6PC=52hh8NiK-9Uqpzg@mail.gmail.com>
 <20170817213946.16939-1-tony.luck@intel.com> <20170818013047.427e38b7@alans-desktop>
 <3908561D78D1C84285E8C5FCA982C28F61349912@ORSMSX114.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-io0-f177.google.com ([209.85.223.177]:34750 "EHLO
        mail-io0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751291AbdH2AKf (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 28 Aug 2017 20:10:35 -0400
Received: by mail-io0-f177.google.com with SMTP id n71so9916765iod.1
        for <linux-acpi@vger.kernel.org>; Mon, 28 Aug 2017 17:10:35 -0700 (PDT)
In-Reply-To: <3908561D78D1C84285E8C5FCA982C28F61349912@ORSMSX114.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Luck, Tony" <tony.luck@intel.com>
Cc: Alan Cox <gnomes@lxorguk.ukuu.org.uk>, "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, Boris Petkov <bp@suse.de>, Tyler Baicar <tbaicar@codeaurora.org>, Punit Agrawal <punit.agrawal@arm.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Wed, Aug 23, 2017 at 7:56 AM, Luck, Tony <tony.luck@intel.com> wrote:
>>> Should this not also have a capability check. Assuming file permissions
>>> are sufficient for grabbing a chunk of system memory holding error
>>> info doesn't seem too scary but it's at odds with a lot of other cases ?
>>
>> At least one of those other cases (pstore) added a capability check and now regret
>> it.  There's a thread on reverting it. Look for:
>>
>>   Revert "pstore: Honor dmesg_restrict sysctl on dmesg dumps"
>
> Here's at least part of that thread:
>
> https://marc.info/?l=linux-kernel&m=150301241114262&w=2
>
> Kees: you were OK with removing the capability check from pstore, right?

Yeah, as long as there is comparable protections.

-Kees

-- 
Kees Cook
Pixel Security
