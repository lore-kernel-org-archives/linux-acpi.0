From: Sander Smeenk <ssmeenk-ntXksADE/7Pk1uMJSBkQmQ@public.gmane.org>
Subject: DSDT Fix, one question ...
Date: Thu, 27 Feb 2003 11:41:22 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030227104122.GG21631@freshdot.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi,

I'm trying to fix the DSDT on my desktop machine just to "learn" a bit
about this. I fixed all compile errors, but for one I am not sure if I
did the Right Thing (TM):

iasl tells me:
| dsdt.asl:1830: Method(STM_, 0, Serialized) {
| Warning  2019 -          ^ Not all control paths return a value (STM_)

And indeed, there is no Return() at the end of this method. So I added
'Return(TMD0)', because I saw that in other methods too. It fixes the
compile warning, but I am not sure what TMD0 is, and wether it is the
right thing to return or not.

Especially because of this if-block at the top:

| If(REGF) {
| }
| Else {
|     Return(TMD0)
| }

It seems to only return TMD0 if REGF is not set.
What is the correct way of finding out what it should return?

Or should I just return 0x00 ? :)

Thanks,
Sander.

Method-with-error:

| Method(STM_, 0, Serialized) {
|     If(REGF) {
|     }
|     Else {
|         Return(TMD0)
|     }
|     Store(0x0, GMUE)
|     Store(0x7, GMUT)
|     Store(0x0, GSUE)
|     Store(0x7, GSUT)
|     If(And(CHNF, 0x1, )) {
|         Store(Match(DerefOf(Index(TIM0, 0x3, )), MLE, DMA0, MTR, 0x0, 0x0), Local0)
|         If(LGreater(Local0, 0x6)) {
|             Store(0x6, Local0)
|         }
|         If(LOr(LEqual(\_SB_.PCI0.SBRG.D147, 0x3147), LEqual(\_SB_.PCI0.SBRG.D147, 0x3177))) {
|             Store(DerefOf(Index(DerefOf(Index(TIM0, 0x9, )), Local0, )), GMUT)
|         }
|         Else {
|             Store(DerefOf(Index(DerefOf(Index(TIM0, 0x4, )), Local0, )), GMUT)
|         }
|         Or(GMUE, 0x7, GMUE)
|     }
|     Else {
|         If(Or(LEqual(PIO0, Ones), LEqual(PIO0, 0x0), )) {
|             If(And(LLess(DMA0, Ones), LGreater(DMA0, 0x0), )) {
|                 Store(DMA0, PIO0)
|             }
|         }
|     }
|     If(And(CHNF, 0x4, )) {
|         Store(Match(DerefOf(Index(TIM0, 0x3, )), MLE, DMA1, MTR, 0x0, 0x0), Local0)
|         If(LGreater(Local0, 0x6)) {
|             Store(0x6, Local0)
|         }
|         If(LOr(LEqual(\_SB_.PCI0.SBRG.D147, 0x3147), LEqual(\_SB_.PCI0.SBRG.D147, 0x3177))) {
|             Store(DerefOf(Index(DerefOf(Index(TIM0, 0x9, )), Local0, )), GSUT)
|         }
|         Else {
|             Store(DerefOf(Index(DerefOf(Index(TIM0, 0x4, )), Local0, )), GSUT)
|         }
|         Or(GSUE, 0x7, GSUE)
|     }
|     Else {
|         If(Or(LEqual(PIO1, Ones), LEqual(PIO1, 0x0), )) {
|             If(And(LLess(DMA1, Ones), LGreater(DMA1, 0x0), )) {
|                 Store(DMA1, PIO1)
|             }
|         }
|     }
|     And(Match(DerefOf(Index(TIM0, 0x0, )), MGE, PIO0, MTR, 0x0, 0x0), 0x7, Local0)
|     Store(DerefOf(Index(DerefOf(Index(TIM0, 0x1, )), Local0, )), Local1)
|     Store(Local1, GMPT)
|     And(Match(DerefOf(Index(TIM0, 0x0, )), MGE, PIO1, MTR, 0x0, 0x0), 0x7, Local0)
|     Store(DerefOf(Index(DerefOf(Index(TIM0, 0x1, )), Local0, )), Local1)
|     Store(Local1, GSPT)
| }

-- 
| Why is the time of day with the slowest traffic called rush hour?
| 1024D/08CEC94D - 34B3 3314 B146 E13C 70C8  9BDB D463 7E41 08CE C94D


-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
