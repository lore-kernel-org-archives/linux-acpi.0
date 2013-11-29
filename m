From: Thomas Mitterfellner <thomas.mitterfellner@gmail.com>
Subject: How can a critical temperature be set?
Date: Fri, 29 Nov 2013 10:06:12 +0100
Message-ID: <CAKDaYSF8+mcaFAegNQReeRXYZfM1TRXGskrAXyZHRkrVzhCsPQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-vc0-f170.google.com ([209.85.220.170]:40406 "EHLO
	mail-vc0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753821Ab3K2JGO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 29 Nov 2013 04:06:14 -0500
Received: by mail-vc0-f170.google.com with SMTP id ht10so6617485vcb.29
        for <linux-acpi@vger.kernel.org>; Fri, 29 Nov 2013 01:06:12 -0800 (PST)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hello!

How can I set a thermal trip point for the critical temperature as
shown by acpi -V? (My laptop, Toshiba Satellite Pro l770-116, intel
HM65 chipset, shuts down frequently under high CPU load and I suspect
too low a critical temperature setting, namely 84=B0C, to be the
culprit, as I read that 91+=B0C are not uncommon for my system under
heavy load)

I asked at the lm-sensors mailing list and I was advised to ask here.
I was told that I might have to edit the DSDT tables to accomplish
this. Is there possibly some simpler way or can someone give me a hint
on how to do this?
What I want to accomplish is: I want to set (increase) the temperature
temp_crit1 shown in the output of sensors -u for the virtual device
acpitz-virtual-0.

Thank you for your help,

Thomas


=46or reference, I attached the output of acpi -V and sensors -u comman=
ds.

# acpi -V
[=85]
Thermal 0: ok, 57.0 degrees C
Thermal 0: trip point 0 switches to mode critical at temperature 84.0
degrees C
Thermal 0: trip point 1 switches to mode passive at temperature 105.0
degrees CThermal 0: ok, 57.0 degrees C
Thermal 0: trip point 0 switches to mode critical at temperature 84.0
degrees C
Thermal 0: trip point 1 switches to mode passive at temperature 105.0
degrees C:
[=85]

# sensors -u

acpitz-virtual-0
Adapter: Virtual device
temp1:
  temp1_input: 73.000
  temp1_crit: 84.000

coretemp-isa-0000
Adapter: ISA adapter
Physical id 0:
  temp1_input: 71.000
  temp1_max: 86.000
  temp1_crit: 100.000
  temp1_crit_alarm: 0.000
Core 0:
  temp2_input: 71.000
  temp2_max: 86.000
  temp2_crit: 100.000
  temp2_crit_alarm: 0.000
Core 1:
  temp3_input: 71.000
  temp3_max: 86.000
  temp3_crit: 100.000
  temp3_crit_alarm: 0.000

pkg-temp-0-virtual-0
Adapter: Virtual device
temp1:
  temp1_input: 71.000
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
