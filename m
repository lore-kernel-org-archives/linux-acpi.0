From: Alexey Starikovskiy <alexey.y.starikovskiy@linux.intel.com>
Subject: Re: benq s73g with bugs in DSDT
Date: Sun, 17 Dec 2006 19:36:30 +0300
Message-ID: <4585720E.7060700@linux.intel.com>
References: <1166372730.6122.18.camel@pico>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:20324 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752967AbWLQQqL (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 17 Dec 2006 11:46:11 -0500
In-Reply-To: <1166372730.6122.18.camel@pico>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: philip havran <spa77@gmx.at>
Cc: linux-acpi@vger.kernel.org

These warnings are warnings -- they are not fatal by themselves.
Do you have any real problem with your notebook?
You should send output of iasl to Benq, as it is them who should fix that.

Regards,
    Alex

philip havran wrote:
> dear developers
>
> using acpid with the benq notebook s73g on ubuntu 6.06 dapper drake,
> there are several bugs (warnings) when recompiling the the dsdt.dsl.
>
> i search now for about 3 weeks on the net, but i was not able to find
> fixes for the output of the iasl compiler!
> i am running the benq s73g notebook with the leatest bios update form
> the vendors homepage!
>
> maybe you could give me some advice or an mailing list where i could
> send the problem with the DSDT to.
>
> thank you in advance 
>
> yours philip havran
>
> p.s. at the end of this mail is an attachement with the output of the
> iasl compiler
>
>
>
>
>   
> ------------------------------------------------------------------------
>
>
> Intel ACPI Component Architecture
> ASL Optimizing Compiler version 20051216 [Jan  9 2006]
> Copyright (C) 2000 - 2005 Intel Corporation
> Supports ACPI Specification Revision 3.0
>
> dsdt.dsl   328:             Method (_CST, 0, NotSerialized)
> Warning  2085 -                        ^ Not all control paths return a value (_CST)
>
> dsdt.dsl   328:             Method (_CST, 0, NotSerialized)
> Warning  2078 -                        ^ Reserved method must return a value (_CST)
>
> dsdt.dsl   488:             Method (_CST, 0, NotSerialized)
> Warning  2085 -                        ^ Not all control paths return a value (_CST)
>
> dsdt.dsl   488:             Method (_CST, 0, NotSerialized)
> Warning  2078 -                        ^ Reserved method must return a value (_CST)
>
> dsdt.dsl   493:                     Return (\_PR.CPU0._CST ())
> Warning  2090 -                                          ^ Called method may not always return a value
>
> dsdt.dsl  1147:             Method (_OSC, 5, NotSerialized)
> Warning  2074 -                        ^ Reserved method has too many arguments (_OSC requires 4)
>
> dsdt.dsl  4480:                     Method (_GTM, 0, NotSerialized)
> Warning  2085 -                                ^ Not all control paths return a value (_GTM)
>
> dsdt.dsl  4480:                     Method (_GTM, 0, NotSerialized)
> Warning  2078 -                                ^ Reserved method must return a value (_GTM)
>
> dsdt.dsl  4637:                         Method (_GTF, 0, NotSerialized)
> Warning  2085 -                                    ^ Not all control paths return a value (_GTF)
>
> dsdt.dsl  4637:                         Method (_GTF, 0, NotSerialized)
> Warning  2078 -                                    ^ Reserved method must return a value (_GTF)
>
> dsdt.dsl  4705:                         Method (_GTF, 0, NotSerialized)
> Warning  2085 -                                    ^ Not all control paths return a value (_GTF)
>
> dsdt.dsl  4705:                         Method (_GTF, 0, NotSerialized)
> Warning  2078 -                                    ^ Reserved method must return a value (_GTF)
>
> dsdt.dsl  4777:                     Method (_GTM, 0, NotSerialized)
> Warning  2085 -                                ^ Not all control paths return a value (_GTM)
>
> dsdt.dsl  4777:                     Method (_GTM, 0, NotSerialized)
> Warning  2078 -                                ^ Reserved method must return a value (_GTM)
>
> dsdt.dsl  4947:                         Method (_GTF, 0, NotSerialized)
> Warning  2085 -                                    ^ Not all control paths return a value (_GTF)
>
> dsdt.dsl  4947:                         Method (_GTF, 0, NotSerialized)
> Warning  2078 -                                    ^ Reserved method must return a value (_GTF)
>
> dsdt.dsl  5015:                         Method (_GTF, 0, NotSerialized)
> Warning  2085 -                                    ^ Not all control paths return a value (_GTF)
>
> dsdt.dsl  5015:                         Method (_GTF, 0, NotSerialized)
> Warning  2078 -                                    ^ Reserved method must return a value (_GTF)
>
> dsdt.dsl  5121:                     Method (_GTF, 0, NotSerialized)
> Warning  2085 -                                ^ Not all control paths return a value (_GTF)
>
> dsdt.dsl  5121:                     Method (_GTF, 0, NotSerialized)
> Warning  2078 -                                ^ Reserved method must return a value (_GTF)
>
> dsdt.dsl  5167:                     Method (_GTF, 0, NotSerialized)
> Warning  2085 -                                ^ Not all control paths return a value (_GTF)
>
> dsdt.dsl  5167:                     Method (_GTF, 0, NotSerialized)
> Warning  2078 -                                ^ Reserved method must return a value (_GTF)
>
> ASL Input:  dsdt.dsl - 5181 lines, 185613 bytes, 2130 keywords
> AML Output: DSDT.aml - 19127 bytes 572 named objects 1558 executable opcodes
>
> Compilation complete. 0 Errors, 22 Warnings, 0 Remarks, 131 Optimizations
>   
