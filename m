From: Stian Jordet <liste-NI9zH3lwcMKHXe+LvDLADg@public.gmane.org>
Subject: RE: ACPI patches updated (20021111)
Date: 19 Nov 2002 00:47:10 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1037663229.4398.1.camel@chevrolet.hybel>
References: <EDC461A30AC4D511ADE10002A5072CAD04C7A50A@orsmsx119.jf.intel.com>
	 <1037303944.3311.3.camel@chevrolet.hybel>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1037303944.3311.3.camel-rd0e0RNjLLRX8BKYUJ5quQ@public.gmane.org>
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

Just to let you know, this problem does not exist with usb-printers,
they work perfect with acpi. But keyboard and mouse will only work with
acpi turned off (!).

Regards,
Stian Jordet


tor, 2002-11-14 kl. 20:59 skrev Stian Jordet:
> In my motherboard user-guide, it says that usb shares irq with pci-slot
> 1 and 5. In the Bios I can change irq on slot 1/5 from auto to 5 (or
> whatever). USB works fine whatever setting I'm using (auto or some irq),
> as long as I'm not using acpi. With acpi everything BUT usb works
> perfect. Hope this helps.
> 
> Regards,
> Stian
> 
> 
> tor, 2002-11-14 kl. 19:55 skrev Grover, Andrew:
> > > From: Stian Jordet [mailto:liste-NI9zH3lwcMKHXe+LvDLADg@public.gmane.org] 
> > > I did ofcourse mean that this does _not_ seem to be the 
> > > problem without
> > > me forcing usb to use irq 5, but perhaps the problem then is that acpi
> > > and usb use the same irq? Is acpi not supposed to share irq with
> > > anything?
> > 
> > Wait, you're saying you are somehow *forcing* USB to IRQ 5? Via what method?
> > 
> > The ACPI interrupt can share its interrupt, no problem. Are you experiencing
> > problems when ACPI and usb share irq 9?
> > 
> > Regards -- Andy
> > 
> > > 
> > > Regards,
> > > Stian Jordet
> > > 
> > > tor, 2002-11-14 kl. 00:28 skrev Stian Jordet:
> > > > ons, 2002-11-13 kl. 22:30 skrev Grover, Andrew:
> > > > > > From: Stian Jordet [mailto:liste-NI9zH3lwcMKHXe+LvDLADg@public.gmane.org] 
> > > > > 
> > > > > with acpi:
> > > > > >   5:     269867     266825    IO-APIC-edge  usb-uhci, 
> > > > > > usb-uhci, usb-uhci
> > > > > 
> > > > > without acpi:
> > > > > >   5:        893        757   IO-APIC-level  Ricoh Co 
> > > Ltd RL5c476 II
> > > > > > (#2), usb-uhci, usb-uhci, usb-uhci, eth0, ide2
> > > > > 
> > > > > Well, here's the problem. IRQ 5 should be IO-APIC-level.
> > > > > 
> > > > > We are supposedly setting irqs used by PCI to level, but 
> > > apparently not in
> > > > > your case. Interesting.
> > > > > 
> > > > > Regards -- Andy
> > > > 
> > > > That seems to be the problem without me forcing usb to irq 
> > > 5 as well.
> > > > I set all irq-routing to auto (and it still works perfect 
> > > without acpi),
> > > > and get these results:
> > > > 
> > > > stianj@chevrolet:~$ cat /root/interrupts-acpi 
> > > >            CPU0       CPU1       
> > > >   0:       8587      21835    IO-APIC-edge  timer
> > > >   1:         51         81    IO-APIC-edge  keyboard
> > > >   2:          0          0          XT-PIC  cascade
> > > >   3:          0          2    IO-APIC-edge  serial
> > > >   8:          1          2    IO-APIC-edge  rtc
> > > >   9:         93        113   IO-APIC-level  acpi, usb-uhci, 
> > > usb-uhci, usb-uhci
> > > >  14:         16         12    IO-APIC-edge  ide0
> > > >  15:         10          7    IO-APIC-edge  ide1
> > > >  17:       1123       1104   IO-APIC-level  aic7xxx, EMU10K1
> > > >  18:         34         36   IO-APIC-level  aic7xxx, Ricoh 
> > > Co Ltd RL5c476 II
> > > >  19:         92         81   IO-APIC-level  Ricoh Co Ltd 
> > > RL5c476 II (#2), eth0,   
> > > > ide2
> > > > NMI:          0          0 
> > > > LOC:      30342      30339 
> > > > ERR:          0
> > > > MIS:          0
> > > > stianj@chevrolet:~$ cat /root/interrupts-no-acpi 
> > > >            CPU0       CPU1       
> > > >   0:       3463       4239    IO-APIC-edge  timer
> > > >   1:         57         28    IO-APIC-edge  keyboard
> > > >   2:          0          0          XT-PIC  cascade
> > > >   3:          2          0    IO-APIC-edge  serial
> > > >   5:         32         38   IO-APIC-level  aic7xxx, Ricoh 
> > > Co Ltd RL5c476 II
> > > >   8:          2          1    IO-APIC-edge  rtc
> > > >   9:         67         72   IO-APIC-level  Ricoh Co Ltd 
> > > RL5c476 II (#2), usb-uhci, usb-uhci, usb-uhci, eth0, ide2            
> > > >  10:       1103       1094   IO-APIC-level  aic7xxx, EMU10K1
> > > >  14:         13         15    IO-APIC-edge  ide0
> > > >  15:          7         10    IO-APIC-edge  ide1
> > > > NMI:          0          0      
> > > > LOC:       7618       7617      
> > > > ERR:          0                 
> > > > MIS:          0                 
> > > > 
> > > > 
> > > > But do you think you will find a solution to this? Or is 
> > > this something I have to learn to live with?
> 
> 
> 
> -------------------------------------------------------
> This sf.net email is sponsored by: To learn the basics of securing 
> your web site with SSL, click here to get a FREE TRIAL of a Thawte 
> Server Certificate: http://www.gothawte.com/rd524.html
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/acpi-devel



-------------------------------------------------------
This sf.net email is sponsored by: To learn the basics of securing 
your web site with SSL, click here to get a FREE TRIAL of a Thawte 
Server Certificate: http://www.gothawte.com/rd524.html
