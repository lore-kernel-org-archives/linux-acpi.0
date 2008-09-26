From: Zhao Yakui <yakui.zhao@intel.com>
Subject: Re: Syntax errors in SSDT1 table of HP 2510p laptop
Date: Fri, 26 Sep 2008 11:44:02 +0800
Message-ID: <1222400642.4023.187.camel@yakui_zhao.sh.intel.com>
References: <200809251119.48907.elendil@planet.nl>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:19023 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752542AbYIZDjQ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 25 Sep 2008 23:39:16 -0400
In-Reply-To: <200809251119.48907.elendil@planet.nl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Frans Pop <elendil@planet.nl>
Cc: linux-acpi@vger.kernel.org

On Thu, 2008-09-25 at 11:19 +0200, Frans Pop wrote:
> Hi,
> 
Will you please try the latest kernel (2.6.27-rc6) and see whether the
problem still exists?
   It seems that the problem is fixed by the following commit:
   commit 48feb3c419508487becfb9ea3afcc54c3eac6d80
Author: Shaohua Li <shaohua.li@intel.com>
Date:   Tue Mar 25 16:50:45 2008 +0800

    ata-acpi: don't call _GTF for disabled drive

Thanks.
> I'm having problems with resume from suspend with this laptop. A lot of
> the time it resumes perfectly, but sometimes it fails early.
> 
> During good resumes I see the following in my log:
> ACPI Exception (exoparg2-0444): AE_AML_PACKAGE_LIMIT,
>    Index (000000005) is beyond end of object [20080609]
> ACPI Error (psparse-0530): Method parse/execution failed [\_SB_.C2C3]
>    (Node ffff88007e335e80), AE_AML_PACKAGE_LIMIT
> ACPI Error (psparse-0530): Method parse/execution failed [\_SB_.C003.C0F6.C3F3._STM]
>    (Node ffff88007e33bdc0), AE_AML_PACKAGE_LIMIT
> ata1: ACPI set timing mode failed (status=0x300d)
> 
> I have disassembled the ACPI tables using 'iasl' and found five obvious
> syntax errors in the SSDT1 table (dump attached), of which one is in the
> _GTM and two are in the _STM method. So that looks like an obvious cause.
> I'm wondering if this could explain the resume problems.
> 
> If you cannot help me I'd appreciate some suggestions where to take this.
> 
> 
> The first error looks like it may be a fairly simple fix:
> @@ -64,8 +64,7 @@
>                  CreateDWordField (Local0, 0x0C, C3F9)
>                  CreateDWordField (Local0, 0x10, C3FA)
>                  Store (C0FE (0x00, 0x00), C3F6)
> -                Store (C101, 0x00)
> -                C3FA
> +                Store (C101 (0x00), C3FA)
>                  If (And (C3FA, 0x01))
>                  {
>                      Store (C100 (0x00, 0x00), C3F7)
> 
> Or should that instead be
> +                Store (C101 (0x00, 0x00), C3FA)
> ?
> 
> 
> The next two I can't make anything of. They are very similar.
> In the disassembly the first looks like:
> <snip>
>                 If (LEqual (SizeOf (Arg1), 0x0200))
>                 {
>                     Store (0x00, Local0)
>                     Store (Buffer (Multiply (SizeOf (C2C2), 0x02)) {}, Local1)
>                     While (LLess (Local0, SizeOf (C2C2)))
>                     {
>                         Store (DerefOf (Index (C2C2, Local0)), Local2)
>                         Multiply (Local2, 0x02, Local2)
>                         Multiply (Local0, 0x02, Local3)
>                         Store (DerefOf (Index (Arg1, Local2)), Index (Local1, Local3))
>                         Store (DerefOf (Index (Arg1, Add (Local2, 0x01))), Index (
>                             Local1, Add (Local3, 0x01)))
>                         Increment (Local0)
>                     }
> 
>                     Store (C102 (0x00, 0x00, C3F6, C3FA, Local1), Local2)
>                     Store (C106 (0x00, 0x00, C3F7, C3FA, Local1, Local3), \_SB.C2C3)
>                     Local2
>                     Local3
>                     Local1
>                     C3F4
>                 }
> </snip>
> 
> The last 4 lines are obviously bogus. Does anyone here have a clue what
> could be intended here?
> 
> 
> The last two errors are in the _GTF method for two devices, again similar.
> The first of those looks as follows:
> <snip>
>             Device (C3FB)
>             {
>                 Name (_ADR, 0x00)
>                 Method (_GTF, 0, NotSerialized)
>                 {
>                     Return (\_SB.C2CA)
>                     C3F4
>                     0x00
>                 }
>             }
> </snip>
> 
> 
> Cheers and TIA,
> FJP
> 
> P.S. There's also a warning from the DSDT table, but that looks relatively
> harmless:
> dsdt.dsl  9155:                         Wait (\_SB.C1AD, 0x10)
> Warning  1103 -        Possible operator timeout is ignored ^
> 
> Can that be ignored or should I follow up on that too?

