From: "Jeff.Wu" <chping@gmail.com>
Subject: Re: ZPODD ACPI _PRW method support
Date: Thu, 29 Nov 2012 00:11:47 +0800
Message-ID: <CANh5a1xKFp57VQfufUzs3maxt8wHZCVv6gTpyvQr8FzNCJG=0A@mail.gmail.com>
References: <CANh5a1wN-vsYSAtWXWR2P5C=4kVeVj94UZPPbMGGXxHMJyzDew@mail.gmail.com>
	<1804754.cgLN50ubYg@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-vc0-f174.google.com ([209.85.220.174]:48876 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751546Ab2K1QLt (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 28 Nov 2012 11:11:49 -0500
Received: by mail-vc0-f174.google.com with SMTP id m18so10319514vcm.19
        for <linux-acpi@vger.kernel.org>; Wed, 28 Nov 2012 08:11:48 -0800 (PST)
In-Reply-To: <1804754.cgLN50ubYg@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>, linux-acpi@vger.kernel.org, Lin Ming <minggr@gmail.com>, Aaron Lu <aaron.lwe@gmail.com>

Hi Rafael

Thanks,

I  am testing ZPODD function ,for Linux ZPODD kernel,
if _PRW method is removed at  BIOS ACPI DSDT codes, ZPODD work normally.
but, if _PRW method is added at BIOS ACPI DSDT codes,ZPODD can't be
wakeup when ZPODD state is suspend.
I'am not sure that Linux ZPODD whether is using _PRW to send wakeup events.

Jeff

2012/11/28 Rafael J. Wysocki <rjw@sisk.pl>:
> On Wednesday, November 28, 2012 04:52:17 PM Jeff.Wu wrote:
>> Hi aaron,ming,linux-acpi
>>
>>  Is it  whether need support ACPI _PRW method for ZPODD device ?
>
> Yes, it is.
>
>>  If BIOS had implemented _PRW method for ZPODD ,
>> but Linux kernel doesn't support  ZPODD _PRW method,ZPODD will can't
>> run into suspend state.
>
> I'm not sure what you mean.
>
> If we don't use _PRW, the device won't be able to signal wakeup events.
>
>> Is there any stories for ZPODD Linux _PRW method ?
>
> All threads related to ZPODD are about that indirectly.
>
> Thanks,
> Rafael
>
>
> --
> I speak only for myself.
> Rafael J. Wysocki, Intel Open Source Technology Center.
