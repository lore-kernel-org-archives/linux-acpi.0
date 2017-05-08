From: Loc Ho <lho@apm.com>
Subject: Re: [PATCH] ACPI: SPCR: Use access width to determine mmio usage
Date: Mon, 8 May 2017 12:11:59 -0700
Message-ID: <CAPw-ZTkF2KnC2TWwxWLTKoM5LPkipHvJeQGaBp30JjDNQ76VEA@mail.gmail.com>
References: <1493910330-17913-1-git-send-email-jon.mason@broadcom.com> <4e11bb2b-7cec-6a7b-ca2b-88be31a98b7d@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-it0-f41.google.com ([209.85.214.41]:38014 "EHLO
        mail-it0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754698AbdEHTMA (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 8 May 2017 15:12:00 -0400
Received: by mail-it0-f41.google.com with SMTP id e65so44363999ita.1
        for <linux-acpi@vger.kernel.org>; Mon, 08 May 2017 12:12:00 -0700 (PDT)
In-Reply-To: <4e11bb2b-7cec-6a7b-ca2b-88be31a98b7d@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jon Masters <jcm@redhat.com>
Cc: Jon Mason <jon.mason@broadcom.com>, Rafael Wysocki <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Robert Moore <robert.moore@intel.com>, Lv Zheng <lv.zheng@intel.com>, linux-acpi@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, devel@acpica.org, bcm-kernel-feedback-list@broadcom.com

Hi Jon,

>> The current SPCR code does not check the access width of the mmio, and
>> uses a default of 8bit register accesses.  This prevents devices that
>> only do 16 or 32bit register accesses from working.  By simply checking
>> this field and setting the mmio string appropriately, this issue can be
>> corrected.  To prevent any legacy issues, the code will default to 8bit
>> accesses if the value is anything but 16 or 32.
>
> Thanks for this. Just as an FYI I've a running discussion with Microsoft
> about defining additional UART subtypes in the DBG2 for special case
> UARTs. Specifically, I want to address AppliedMicro's special 8250 dw IP
> that also has a non-standard clock. At this time, there is general
> agreement to use the access width for some cases rather than defining
> yet more subtypes - so your patch is good.
>
> Loc/Applied: please track this thread, incorporate feedback, and also
> track the other general recent discussions of 8250 dw from this week.

Thanks for forward me this patch. This patch does not work with X-Gene
v1 and v2 SoC's. As BIOS SPCR encodes these info as:

Bit Width: 32
Bit Offset: 0
Encoded Access Width: 01 (Byte Access)

With this patch, it would use the "mmio" instead the "mmio32" as with
this patch - https://patchwork.kernel.org/patch/9460959

-Loc
