From: Stian Jordet <liste-NI9zH3lwcMKHXe+LvDLADg@public.gmane.org>
Subject: RE: ACPI patches updated (20021111)
Date: 14 Nov 2002 19:00:44 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1037296844.2450.5.camel@chevrolet.hybel>
References: <EDC461A30AC4D511ADE10002A5072CAD04C7A502@orsmsx119.jf.intel.com>
	 <1037230113.908.3.camel@chevrolet.hybel>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1037230113.908.3.camel-rd0e0RNjLLRX8BKYUJ5quQ@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

I did ofcourse mean that this does _not_ seem to be the problem without
me forcing usb to use irq 5, but perhaps the problem then is that acpi
and usb use the same irq? Is acpi not supposed to share irq with
anything?

Regards,
Stian Jordet

tor, 2002-11-14 kl. 00:28 skrev Stian Jordet:
> ons, 2002-11-13 kl. 22:30 skrev Grover, Andrew:
> > > From: Stian Jordet [mailto:liste-NI9zH3lwcMKHXe+LvDLADg@public.gmane.org] 
> > 
> > with acpi:
> > >   5:     269867     266825    IO-APIC-edge  usb-uhci, 
> > > usb-uhci, usb-uhci
> > 
> > without acpi:
> > >   5:        893        757   IO-APIC-level  Ricoh Co Ltd RL5c476 II
> > > (#2), usb-uhci, usb-uhci, usb-uhci, eth0, ide2
> > 
> > Well, here's the problem. IRQ 5 should be IO-APIC-level.
> > 
> > We are supposedly setting irqs used by PCI to level, but apparently not in
> > your case. Interesting.
> > 
> > Regards -- Andy
> 
> That seems to be the problem without me forcing usb to irq 5 as well.
> I set all irq-routing to auto (and it still works perfect without acpi),
> and get these results:
> 
> stianj@chevrolet:~$ cat /root/interrupts-acpi 
>            CPU0       CPU1       
>   0:       8587      21835    IO-APIC-edge  timer
>   1:         51         81    IO-APIC-edge  keyboard
>   2:          0          0          XT-PIC  cascade
>   3:          0          2    IO-APIC-edge  serial
>   8:          1          2    IO-APIC-edge  rtc
>   9:         93        113   IO-APIC-level  acpi, usb-uhci, usb-uhci, usb-uhci
>  14:         16         12    IO-APIC-edge  ide0
>  15:         10          7    IO-APIC-edge  ide1
>  17:       1123       1104   IO-APIC-level  aic7xxx, EMU10K1
>  18:         34         36   IO-APIC-level  aic7xxx, Ricoh Co Ltd RL5c476 II
>  19:         92         81   IO-APIC-level  Ricoh Co Ltd RL5c476 II (#2), eth0,   
> ide2
> NMI:          0          0 
> LOC:      30342      30339 
> ERR:          0
> MIS:          0
> stianj@chevrolet:~$ cat /root/interrupts-no-acpi 
>            CPU0       CPU1       
>   0:       3463       4239    IO-APIC-edge  timer
>   1:         57         28    IO-APIC-edge  keyboard
>   2:          0          0          XT-PIC  cascade
>   3:          2          0    IO-APIC-edge  serial
>   5:         32         38   IO-APIC-level  aic7xxx, Ricoh Co Ltd RL5c476 II
>   8:          2          1    IO-APIC-edge  rtc
>   9:         67         72   IO-APIC-level  Ricoh Co Ltd RL5c476 II (#2), usb-uhci, usb-uhci, usb-uhci, eth0, ide2            
>  10:       1103       1094   IO-APIC-level  aic7xxx, EMU10K1
>  14:         13         15    IO-APIC-edge  ide0
>  15:          7         10    IO-APIC-edge  ide1
> NMI:          0          0      
> LOC:       7618       7617      
> ERR:          0                 
> MIS:          0                 
> 
> 
> But do you think you will find a solution to this? Or is this something I have to learn to live with?
> 
> Best regards,
> Stian Jordet
> 
> 
> 
> 
> 
> -------------------------------------------------------
> This sf.net email is sponsored by: Are you worried about 
> your web server security? Click here for a FREE Thawte 
> Apache SSL Guide and answer your Apache SSL security 
> needs: http://www.gothawte.com/rd523.html
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/acpi-devel




-------------------------------------------------------
This sf.net email is sponsored by: To learn the basics of securing 
your web site with SSL, click here to get a FREE TRIAL of a Thawte 
Server Certificate: http://www.gothawte.com/rd524.html
