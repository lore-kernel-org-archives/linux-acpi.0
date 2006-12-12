From: "Lincoln Baxter, III" <lincolnbaxter@gmail.com>
Subject: HP nc6400 v.03 or v.05 laptop ACPI fails after reboot, works again
 after booting windows
Date: Tue, 12 Dec 2006 18:14:08 -0500
Message-ID: <457F37C0.3090003@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.229]:46933 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964817AbWLLXOK (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 12 Dec 2006 18:14:10 -0500
Received: by wx-out-0506.google.com with SMTP id h27so2022954wxd
        for <linux-acpi@vger.kernel.org>; Tue, 12 Dec 2006 15:14:10 -0800 (PST)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hi everyone, I recently tried to install gentoo linux on my HP nc6400 
laptop, and everything works fine except for the following issues.

   This may be related to:
   http://marc.theaimsgroup.com/?l=linux-acpi&m=115583434909936&w=2

Here are the problems:
  1. After booting gentoo, when I reboot, I can no longer enter the BIOS 
setup screen by pressing F10.
  2. After booting gentoo, when I reboot, the ACPI battery file does not 
update the power status / events.

Here's how they happen:
  1. Boot windows: everything works fine.
  2. Reboot from windows: I can get into setup by pressing F10.
  3. Boot Gentoo after having booted windows first: power status meter 
works, files are updated, etc.
  4. Reboot into Gentoo: I can no longer enter setup via F10.
  5. Reboot into windows: Everything works again. On next bootup, F10 
works fine.

Sometimes the keyboard will refuse to work until the system has booted 
into the OS.
(This doesn't seem to consistently occur.)

Any ideas on how to go about fixing this?

My DSDT generates the following errors on compiling:

------------------------------------------------------------------------------------------------------
Intel ACPI Component Architecture
ASL Optimizing Compiler version 20060912 [Dec 11 2006]
Copyright (C) 2000 - 2006 Intel Corporation
Supports ACPI Specification Revision 3.0a

dsdt.dsl  3275:                                         And (Local1, 0xFFFF)
Warning  1104 -        Result is not used, operator has no effect ^

dsdt.dsl  4672:                     Method (_DSM, 4, NotSerialized)
Warning  1086 -                                ^ Not all control paths 
return a value (_DSM)

dsdt.dsl  4672:                     Method (_DSM, 4, NotSerialized)
Warning  1079 -                                ^ Reserved method must 
return a value (_DSM)

dsdt.dsl 12767:                 CreateByteField (C1D3, 
\_SB.C002.C003._Y0F._LEN, C08F)
Error    4062 -                                         Object does not 
exist ^  (\_SB.C002.C003._Y0F._LEN)

ASL Input:  dsdt.dsl - 13280 lines, 491767 bytes, 6207 keywords
Compilation complete. 1 Errors, 3 Warnings, 0 Remarks, 2052 Optimizations

