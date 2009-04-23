From: Marcin Gozdalik <gozdal@gmail.com>
Subject: Re: ACPI Exception (AE_ERROR, ACPI thermal trip point state changed)
Date: Thu, 23 Apr 2009 12:19:07 +0200
Message-ID: <fab5b76e0904230319t2e945461x764b357f54346193@mail.gmail.com>
References: <fab5b76e0904220858x71bf226dn19071ddc5692e7ec@mail.gmail.com>
	<alpine.LFD.2.00.0904221313170.6187@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.170]:12545 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754313AbZDWKTX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 23 Apr 2009 06:19:23 -0400
Received: by wf-out-1314.google.com with SMTP id 26so405629wfd.4
        for <linux-acpi@vger.kernel.org>; Thu, 23 Apr 2009 03:19:22 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.00.0904221313170.6187@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org

2009/4/22 Len Brown <lenb@kernel.org>:
>
>
> On Wed, 22 Apr 2009, Marcin Gozdalik wrote:
>
>> Hi
>>
>> I am seeing the following in logs:
>>
>> Apr 22 16:00:07 myth kernel: [=C2=A0=C2=A0 39.354031] ACPI Exception
>> (thermal-0479): AE_ERROR, ACPI thermal trip point state changed
>> Apr 22 16:00:07 myth kernel: [=C2=A0=C2=A0 39.354040] Please send ac=
pidump to
>> linux-acpi@vger.kernel.org
>> Apr 22 16:00:07 myth kernel: [=C2=A0=C2=A0 39.354045]=C2=A0 [2008092=
6]
>>
>> I am using Ubuntu 9.04:
>>
>> root@myth:/home/gozdal# uname -a
>> Linux myth 2.6.28-11-generic #42-Ubuntu SMP Fri Apr 17 01:58:03 UTC
>> 2009 x86_64 GNU/Linux
>>
>> Motherboard is Abit AN-M2HD(MCP68) flashed with the latest BIOS.
>>
>> The machine powers down sometimes because of an ACPI trip point:
>>
>> Apr 22 17:27:19 myth kernel: [ 5272.004934] ACPI: Critical trip poin=
t
>> Apr 22 17:27:19 myth kernel: [ 5272.004952] Critical temperature
>> reached (121 C), shutting down.
>> Apr 22 17:27:19 myth kernel: [ 5272.004973] ACPI: Unable to turn
>> cooling device [ffff88006f841800] 'on'
>> Apr 22 17:27:26 myth kernel: [ 5278.204238] Critical temperature
>> reached (34 C), shutting down.
>>
>> although I believe this is an error in measurement, as the temperatu=
re
>> probably wouldn't cool in 7 seconds from 121 to 34 Celsius.
>
> did this happen with earlier kernels, or did it start in 2.6.28?

It happened with earlier kernels as well.

> please try 2.6.29.

I will try.

> please try it with CONFIG_HWMON=3Dn

Would that be only a workaround or a solution? As a workaround I use
thermal.nocrt=3D1 (or options thermal nocrt=3D1).
Should I try both 2.6.29 and CONFIG_HWMON=3Dn?

> If it still fails, please file a bugzilla
> http://bugzilla.kernel.org/enter_bug.cgi?product=3DACPI
> and attach the acpidump there.

I will as soon as I will have tried the options.

Best regards

--=20
Marcin Gozdalik <gozdal@gmail.com>
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
