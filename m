From: Erico M Mendonca <erico-cz9lu//xMc+vYRxJAoKWRg@public.gmane.org>
Subject: Re: Toshiba Satellite 1905S303 DSDT table
Date: Mon, 03 Nov 2003 11:27:21 -0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3FA657B9.5070204@techisa.srv.br>
References: <3FA58FE8.4000409@techisa.srv.br> <20031103101315.GA2100@deprecation.cyrius.com>
Reply-To: erico-cz9lu//xMc+vYRxJAoKWRg@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20031103101315.GA2100-u+sgIaa8TU6A7rR/f+Zz5kHK5LHFu9C3@public.gmane.org>
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

Martin Michlmayr wrote:

>* Erico M Mendonca <erico-cz9lu//xMc+vYRxJAoKWRg@public.gmane.org> [2003-11-02 21:14]:
>  
>
>>machine, and managed to clear all the errors, except for this one:
>>    
>>
>
>  
>
>>s303.asl   468:                 If(\_OSI) {
>>Error    1028 -      Too few arguments ^  (\_OSI requires 1)
>>s303.asl   469:                     "Windows 2001"
>>Error    1037 -                                  ^ parse error, 
>>    
>>
>
>I managed to fix this error with the following change:
>
>--- dsdt.asl.orig	2003-10-25 18:43:53.000000000 +1000
>+++ dsdt.asl	2003-10-25 18:47:02.000000000 +1000
>@@ -144,8 +144,7 @@
>         }
>         If(LOr(LEqual(C006, 0x0), LEqual(C006, 0x3))) {
>             If(CondRefOf(\_OSI, Local0)) {
>-                If(\_OSI) {
>-                    "Windows 2001"
>+                If(\_OSI ("Windows 2001")) {
>                     Store(0x4, C006)
>                 }
>             }
>
>This is basically in line with some other DSDTs I've seen on the net.
>  
>

Yesterday I did the same thing :)

Anyway, it did compile ok, I recompiled the kernel and added the fixed 
DSDT table. It worked quite nice, I now also have the power button 
generating the shutdown event.

I still have the fn-F5 panic though. I compiled the kernel with kdb and 
tried to redirect it to the serial console, but alas, this machine does 
not have a serial port, and as far as I have researched, support for USB 
serial adapters as console is available only on kernel 2.5+.

-- 

-- Erico Mendonca
Techisa do Brasil





-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?   SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
