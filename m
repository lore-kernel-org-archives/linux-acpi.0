From: Thomas Mitterfellner <thomas.mitterfellner@gmail.com>
Subject: Re: How can a critical temperature be set?
Date: Sat, 30 Nov 2013 12:31:27 +0100
Message-ID: <5299CC8F.6050406@gmail.com>
References: <CAKDaYSF8+mcaFAegNQReeRXYZfM1TRXGskrAXyZHRkrVzhCsPQ@mail.gmail.com> <CAOLK0pwQX5qjggp=cD11sxyeV_Ap3+FGfDqbOu9yxLJ0VOk58w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ea0-f172.google.com ([209.85.215.172]:39055 "EHLO
	mail-ea0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751158Ab3K3Lbd (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 30 Nov 2013 06:31:33 -0500
Received: by mail-ea0-f172.google.com with SMTP id q10so7399570ead.17
        for <linux-acpi@vger.kernel.org>; Sat, 30 Nov 2013 03:31:32 -0800 (PST)
In-Reply-To: <CAOLK0pwQX5qjggp=cD11sxyeV_Ap3+FGfDqbOu9yxLJ0VOk58w@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lan Tianyu <lantianyu1986@gmail.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>


>> How can I set a thermal trip point for the critical temperature as
>> shown by acpi -V?
> 
> Please try adding kernel param "thermal.crt=91".

Yes! That works! Is there a special reason why you suggested the value
91? Because I added thermal.crt=99 as I saw it on some occasion on my
system.

Now I get:

# acpi -V
Thermal 0: ok, 64.0 degrees C
Thermal 0: trip point 0 switches to mode critical at temperature 99.0
degrees C
Thermal 0: trip point 1 switches to mode passive at temperature 105.0
degrees C

and

acpitz-virtual-0
Adapter: Virtual device
temp1:
  temp1_input: 66.000
  temp1_crit: 99.000

coretemp-isa-0000
Adapter: ISA adapter
Physical id 0:
  temp1_input: 66.000
  temp1_max: 86.000
  temp1_crit: 100.000
  temp1_crit_alarm: 0.000
Core 0:
  temp2_input: 63.000
  temp2_max: 86.000
  temp2_crit: 100.000
  temp2_crit_alarm: 0.000
Core 1:
  temp3_input: 66.000
  temp3_max: 86.000
  temp3_crit: 100.000
  temp3_crit_alarm: 0.000

pkg-temp-0-virtual-0
Adapter: Virtual device
temp1:
  temp1_input: 67.000



Thank you for your kind help,

Thomas
