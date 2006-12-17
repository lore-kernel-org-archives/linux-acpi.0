From: philip havran <spa77@gmx.at>
Subject: benq s73g with bugs in DSDT
Date: Sun, 17 Dec 2006 17:25:30 +0100
Message-ID: <1166372730.6122.18.camel@pico>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-1m8UkjjpKpRE/YvMUbf6"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:50353 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752927AbWLQQZ3 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 17 Dec 2006 11:25:29 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org


--=-1m8UkjjpKpRE/YvMUbf6
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

dear developers

using acpid with the benq notebook s73g on ubuntu 6.06 dapper drake,
there are several bugs (warnings) when recompiling the the dsdt.dsl.

i search now for about 3 weeks on the net, but i was not able to find
fixes for the output of the iasl compiler!
i am running the benq s73g notebook with the leatest bios update form
the vendors homepage!

maybe you could give me some advice or an mailing list where i could
send the problem with the DSDT to.

thank you in advance 

yours philip havran

p.s. at the end of this mail is an attachement with the output of the
iasl compiler





--=-1m8UkjjpKpRE/YvMUbf6
Content-Disposition: attachment; filename=dsdt_output
Content-Type: text/plain; name=dsdt_output; charset=UTF-8
Content-Transfer-Encoding: 7bit


Intel ACPI Component Architecture
ASL Optimizing Compiler version 20051216 [Jan  9 2006]
Copyright (C) 2000 - 2005 Intel Corporation
Supports ACPI Specification Revision 3.0

dsdt.dsl   328:             Method (_CST, 0, NotSerialized)
Warning  2085 -                        ^ Not all control paths return a value (_CST)

dsdt.dsl   328:             Method (_CST, 0, NotSerialized)
Warning  2078 -                        ^ Reserved method must return a value (_CST)

dsdt.dsl   488:             Method (_CST, 0, NotSerialized)
Warning  2085 -                        ^ Not all control paths return a value (_CST)

dsdt.dsl   488:             Method (_CST, 0, NotSerialized)
Warning  2078 -                        ^ Reserved method must return a value (_CST)

dsdt.dsl   493:                     Return (\_PR.CPU0._CST ())
Warning  2090 -                                          ^ Called method may not always return a value

dsdt.dsl  1147:             Method (_OSC, 5, NotSerialized)
Warning  2074 -                        ^ Reserved method has too many arguments (_OSC requires 4)

dsdt.dsl  4480:                     Method (_GTM, 0, NotSerialized)
Warning  2085 -                                ^ Not all control paths return a value (_GTM)

dsdt.dsl  4480:                     Method (_GTM, 0, NotSerialized)
Warning  2078 -                                ^ Reserved method must return a value (_GTM)

dsdt.dsl  4637:                         Method (_GTF, 0, NotSerialized)
Warning  2085 -                                    ^ Not all control paths return a value (_GTF)

dsdt.dsl  4637:                         Method (_GTF, 0, NotSerialized)
Warning  2078 -                                    ^ Reserved method must return a value (_GTF)

dsdt.dsl  4705:                         Method (_GTF, 0, NotSerialized)
Warning  2085 -                                    ^ Not all control paths return a value (_GTF)

dsdt.dsl  4705:                         Method (_GTF, 0, NotSerialized)
Warning  2078 -                                    ^ Reserved method must return a value (_GTF)

dsdt.dsl  4777:                     Method (_GTM, 0, NotSerialized)
Warning  2085 -                                ^ Not all control paths return a value (_GTM)

dsdt.dsl  4777:                     Method (_GTM, 0, NotSerialized)
Warning  2078 -                                ^ Reserved method must return a value (_GTM)

dsdt.dsl  4947:                         Method (_GTF, 0, NotSerialized)
Warning  2085 -                                    ^ Not all control paths return a value (_GTF)

dsdt.dsl  4947:                         Method (_GTF, 0, NotSerialized)
Warning  2078 -                                    ^ Reserved method must return a value (_GTF)

dsdt.dsl  5015:                         Method (_GTF, 0, NotSerialized)
Warning  2085 -                                    ^ Not all control paths return a value (_GTF)

dsdt.dsl  5015:                         Method (_GTF, 0, NotSerialized)
Warning  2078 -                                    ^ Reserved method must return a value (_GTF)

dsdt.dsl  5121:                     Method (_GTF, 0, NotSerialized)
Warning  2085 -                                ^ Not all control paths return a value (_GTF)

dsdt.dsl  5121:                     Method (_GTF, 0, NotSerialized)
Warning  2078 -                                ^ Reserved method must return a value (_GTF)

dsdt.dsl  5167:                     Method (_GTF, 0, NotSerialized)
Warning  2085 -                                ^ Not all control paths return a value (_GTF)

dsdt.dsl  5167:                     Method (_GTF, 0, NotSerialized)
Warning  2078 -                                ^ Reserved method must return a value (_GTF)

ASL Input:  dsdt.dsl - 5181 lines, 185613 bytes, 2130 keywords
AML Output: DSDT.aml - 19127 bytes 572 named objects 1558 executable opcodes

Compilation complete. 0 Errors, 22 Warnings, 0 Remarks, 131 Optimizations

--=-1m8UkjjpKpRE/YvMUbf6--

