From: dev_zero <dev_xor-eZNTXLQAfP4@public.gmane.org>
Subject: RE: kacpid problems
Date: Wed, 10 Nov 2004 17:14:25 +0100 (CET)
Message-ID: <20041110161425.45149.qmail@web25303.mail.ukl.yahoo.com>
References: <3ACA40606221794F80A5670F0AF15F84041AC04B@pdsmsx403>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <3ACA40606221794F80A5670F0AF15F84041AC04B@pdsmsx403>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

<snip>
Scheduling function [ce855c48(cd245400)] for deferred
execution.
Scheduling function [ce855c48(cd245400)] for deferred
execution.
Scheduling function [ce855c48(cd245400)] for deferred
execution.
Scheduling function [ce855c48(cd245400)] for deferred
execution.
Scheduling function [ce855c48(cd245400)] for deferred
execution.
Scheduling function [c01a7377(c11ff3fc)] for deferred
execution.
Scheduling function [c01a5813(cddd0b28)] for deferred
execution.
Scheduling function [ce855c48(cd245400)] for deferred
execution.
Scheduling function [ce855c48(cd245400)] for deferred
execution.
Scheduling function [ce855c48(cd245400)] for deferred
execution.
Scheduling function [ce855c48(cd245400)] for deferred
execution.
Scheduling function [ce855c48(cd245400)] for deferred
execution.
Scheduling function [ce855c48(cd245400)] for deferred
execution.
Scheduling function [ce855c48(cd245400)] for deferred
execution.
Scheduling function [ce855c48(cd245400)] for deferred
execution.

</snip

 --- "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> wrote: 
> It can be shown on your screen or from dmesg.
> 
> Thanks
> Luming 
> 
> >-----Original Message-----
> >From: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org 
> >[mailto:acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org] On
> Behalf Of dev_zero
> >Sent: 2004年11月11日 0:06
> >To: Yu, Luming
> >Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> >Subject: RE: [ACPI] kacpid problems
> >
> >Where should I look for the output? In
> >/var/log/messages?
> > --- "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> wrote: 
> >> Hmm, odd!
> >> Please apply following debug patch to see what
> could
> >> happen on your screen.
> >> 
> >> 
> >> --- edited/drivers/acpi/osl.c.0 2004-11-10
> >> 23:36:17.000000000 +0800
> >> +++ edited/drivers/acpi/osl.c   2004-11-10
> >> 23:38:56.000000000 +0800
> >> @@ -676,7 +676,7 @@
> >> 
> >>         ACPI_FUNCTION_TRACE
> >> ("os_queue_for_execution");
> >> 
> >> -       ACPI_DEBUG_PRINT ((ACPI_DB_EXEC,
> "Scheduling
> >> function [%p(%p)] for deferred execution.\n",
> >> function, context));
> >> +       printk( "Scheduling function [%p(%p)] for
> >> deferred execution.\n", function, context);
> >> 
> >>         if (!function)
> >>                 return_ACPI_STATUS
> >> (AE_BAD_PARAMETER);
> >> 
> >> Thanks
> >> Luming 
> >> 
> >> >-----Original Message-----
> >> >From: dev_zero [mailto:dev_xor-eZNTXLQAfP4@public.gmane.org] 
> >> >Sent: 2004å¹´11æœˆ10æ—¥ 22:50
> >> >To: Yu, Luming
> >> >Subject: RE: [ACPI] kacpid problems
> >> >
> >> >           CPU0       
> >> >  0:    4670319          XT-PIC  timer
> >> >  1:       5178          XT-PIC  i8042
> >> >  2:          0          XT-PIC  cascade
> >> >  5:     115597          XT-PIC  eth0, ehci_hcd,
> >> >ohci_hcd, ohci_hcd, ohci_hcd, SiS 7012
> >> >  8:          1          XT-PIC  rtc
> >> > 10:          2          XT-PIC  ohci1394
> >> > 11:          6          XT-PIC  acpi
> >> > 12:        165          XT-PIC  i8042
> >> > 14:       6113          XT-PIC  ide0
> >> > 15:          0          XT-PIC  ide1
> >> >NMI:          0 
> >> >LOC:          0 
> >> >ERR:          0
> >> >MIS:          0
> >> >
> >> >
> >> > --- "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> skrev: 
> >> >> 
> >> >> I want this info when kacpid runing with 99%
> CPU
> >> >> time.
> >> >> 
> >> >> Thanks
> >> >> Luming 
> >> >> 
> >> >> >-----Original Message-----
> >> >> >From: dev_zero [mailto:dev_xor-eZNTXLQAfP4@public.gmane.org] 
> >> >> >Sent:
> 2004Ã¥Â¹Â´11Ã¦Å“Ë� 10Ã¦â€”Â¥
> 22:36
> >> >> >To: Yu, Luming;
> acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> >> >> >Subject: RE: [ACPI] kacpid problems
> >> >> >
> >> >> >           CPU0       
> >> >> >  0:    4079948          XT-PIC  timer
> >> >> >  1:       3550          XT-PIC  i8042
> >> >> >  2:          0          XT-PIC  cascade
> >> >> >  5:      97944          XT-PIC  eth0,
> ehci_hcd,
> >> >> >ohci_hcd, ohci_hcd, ohci_hcd, SiS SI7012
> >> >> >  8:          1          XT-PIC  rtc
> >> >> > 10:          2          XT-PIC  ohci1394
> >> >> > 11:          5          XT-PIC  acpi
> >> >> > 12:        165          XT-PIC  i8042
> >> >> > 14:       5380          XT-PIC  ide0
> >> >> > 15:          0          XT-PIC  ide1
> >> >> >NMI:          0 
> >> >> >LOC:          0 
> >> >> >ERR:          0
> >> >> >MIS:          0
> >> >> >
> >> >> >
> >> >> >btw did you find anything weird in my DSDT?
> >> >> > --- "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> wrote: 
> >> >> >> Hmm... would you please cat
> /proc/interrupts
> >> to
> >> >> me.
> >> >> >> 
> >> >> >> Thanks
> >> >> >> Luming 
> >> >> >> 
> >> >> >> >-----Original Message-----
> >> >> >> >From: dev_zero [mailto:dev_xor-eZNTXLQAfP4@public.gmane.org] 
> >> >> >> >Sent:
> >>
>
2004ÃƒÂ¥Ã‚Â¹Ã‚Â´11ÃƒÂ¦Ã…â€œÃ‹â€
> 10ÃƒÂ¦Ã¢â‚¬â€Ã‚Â¥
> >> 21:34
> >> >> >> >To: Yu, Luming
> >> >> >> >Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> >> >> >> >Subject: RE: [ACPI] kacpid problems
> >> >> >> >
> >> >> >> >kacpid still runns with 99%cpu usage when
> the
> >> >> cpu
> >> >> >> gets
> >> >> >> >too hot. I tried the game quake 2. You can
> >> play
> >> >> >> around
> >> >> >> >10 -15 minutes before the kacpid starts
> >> running
> >> >> on
> >> >> >> 99%
> >> >> >> >cpu usage. I also used quake 2 too test
> the
> >> >> kernel
> >> >> >> >before I applied your patch.
> >> >> >> >
> >> >> >> > --- "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> >> wrote: 
> >> >> >> >> It means there was NO event generated at
> >> that
> >> >> >> time.
> >> >> >> >> Do you think the symptom is gone with my
> >> debug
> >> >> >> >> patch?
> >> >> >> >> If so, I think your box need a more sane
> >> >> schedule
> >> >> >> >> for acpi_thermal_check 
> >> >> >> >> And, I can come up with a patch.
> >> >> >> >> 
> >> >> >> >> Thanks
> >> >> >> >> Luming 
> >> >> >> >> 
> >> >> >> >> >-----Original Message-----
> >> >> >> >> >From: dev_zero
> [mailto:dev_xor-eZNTXLQAfP4@public.gmane.org] 
> >> >> >> >> >Sent:
> >> >>
> >>
>
>2004ÃƒÆ’Ã‚Â¥Ãƒâ€šÃ‚Â¹Ãƒâ€šÃ‚Â´11ÃƒÆ’Ã‚Â¦Ãƒâ€¦Ã¢â‚¬Å“Ãƒâ€¹Ã¢â‚¬
> >>
>
10ÃƒÆ’Ã‚Â¦ÃƒÂ¢Ã¢â€šÂ¬Ã¢â‚¬ÂÃƒâ€šÃ‚Â¥
> >> >> 1:06
> >> >> >> >> >To: Yu, Luming
> >> >> >> >> >Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> >> >> >> >> >Subject: RE: [ACPI] kacpid problems
> >> >> >> >> >
> >> >> >> >> >When I try to output the event file I
> do
> >> >> this:
> >> >> >> >> >[root@balder: /proc/acpi]# cat event >
> >> >> >> >> /home/event.log
> >> >> >> >> >
> >> >> >> >> >But then It just stands there without
> >> doing
> >> >> >> >> anything.
> >> >> >> >> >So i tried to check what was wrong (ps
> ax)
> >> >> >> command:
> >> >> >> >> >2922 pts/0    S+     0:00 cat event
> >> >> >> >> >
> >> >> >> >> >I don't know if it is supposed to be
> >> >> suspended?
> >> >> >> >> >> I want to know what kind of events
> could
> >> be
> >> >> >> >> >> generated heavily, which could have
> >> >> >> corresponding
> >> >> >> >> >> pending execution of AML method
> issued
> >> to
> >> >> work
> >> >> >> >> queue
> 
=== message truncated === 


-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
