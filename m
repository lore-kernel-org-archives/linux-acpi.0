From: Markus Feldmann <feldmann_markus@gmx.de>
Subject: Re: syntax error, unexpected PARSEOP_NAMESEG, expecting PARSEOP_DEFINITIONBLOCK
Date: Tue, 01 May 2007 20:43:02 +0200
Message-ID: <46378A36.7080108@gmx.de>
References: <46370B26.2080704@gmx.de>	 <8f8ff01d0705010308q197c7314o1f3dd34670b58c05@mail.gmail.com>	 <46371966.2020300@gmx.de> <8f8ff01d0705010638x5d4d398dk6f754e1f2cd2198a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:58600 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1031267AbXEASmp (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 1 May 2007 14:42:45 -0400
In-Reply-To: <8f8ff01d0705010638x5d4d398dk6f754e1f2cd2198a@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <aystarik@gmail.com>
Cc: linux-acpi@vger.kernel.org

Alexey Starikovskiy schrieb:
> Please remove error lines at the beginning of the file and try to
> compile it again...
> 
Ok here it comes the corrected dsdt_2.6.21.dsl file with the new error
messages,

feld-bertlap:~/acpi/dsdt# iasl -tc dsdt_2.6.21.dsl

Intel ACPI Component Architecture
ASL Optimizing Compiler version 20060912 [Dec 20 2006]
Copyright (C) 2000 - 2006 Intel Corporation
Supports ACPI Specification Revision 3.0a

dsdt_2.6.21.dsl    20:     Name (_T00, 0x00)
Warning  1097 -                     ^ Unknown reserved name (_T00)

dsdt_2.6.21.dsl  6218:             Acquire (MUTE, 0x03E8)
Warning  1103 -   Possible operator timeout is ignored ^

dsdt_2.6.21.dsl  6232:             Acquire (MUTE, 0x03E8)
Warning  1103 -   Possible operator timeout is ignored ^

dsdt_2.6.21.dsl  6247:             Acquire (MUTE, 0x03E8)
Warning  1103 -   Possible operator timeout is ignored ^

dsdt_2.6.21.dsl  6262:             Acquire (MUTE, 0x0FFF)
Warning  1103 -   Possible operator timeout is ignored ^

dsdt_2.6.21.dsl  6276:             Acquire (MUTE, 0x03E8)
Warning  1103 -   Possible operator timeout is ignored ^

dsdt_2.6.21.dsl  6291:             Acquire (MUTE, 0x03E8)
Warning  1103 -   Possible operator timeout is ignored ^

dsdt_2.6.21.dsl  6306:             Acquire (MUTE, 0x03E8)
Warning  1103 -   Possible operator timeout is ignored ^

dsdt_2.6.21.dsl  6504:     Method (WFZF, 1, NotSerialized)
Warning  1086 -                       ^ Not all control paths return a 
value (WFZF)

dsdt_2.6.21.dsl  6519:                 Return (Stall (0x0F))
Error    4094 -                                    ^ syntax error, 
unexpected PARSEOP_STALL

dsdt_2.6.21.dsl  6606:         Zero
Error    4094 -                   ^ syntax error, unexpected PARSEOP_ZERO

dsdt_2.6.21.dsl  6671:         Zero
Error    4094 -                   ^ syntax error, unexpected PARSEOP_ZERO

ASL Input:  dsdt_2.6.21.dsl - 7677 lines, 256431 bytes, 2870 keywords
Compilation complete. 3 Errors, 9 Warnings, 0 Remarks, 701 Optimizations






can you help me to fix the errors?

thanks and bye Markus
