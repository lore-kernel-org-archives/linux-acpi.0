From: Bjorn Wesen <bjorn.wesen-VrBV9hrLPhE@public.gmane.org>
Subject: fyi about wakeup problem on Acer TM630
Date: Mon, 16 Jun 2003 11:15:51 +0200 (CEST)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <Pine.LNX.4.33.0306161111480.24923-100000@godzilla.se.axis.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: ACPI mailing list <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

I noted that the travelmate freezes upon resume, but after the "Back to C!" 
printout, so apparently the kernel came back alive ok. 

After some searching, I found that it completely freezes (no magic sysrq 
etc) when running the _WAK ACPI method, and inside the _WAK method it hangs 
on calling a GPE method called _L26 which I have pasted below. OSTP is 0, I 
think, but I haven't gone that deep yet. Regardless, does anyone have a clue 
on what they are trying to do below ? OSTP is 0 or 2 for detecting Microsoft 
Windows or Microsoft WindowsME (1 or 3 for NT or XP). It seems they are 
doing something to the IDE and/or floppy controllers, but are they toggling 
power or something else ? Assuming it really is the first block which is run 
(I forced OSTP to 0 because I dont run Windows :) there is nothing that 
should freeze it except for the actual fiddling with those IDE registers..

    Method(_L26) {
        If(LOr(LEqual(OSTP, 0x0), LEqual(OSTP, 0x2))) {
            Sleep(0x03e8)
            Notify(\_SB_.PCI0.IDE_.SECN.MAST, 0x0)
            Notify(\_SB_.PCI0.IDE_.SECN.SLAV, 0x0)
            Sleep(0x64)
            Notify(\_SB_.PCI0.IDE_.SECN.MAST, 0x1)
            Notify(\_SB_.PCI0.IDE_.SECN.SLAV, 0x1)
        }
        Else {
            Acquire(\_SB_.PCI0.ISA_.EC__.MUT0, 0xffff)
            Store(0xb, \_SB_.PCI0.ISA_.EC__.DAT1)
            Store(0xc5, \_SB_.PCI0.ISA_.EC__.CMCD)
            Sleep(0x64)
            And(\_SB_.PCI0.ISA_.EC__.DAT1, 0x1, Local0)
            Store(0x1e, \_SB_.PCI0.ISA_.EC__.DAT1)
            Store(0xc5, \_SB_.PCI0.ISA_.EC__.CMCD)
            Sleep(0x64)
            And(\_SB_.PCI0.ISA_.EC__.DAT1, 0x1, Local1)
            ShiftLeft(Local1, 0x1, Local1)
            Or(Local0, Local1, Local0)
            Release(\_SB_.PCI0.ISA_.EC__.MUT0)
            Sleep(0x32)
            If(LEqual(Local0, 0x3)) {
                Store(0x0, \_SB_.PCI0.ISA_.SSIG)
                And(\_SB_.PCI0.PM__.R09D, 0xf7, \_SB_.PCI0.PM__.R09D)
            }
            If(LEqual(Local0, 0x2)) {
                Store(0x0, \_SB_.PCI0.ISA_.SSIG)
                And(\_SB_.PCI0.PM__.R09D, 0xf7, \_SB_.PCI0.PM__.R09D)
            }
            If(LEqual(Local0, 0x0)) {
                Store(0x1, \_SB_.PCI0.ISA_.SSIG)
                Or(\_SB_.PCI0.PM__.R09D, 0x8, \_SB_.PCI0.PM__.R09D)
            }
            If(LEqual(Local0, 0x1)) {
                Store(0x1, \_SB_.PCI0.ISA_.SSIG)
                Or(\_SB_.PCI0.PM__.R09D, 0x8, \_SB_.PCI0.PM__.R09D)
            }
            Sleep(0xc8)
            Notify(\_SB_.PCI0.ISA_.FDC_, 0x0)
            Notify(\_SB_.PCI0.IDE_.SECN.MAST, 0x0)
            Sleep(0xc8)
            Notify(\_SB_.PCI0.ISA_.FDC_, 0x1)
            Notify(\_SB_.PCI0.IDE_.SECN.MAST, 0x1)
        }




-------------------------------------------------------
This SF.NET email is sponsored by: eBay
Great deals on office technology -- on eBay now! Click here:
http://adfarm.mediaplex.com/ad/ck/711-11697-6916-5
