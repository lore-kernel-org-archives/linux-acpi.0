From: Markus Feldmann <feldmann_markus@gmx.de>
Subject: Re: syntax error, unexpected PARSEOP_NAMESEG, expecting PARSEOP_DEFINITIONBLOCK
Date: Sun, 06 May 2007 15:32:30 +0200
Message-ID: <463DD8EE.20301@gmx.de>
References: <46370B26.2080704@gmx.de>	 <8f8ff01d0705010308q197c7314o1f3dd34670b58c05@mail.gmail.com>	 <46371966.2020300@gmx.de>	 <8f8ff01d0705010638x5d4d398dk6f754e1f2cd2198a@mail.gmail.com>	 <463982CA.1060806@gmx.de> <8f8ff01d0705030912p1694820by1b61a85604d62916@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:37270 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754212AbXEFNcF (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 6 May 2007 09:32:05 -0400
In-Reply-To: <8f8ff01d0705030912p1694820by1b61a85604d62916@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
Cc: linux-acpi@vger.kernel.org

Alexey Starikovskiy schrieb:
> I already received your dsdt.dsl to my mailbox. I answered as well,
> but your provider seem to block whole gmail.com domain.
> Lets try to go without attachements:
> First error -- move Stall() function out of Return().
> Second error -- you have wrong length for optional _PSD object, so
> iasl puts everything after first item as garbage. just delete whole
> Name(_PSD {} from both places, it will ok.
> 
> Regards,
> Alex.
Hi Alex,

ok i have deleted the second error and moved out the stall() function.
Then i get this messages,
######################################################################
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

dsdt_2.6.21.dsl  6598:         Zero
Error    4094 -                   ^ syntax error, unexpected PARSEOP_ZERO

dsdt_2.6.21.dsl  6653:         Zero
Error    4094 -                   ^ syntax error, unexpected PARSEOP_ZERO

ASL Input:  dsdt_2.6.21.dsl - 7659 lines, 256009 bytes, 2868 keywords
Compilation complete. 2 Errors, 9 Warnings, 0 Remarks, 701 Optimizations
###################################################################

bye Markus
