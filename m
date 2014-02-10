From: Alexander Mezin <mezin.alexander@gmail.com>
Subject: Re: [PATCH 1/2] ACPI / AC: Notify when state changes in get_ac_property
Date: Mon, 10 Feb 2014 09:16:59 +0700
Message-ID: <CADnvcf+7T8qDeRhwbwhmja9N1HeAzfF_oDSBpnUX59NTCRmkAg@mail.gmail.com>
References: <1391801333-18519-1-git-send-email-mezin.alexander@gmail.com>
	<CAOLK0pytRO+4vkzH7NEcn4T=rAPbTxDQhex5YCegD-f6eKngkw@mail.gmail.com>
	<CADnvcfLxGtJtJ3de8yuzkdNhkU9vCKO-fz+LmgmL-A2tbsNdZw@mail.gmail.com>
	<CAOLK0pxeQN5gtr1qckdp+Y2Mbi8yih2U1_hQFedm18K4Mzw6_A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pb0-f52.google.com ([209.85.160.52]:61929 "EHLO
	mail-pb0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752217AbaBJCRA (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 9 Feb 2014 21:17:00 -0500
Received: by mail-pb0-f52.google.com with SMTP id jt11so5610367pbb.25
        for <linux-acpi@vger.kernel.org>; Sun, 09 Feb 2014 18:16:59 -0800 (PST)
In-Reply-To: <CAOLK0pxeQN5gtr1qckdp+Y2Mbi8yih2U1_hQFedm18K4Mzw6_A@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lan Tianyu <lantianyu1986@gmail.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

2014-02-10 8:29 GMT+07:00 Lan Tianyu <lantianyu1986@gmail.com>:
> 2014-02-08 Alexander Mezin <mezin.alexander@gmail.com>:
>> 2014-02-08 13:33 GMT+07:00 Lan Tianyu <lantianyu1986@gmail.com>:
> Hi:
>        What's the benefit of the second patch without this patch?
> So far, bios sends the ACPI notify event of power change to AC driver and
> the driver would change status and send uevent. That seems enough.
Without second patch AC adapter's status isn't updated on my laptop.
AC status updates only if I run "acpi -a". I usually automated this
with acpid.
On my laptop only battery notifications are working fine.
With second patch (and without first) everything works as it should.
