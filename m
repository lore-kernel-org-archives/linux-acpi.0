From: Vinzenz Bargsten <vbargsten@freenet.de>
Subject: Fan does not obey trip points
Date: Tue, 29 Mar 2011 12:36:03 +0200
Message-ID: <4D91B613.60603@freenet.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mout2.freenet.de ([195.4.92.92]:54469 "EHLO mout2.freenet.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752472Ab1C2KgL (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 29 Mar 2011 06:36:11 -0400
Received: from [195.4.92.27] (helo=17.mx.freenet.de)
	by mout2.freenet.de with esmtpa (ID vbargsten@freenet.de) (port 25) (Exim 4.72 #3)
	id 1Q4WHP-00038M-9o
	for linux-acpi@vger.kernel.org; Tue, 29 Mar 2011 12:36:07 +0200
Received: from f053206062.adsl.alicedsl.de ([78.53.206.62]:59625 helo=vb-home.site)
	by 17.mx.freenet.de with esmtpsa (ID vbargsten@freenet.de) (TLSv1:CAMELLIA256-SHA:256) (port 25) (Exim 4.72 #3)
	id 1Q4WHP-0000kj-5R
	for linux-acpi@vger.kernel.org; Tue, 29 Mar 2011 12:36:07 +0200
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hi,

I have the problem that the fan of my laptop is almost constantly on=20
(with low speed).
This is not the case when using windows, the fan turns completely off,=20
just spins up every now and then.
So it should be possible to reduce the noise, which is very annoying=20
when working
for a longer time or in quiet environments.

According to "acpi -V", the active trip point is at 60=B0C. However, th=
e=20
fan is also  on at less than 45=B0.

Here is the output of acpi -V, the fan is on:
-----------------------------------------------------------------------=
----------------
Battery 0: Charging, 20%, 01:18:26 until charged
Battery 0: design capacity 4400 mAh, last full capacity 4688 mAh =3D 10=
0%
Adapter 0: on-line
Thermal 0: ok, 47.0 degrees C
Thermal 0: trip point 0 switches to mode critical at temperature 99.0=20
degrees C
Thermal 0: trip point 1 switches to mode passive at temperature 95.0=20
degrees C
Thermal 0: trip point 2 switches to mode active at temperature 60.0=20
degrees C
Cooling 0: LCD 2 of 11
Cooling 1: Fan 0 of 1
Cooling 2: Processor 0 of 10
Cooling 3: Processor 0 of 10
Cooling 4: Processor 0 of 10
Cooling 5: Processor 0 of 10
-----------------------------------------------------------------------=
------------------

I am using opensuse 11.4 with kernel 2.6.38-1 on a Fujitsu A530 laptop=20
(core i5).
Do you know a solution, such that the fan also turns off completely whe=
n=20
using linux?

Kind Regards,
Vinzenz
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
