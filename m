From: Erico M Mendonca <erico-cz9lu//xMc+vYRxJAoKWRg@public.gmane.org>
Subject: Re: Toshiba Satellite 1905S303 DSDT table
Date: Tue, 04 Nov 2003 10:57:08 -0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3FA7A224.1080907@techisa.srv.br>
References: <3FA58FE8.4000409@techisa.srv.br> <20031104103943.GJ21970@poupinou.org>
Reply-To: erico-cz9lu//xMc+vYRxJAoKWRg@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20031104103943.GJ21970-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
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

Ducrot Bruno wrote:

>On Sun, Nov 02, 2003 at 09:14:48PM -0200, Erico M Mendonca wrote:
>  
>
>>I'm currently trying to debug the DSDT table of this aforementioned 
>>machine, and managed to clear all the errors, except for this one:
>>=================
>>Intel ACPI Component Architecture
>>ASL Optimizing Compiler / AML Disassembler version 20030918 [Sep 18 2003]
>>Copyright (C) 2000 - 2003 Intel Corporation
>>Supports ACPI Specification Revision 2.0b
>>
>>s303.asl   468:                 If(\_OSI) {
>>Error    1028 -      Too few arguments ^  (\_OSI requires 1)
>>
>>s303.asl   469:                     "Windows 2001"
>>Error    1037 -                                  ^ parse error, 
>>unexpected PARSEOP_STRING_LITERAL
>>
>>ASL Input:  s303.asl - 2871 lines, 112889 bytes, 2084 keywords
>>Compilation complete. 2 Errors, 0 Warnings, 0 Remarks, 538 Optimizations
>>==============
>>
>>    
>>
>
>FYI I have debugged a *lot* of similar models.  What is the
>problem you encounter for that one?
>
>
>  
>
I solved this by changing it to a simple

               If(\_OSI ("Windows 2001")) 

as suggested by Martin earlier.

Anyway, I got the ACPI working fine for most functions, except:
- processor: no throttling (Pentium 4), but that may be out of the scope 
of ACPI(?)

processor id:            0
acpi id:                 0
bus mastering control:   no
power management:        yes
throttling control:      no
performance management:  no
limit interface:         no


- fan control/reporting
- thermal_zone and power_resource


The lid and power buttons are generating events after recompiling the DSDT table (they didn't before). Proper IRQ routing, battery and ac_adapter worked before.


As for the Fn-keys:

Fn-ESC (mute): doesn't work
Fn-F1 (screen lock): doesn't work
Fn-F2 (power toggle): doesn't work
Fn-F3 (suspend to RAM): doesn't work
Fn-F4 (hibernate): doesn't work
Fn-F5 (video switch): hangs the machine (read below)
Fn-F6/F7 (brightness): works
Fn-F8 (wireless toggle): works
Fn-F9 (touchpad toggle): works
Fn-F10/F11/F12: well, they should work anyway :)

I know some of these can be mapped to generate key events and call 
specific user programs. The one big problem I'm having now is with Fn-F5 
(video switch). With an older kernel version (2.4.20) it worked 
flawlessly, but with 2.4.22 (from Mandrake 9.2) it hangs the machine 
solid. I tried setting a serial console to check out any oops/kernel 
panic messages, even tried KDB, but alas, this machine doesn't have a 
serial port.

I searched around and found out that there's an USB serial console 
patch, but for kernel 2.5+.

I'm just beginning with ACPI, so if you have any suggestions on this, 
I'd be glad to hear. I'm still reading the 500+ page tome of the ACPI 
spec... :)

-- 

-- Erico Mendonca
Techisa do Brasil





-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?   SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
