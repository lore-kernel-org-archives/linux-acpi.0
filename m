From: prozessor13acpi-nhk/dgjHjusAvxtiuMwx3w@public.gmane.org
Subject: Re: 2.4.20-pre10-ac1 and Compaq Evo N160
Date: Mon, 14 Oct 2002 10:50:56 +0000
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20021014105058.7898C2063B@mail.uboot.com>
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

i have the same notebook with the same problems.. but there is another bad thing. after a few hours the notebook hangs, the fan start to run and i have to switch it off.. :-( this problem started when i switched from 2.4.17 to 2.4.18..   do you have similar problems, or is this a hardware-problem on my notebook(bad memory, temperature...). 

...and did you found a way to switch of the LCD backlight..

thx. max.

--- antwort auf ---
von: Andrew Kohlsmith
an: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
betreff: [ACPI] 2.4.20-pre10-ac1 and Compaq Evo N160
datum: 12.10.02 15:38

I've been unable to get this machine to boot since the altirq patch for the 
0503 ACPI code.  It hangs just after trying to route IRQs.

With 2.4.20-pre10-ac1 I was able to get it to boot with pci=noacpi.  I'm going 
to go back and try it with a few of the other kernels but I just wanted to 
know if that pci=noacpi paramater tells the PCI subsystem to ignore the ACPI 
IRQ routing tables or what it does.

Regards,
Andrew


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
Acpi-devel mailing list
Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
https://lists.sourceforge.net/lists/listinfo/acpi-devel
___________________________________________________________
new: club uboot, die sms flatfee mit 200 freien sms im monat
uboot - the sms underground.   http://www.uboot.com



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
