From: =?ISO-8859-1?Q?Angel_Pe=F1a?= <angelpp@bigfoot.com>
Subject: Re: HP Probook 4510s fan always at high speed
Date: Mon, 26 Apr 2010 14:07:57 +0200
Message-ID: <4BD5821D.6000406@bigfoot.com>
References: <4BB38F3C.4040108@bigfoot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from relay.ubu.es ([193.146.160.3]:60048 "EHLO relay.ubu.es"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752862Ab0DZMG7 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 26 Apr 2010 08:06:59 -0400
Received: from [193.146.170.132] (isa05.inf.ubu.es [193.146.170.132])
	by relay.ubu.es (ubumail) with ESMTP id 119044E2CA
	for <linux-acpi@vger.kernel.org>; Mon, 26 Apr 2010 14:06:58 +0200 (CEST)
In-Reply-To: <4BB38F3C.4040108@bigfoot.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

This is the sensors-detect command output from my HP 4510s ProBook:

# sensors-detect
Shutting down sensors:                                               do=
ne
# sensors-detect revision 5729 (2009-06-02 15:51:29 +0200)             =
=20
# System: Hewlett-Packard HP ProBook 4510s (laptop)                    =
=20
# Board: Hewlett-Packard 3074                                          =
=20

This program will help you determine which kernel modules you need
to load to use lm_sensors most effectively. It is generally safe=20
and recommended to accept the default answers to all questions, =20
unless you know what you're doing.                              =20

Some south bridges, CPUs or memory controllers contain embedded sensors=
=2E
Do you want to scan for them? This is totally safe. (YES/no): YES     =20
Silicon Integrated Systems SIS5595...                       No        =20
VIA VT82C686 Integrated Sensors...                          No        =20
VIA VT8231 Integrated Sensors...                            No        =20
AMD K8 thermal sensors...                                   No        =20
AMD K10 thermal sensors...                                  No        =20
Intel Core family thermal sensor...                         Success!  =20
    (driver `coretemp')                                               =20
Intel AMB FB-DIMM thermal sensor...                         No        =20
VIA C7 thermal and voltage sensors...                       No        =20

Some Super I/O chips contain embedded sensors. We have to write to
standard I/O ports to probe them. This is usually safe.         =20
Do you want to scan for Super I/O sensors? (YES/no):            =20
Probing for Super-I/O at 0x2e/0x2f                              =20
Trying family `National Semiconductor'...                   No  =20
Trying family `SMSC'...                                     Yes =20
=46ound unknown chip with ID 0x4501                               =20
Probing for Super-I/O at 0x4e/0x4f                              =20
Trying family `National Semiconductor'...                   No  =20
Trying family `SMSC'...                                     No  =20
Trying family `VIA/Winbond/Fintek'...                       No  =20
Trying family `ITE'...                                      No  =20

This is the sensors command output

# sensors
acpitz-virtual-0
Adapter: Virtual device
temp1:       +75.0=B0C  (crit =3D +108.0=B0C)
temp2:       +30.0=B0C  (crit =3D +105.0=B0C)
temp3:       +40.0=B0C  (crit =3D +108.0=B0C)
temp4:       +45.0=B0C  (crit =3D +105.0=B0C)
temp5:       +20.0=B0C  (crit =3D +108.0=B0C)
temp6:       +45.0=B0C  (crit =3D +110.0=B0C)

temp1 is high and increasing from +70.0=BAC despite the high fan speed.

It seems that this machine is not yet supported.

Angel


Angel Pe=F1a escribi=F3:
> My new HP Probook 4510s with openSuse 11.2 (kernel 2.6.31) or 11.3
> Milestone 4 (kernel 2.6.32) always ends running the fan at high speed=
=2E
> There must be a change in the BIOS because in others HP laptops (nx61=
25,
> nx7300) it didn't occur.
>
> Thanks for you attention.
>
> Angel Pe=F1a
>
>  =20

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
