From: Stian Jordet <liste-NI9zH3lwcMKHXe+LvDLADg@public.gmane.org>
Subject: RE: ACPI and USB
Date: 09 Nov 2002 23:16:59 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1036880220.716.9.camel@chevrolet>
References: <EDC461A30AC4D511ADE10002A5072CAD04C7A4D6@orsmsx119.jf.intel.com>
	<1036778040.746.5.camel@chevrolet>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1036778040.746.5.camel-rd0e0RNjLLReoWH0uzbU5w@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Stian Jordet <liste-NI9zH3lwcMKHXe+LvDLADg@public.gmane.org>
Cc: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

After some fiddling around, I did find a way to change the usb-irq, but
usb still didn't work with the acpi patch enabled. This is a problem I
somehow don't think is an acpi-bug. Since everything else works fine
with acpi, I think it must be the usb code that is buggy. Especially
since it does not work with MPS set to version 1.4.

Oh well.

Best regards,
Stian Jordet



fre, 2002-11-08 kl. 18:53 skrev Stian Jordet:
> fre, 2002-11-08 kl. 18:38 skrev Grover, Andrew:
> > > From: Stian Jordet [mailto:liste-NI9zH3lwcMKHXe+LvDLADg@public.gmane.org] 
> > > I sent a mail a couple of days ago without any response. I guess that
> > > could be because it was so long, so here's an easy one:
> > > 
> > > USB don't work with my computer with acpi enabled. I have an ASUS
> > > CUV266-DLS motherboard.
> > > 
> > > Any hope this can be resolved?
> > 
> > An easy one, is it? Ah, that's nice to know. ;)
> Hehe, I meant that the mail/question was easy, not the answer :) I think
> that is a tough one :(
> 
> Without ACPI: 
> 
> stianj@chevrolet:~$ cat /proc/interrupts 
>            CPU0       CPU1       
>   0:      25053      27013    IO-APIC-edge  timer 
>   1:          1          3    IO-APIC-edge  keyboard 
>   2:          0          0          XT-PIC  cascade 
>   3:          1          1    IO-APIC-edge  serial 
>   5:       2040       2055   IO-APIC-level  Ricoh Co Ltd RL5c476 II
> (#2), usb-uhci, usb-uhci, usb-uhci, eth0 
>   8:          2          1    IO-APIC-edge  rtc 
> 10:       5702       5630   IO-APIC-level  aic7xxx, EMU10K1 
> 12:         70         69   IO-APIC-level  aic7xxx, Ricoh Co Ltd RL5c476
> II, ide2 
> 14:        524        157    IO-APIC-edge  ide0 
> 15:        140        665    IO-APIC-edge  ide1 
> NMI:          0          0      
> LOC:      51990      51989 
> ERR:          0 
> MIS:          0 
> 
> With ACPI:
> stianj@chevrolet:~$ cat /proc/interrupts
>            CPU0       CPU1       
>   0:       3163       4154    IO-APIC-edge  timer
>   1:         57         68    IO-APIC-edge  keyboard
>   2:          0          0          XT-PIC  cascade
>   3:          1          1    IO-APIC-edge  serial
>   8:          1          2    IO-APIC-edge  rtc
>   9:         97        102   IO-APIC-level  acpi, usb-uhci, usb-uhci,
> usb-uhci
>  12:        155        146    IO-APIC-edge  PS/2 Mouse
>  14:         17         11    IO-APIC-edge  ide0
>  15:          9          8    IO-APIC-edge  ide1
>  17:       3049       3108   IO-APIC-level  aic7xxx, EMU10K1
>  18:         64         75   IO-APIC-level  aic7xxx, Ricoh Co Ltd
> RL5c476 II, ide2
>  19:        102         97   IO-APIC-level  Ricoh Co Ltd RL5c476 II
> (#2), eth0
> NMI:          0          0 
> LOC:       7233       7231 
> ERR:          0
> 
> So they do share interrupts, but I don't see any settings in my bios to
> be able to change neither irq.. Both these boots are with MPS1.1, btw.
> With MPS1.4 USB doesn't work with or without acpi.
> 
> Thanks for the fast reply :)
> 
> /me happy
> 
> Best regards,
> Stian Jordet





-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
