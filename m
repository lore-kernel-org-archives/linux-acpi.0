From: Lan Tianyu <lantianyu1986@gmail.com>
Subject: Re: How can a critical temperature be set?
Date: Sat, 30 Nov 2013 20:01:45 +0800
Message-ID: <CAOLK0pxC8vKN18x2zXifXZFjOaOypVnzRm-SFQEaQHHVZRYQNg@mail.gmail.com>
References: <CAKDaYSF8+mcaFAegNQReeRXYZfM1TRXGskrAXyZHRkrVzhCsPQ@mail.gmail.com>
	<CAOLK0pwQX5qjggp=cD11sxyeV_Ap3+FGfDqbOu9yxLJ0VOk58w@mail.gmail.com>
	<5299CC8F.6050406@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ie0-f181.google.com ([209.85.223.181]:56977 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751851Ab3K3MBp (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 30 Nov 2013 07:01:45 -0500
Received: by mail-ie0-f181.google.com with SMTP id e14so18057775iej.12
        for <linux-acpi@vger.kernel.org>; Sat, 30 Nov 2013 04:01:45 -0800 (PST)
In-Reply-To: <5299CC8F.6050406@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Mitterfellner <thomas.mitterfellner@gmail.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

2013/11/30 Thomas Mitterfellner <thomas.mitterfellner@gmail.com>:
>
>>> How can I set a thermal trip point for the critical temperature as
>>> shown by acpi -V?
>>
>> Please try adding kernel param "thermal.crt=91".
>
> Yes! That works! Is there a special reason why you suggested the value
> 91? Because I added thermal.crt=99 as I saw it on some occasion on my
> system.

No, just give an example.

>
> Now I get:
>
> # acpi -V
> Thermal 0: ok, 64.0 degrees C
> Thermal 0: trip point 0 switches to mode critical at temperature 99.0
> degrees C
> Thermal 0: trip point 1 switches to mode passive at temperature 105.0
> degrees C
>
> and
>
> acpitz-virtual-0
> Adapter: Virtual device
> temp1:
>   temp1_input: 66.000
>   temp1_crit: 99.000
>
> coretemp-isa-0000
> Adapter: ISA adapter
> Physical id 0:
>   temp1_input: 66.000
>   temp1_max: 86.000
>   temp1_crit: 100.000
>   temp1_crit_alarm: 0.000
> Core 0:
>   temp2_input: 63.000
>   temp2_max: 86.000
>   temp2_crit: 100.000
>   temp2_crit_alarm: 0.000
> Core 1:
>   temp3_input: 66.000
>   temp3_max: 86.000
>   temp3_crit: 100.000
>   temp3_crit_alarm: 0.000
>
> pkg-temp-0-virtual-0
> Adapter: Virtual device
> temp1:
>   temp1_input: 67.000
>
>
>
> Thank you for your kind help,
>
> Thomas

You are welcome.

-- 
Best regards
Tianyu Lan
