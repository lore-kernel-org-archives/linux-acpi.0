From: AnMaster <anmaster@tele2.se>
Subject: DSDT problems with Asus K8V-X SE
Date: Sat, 05 Jan 2008 17:58:50 +0100
Message-ID: <477FB74A.7080908@tele2.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mailfe15.swip.net ([212.247.155.193]:39454 "EHLO swip.net"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755166AbYAER6y (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 5 Jan 2008 12:58:54 -0500
Received: from [83.177.0.77] (account mj530768@tele2.se HELO [192.168.0.64])
  by mailfe15.swip.net (CommuniGate Pro SMTP 5.1.13)
  with ESMTPA id 20569235 for linux-acpi@vger.kernel.org; Sat, 05 Jan 2008 17:58:51 +0100
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

Hello,

I'm not sure if this is the right mailing list to post DSDT problems to, but someone said acpi-devel
at sf.net and when I found that it directed here.

My problem is a broken DSDT, I have tried to fix it, but I don't know if I did it the right way, nor
how to solve the warning that remains when the errors are gone.

http://rage.kuonet.org/~anmaster/acpi/dsdt.dsl.pre-fix is the one I get when decompiling.
http://rage.kuonet.org/~anmaster/acpi/dsdt.dsl.fix is the my try at fixing it.

The errors I get with the unfixed DSDT are as below. I want to know if my fix is correct and what to
do about the remaining warning (Not all control paths return a value (STM_)).

The motherboard in question is an Asus K8V-X SE. I found a custom DSDT for "Asus K8V-X SE Delux" but
it didn't work (lock up at boot) for me.

Errors:

Intel ACPI Component Architecture
ASL Optimizing Compiler version 20060912 [Mar 15 2007]
Copyright (C) 2000 - 2006 Intel Corporation
Supports ACPI Specification Revision 3.0a

dsdt.dsl.pre-fix  2655:                 Method (STM, 0, Serialized)
Warning  1086 -                                   ^ Not all control paths return a value (STM_)

dsdt.dsl.pre-fix  2888:                 Field (WAU1, WordAcc, NoLock, Preserve)
Error    4026 -                                   ^ Access width is greater than region size

dsdt.dsl.pre-fix  2890:                     U184,   8
Error    4027 -                                ^ Access width of Field Unit extends beyond region limit

dsdt.dsl.pre-fix  2894:                 Field (U1D3, WordAcc, NoLock, Preserve)
Error    4026 -                                   ^ Access width is greater than region size

dsdt.dsl.pre-fix  2896:                     UR49,   3
Error    4027 -                                ^ Access width of Field Unit extends beyond region limit

dsdt.dsl.pre-fix  2900:                 Field (UBP1, WordAcc, NoLock, Preserve)
Error    4026 -                                   ^ Access width is greater than region size

dsdt.dsl.pre-fix  2902:                     U1PE,   1
Error    4027 -                                ^ Access width of Field Unit extends beyond region limit

dsdt.dsl.pre-fix  2927:                 Field (WAU2, WordAcc, NoLock, Preserve)
Error    4026 -                                   ^ Access width is greater than region size

dsdt.dsl.pre-fix  2929:                     U284,   8
Error    4027 -                                ^ Access width of Field Unit extends beyond region limit

dsdt.dsl.pre-fix  2933:                 Field (UBP2, WordAcc, NoLock, Preserve)
Error    4026 -                                   ^ Access width is greater than region size

dsdt.dsl.pre-fix  2935:                     U2PE,   1
Error    4027 -                                ^ Access width of Field Unit extends beyond region limit

dsdt.dsl.pre-fix  2960:                 Field (WAU3, WordAcc, NoLock, Preserve)
Error    4026 -                                   ^ Access width is greater than region size

dsdt.dsl.pre-fix  2962:                     U384,   8
Error    4027 -                                ^ Access width of Field Unit extends beyond region limit

dsdt.dsl.pre-fix  2966:                 Field (UBP3, WordAcc, NoLock, Preserve)
Error    4026 -                                   ^ Access width is greater than region size

dsdt.dsl.pre-fix  2968:                     U3PE,   1
Error    4027 -                                ^ Access width of Field Unit extends beyond region limit

dsdt.dsl.pre-fix  2993:                 Field (WAU4, WordAcc, NoLock, Preserve)
Error    4026 -                                   ^ Access width is greater than region size

dsdt.dsl.pre-fix  2995:                     U484,   8
Error    4027 -                                ^ Access width of Field Unit extends beyond region limit

dsdt.dsl.pre-fix  2999:                 Field (UBP4, WordAcc, NoLock, Preserve)
Error    4026 -                                   ^ Access width is greater than region size

dsdt.dsl.pre-fix  3001:                     U4PE,   1
Error    4027 -                                ^ Access width of Field Unit extends beyond region limit

dsdt.dsl.pre-fix  3026:                 Field (WAU5, WordAcc, NoLock, Preserve)
Error    4026 -                                   ^ Access width is greater than region size

dsdt.dsl.pre-fix  3028:                     U584,   8
Error    4027 -                                ^ Access width of Field Unit extends beyond region limit

ASL Input:  dsdt.dsl.pre-fix - 3926 lines, 127747 bytes, 1417 keywords
Compilation complete. 20 Errors, 1 Warnings, 0 Remarks, 453 Optimizations


Regards,

Arvid Norlander
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.7 (GNU/Linux)

iD8DBQFHf7dIWmK6ng/aMNkRCmk6AJ98QeMhBytllsUMh2siMqRjuDRd1gCcCMM7
nH/ijRZy5ycz1cLocb73thY=
=FlU8
-----END PGP SIGNATURE-----
