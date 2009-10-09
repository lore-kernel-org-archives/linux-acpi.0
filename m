From: Scott Dylewski <scott@dylewski.com>
Subject: lenovo ideapad s12 dsdt errors...
Date: Fri, 09 Oct 2009 12:34:07 -0700
Message-ID: <1255116847.12236.272.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hapkido.dreamhost.com ([66.33.216.122]:36194 "EHLO
	hapkido.dreamhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753443AbZJITf5 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 9 Oct 2009 15:35:57 -0400
Received: from blingymail-a1.g.dreamhost.com (caibbdcaaaaf.dreamhost.com [208.113.200.5])
	by hapkido.dreamhost.com (Postfix) with ESMTP id 45F0B17B632
	for <linux-acpi@vger.kernel.org>; Fri,  9 Oct 2009 12:35:18 -0700 (PDT)
Received: from [192.168.16.12] (adsl-99-138-86-173.dsl.pltn13.sbcglobal.net [99.138.86.173])
	by blingymail-a1.g.dreamhost.com (Postfix) with ESMTP id 86EA15CE37
	for <linux-acpi@vger.kernel.org>; Fri,  9 Oct 2009 12:34:09 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: ACPI Devel Maling List <linux-acpi@vger.kernel.org>

I just bought a Lenovo S12 netbook (atom processor) and installed Ubuntu
Karmic netbook remix on it, and I'm having some issues.  I'm getting
some long boot times, and wonder if it's related to the ACPI stuff. 

So I found some stuff online that suggests that my dsdt may have some
errors, and when I checked, it used a MSFT compiler and had a bunch of
warnings and errors, but I don't know how to fix them.  Can someone
direct me a bit and either help me fix the errors if needed, or let me
know what to do?  

the weirdest thing is that this netbook/laptop seems to boot and then
"stall" at various points in the boot process, and touching the trackpad
will immediately get the process going again...  weird!

So, even if my boot issues aren't due to ACPI, I'm hoping someone could
check my dsdt.dsl and see if it would help to fix the errors:

scott@feynman:~$ iasl -tc dsdt.dsl

Intel ACPI Component Architecture
ASL Optimizing Compiler version 20081204 [Jan 10 2009]
Copyright (C) 2000 - 2008 Intel Corporation
Supports ACPI Specification Revision 3.0a

dsdt.dsl    72:     Field (PRT0, DWordAcc, Lock, Preserve)
Error    4027 -               ^ Access width is greater than region size

dsdt.dsl    74:         P80H,   8
Error    4028 -            ^ Access width of Field Unit extends beyond
region limit

dsdt.dsl   978:             Name (_HID, "*pnp0c14")
Error    4001 -                                  ^ String must be
entirely alphanumeric (*pnp0c14)

dsdt.dsl  1007:             Method (_WED, 1, NotSerialized)
Warning  1087 -                        ^ Not all control paths return a
value (_WED)

dsdt.dsl  1007:             Method (_WED, 1, NotSerialized)
Warning  1080 -                        ^ Reserved method must return a
value (_WED)

dsdt.dsl  4294:                             Method (_CFG, 0,
NotSerialized)
Warning  1098 -                  Unknown reserved name ^  (_CFG)

dsdt.dsl  4401:                                     Name (_T_0, 0x00)
Remark   5110 -                Use of compiler reserved name ^  (_T_0)

ASL Input:  dsdt.dsl - 6286 lines, 233566 bytes, 2384 keywords
Compilation complete. 3 Errors, 3 Warnings, 1 Remarks, 661 Optimizations
scott@feynman:~$ 

Should I attach the dsdt.dsl?

thanks!

-scott

