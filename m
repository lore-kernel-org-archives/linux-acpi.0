From: dev_zero <dev_xor-eZNTXLQAfP4@public.gmane.org>
Subject: RE: kacpid problems
Date: Wed, 10 Nov 2004 15:35:37 +0100 (CET)
Message-ID: <20041110143537.93721.qmail@web25307.mail.ukl.yahoo.com>
References: <3ACA40606221794F80A5670F0AF15F84041AC047@pdsmsx403>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <3ACA40606221794F80A5670F0AF15F84041AC047@pdsmsx403>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

           CPU0       
  0:    4079948          XT-PIC  timer
  1:       3550          XT-PIC  i8042
  2:          0          XT-PIC  cascade
  5:      97944          XT-PIC  eth0, ehci_hcd,
ohci_hcd, ohci_hcd, ohci_hcd, SiS SI7012
  8:          1          XT-PIC  rtc
 10:          2          XT-PIC  ohci1394
 11:          5          XT-PIC  acpi
 12:        165          XT-PIC  i8042
 14:       5380          XT-PIC  ide0
 15:          0          XT-PIC  ide1
NMI:          0 
LOC:          0 
ERR:          0
MIS:          0


btw did you find anything weird in my DSDT?
 --- "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> wrote: 
> Hmm... would you please cat /proc/interrupts to me.
> 
> Thanks
> Luming 
> 
> >-----Original Message-----
> >From: dev_zero [mailto:dev_xor-eZNTXLQAfP4@public.gmane.org] 
> >Sent: 2004å¹´11æœˆ10æ—¥ 21:34
> >To: Yu, Luming
> >Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> >Subject: RE: [ACPI] kacpid problems
> >
> >kacpid still runns with 99%cpu usage when the cpu
> gets
> >too hot. I tried the game quake 2. You can play
> around
> >10 -15 minutes before the kacpid starts running on
> 99%
> >cpu usage. I also used quake 2 too test the kernel
> >before I applied your patch.
> >
> > --- "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> wrote: 
> >> It means there was NO event generated at that
> time.
> >> Do you think the symptom is gone with my debug
> >> patch?
> >> If so, I think your box need a more sane schedule
> >> for acpi_thermal_check 
> >> And, I can come up with a patch.
> >> 
> >> Thanks
> >> Luming 
> >> 
> >> >-----Original Message-----
> >> >From: dev_zero [mailto:dev_xor-eZNTXLQAfP4@public.gmane.org] 
> >> >Sent: 2004Ã¥Â¹Â´11Ã¦Å“Ë†10Ã¦â€”Â¥ 1:06
> >> >To: Yu, Luming
> >> >Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> >> >Subject: RE: [ACPI] kacpid problems
> >> >
> >> >When I try to output the event file I do this:
> >> >[root@balder: /proc/acpi]# cat event >
> >> /home/event.log
> >> >
> >> >But then It just stands there without doing
> >> anything.
> >> >So i tried to check what was wrong (ps ax)
> command:
> >> >2922 pts/0    S+     0:00 cat event
> >> >
> >> >I don't know if it is supposed to be suspended?
> >> >> I want to know what kind of events could be
> >> >> generated heavily, which could have
> corresponding
> >> >> pending execution of AML method issued to work
> >> queue
> >> >> handled by kacpid.  So just cat
> /proc/acpi/event
> >> >
> >> >> event.log
> >> >> to me when you were observing abnormal  cpu
> >> >> consumption by kacpid.  
> >> >> 
> >> >> Thanks
> >> >> Luming 
> >> >> 
> >> >> >-----Original Message-----
> >> >> >From: dev_zero [mailto:dev_xor-eZNTXLQAfP4@public.gmane.org] 
> >> >> >Sent: 2004Ãƒâ€ÃƒÂª11Ãƒâ€Ãƒâ€š10ÃƒË†Ãƒâ€¢
> 0:00
> >> >> >To: Yu, Luming
> >> >> >Subject: RE: [ACPI] kacpid problems
> >> >> >
> >> >> >Of course.. But which log files do you want
> to
> >> take
> >> >> a
> >> >> >look at?
> >> >> >> >How am i supppose to get an output from
> >> >> >> >/proc/acpi/event ??? I can't access the
> file,
> >> >> >> because
> >> >> >> >it's in use.
> >> >> >> 
> >> >> >> Just kill acpid or the similar.
> >> >> >> 
> >> >> >> 
> >> >> >>
> >> >>
> >>
>
>>>-------------------------------------------------------
> >> >> >> This SF.Net email is sponsored by:
> >> >> >> Sybase ASE Linux Express Edition - download
> >> now
> >> >> for
> >> >> >> FREE
> >> >> >> LinuxWorld Reader's Choice Award Winner for
> >> best
> >> >> >> database on Linux.
> >> >> >>
> >> >>
> >>
> http://ads.osdn.com/?ad_idU88&alloc_id065&op=click
> >> >> >>
> >> _______________________________________________
> >> >> >> Acpi-devel mailing list
> >> >> >> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> >> >> >>
> >> >>
> >>
>
>>>https://lists.sourceforge.net/lists/listinfo/acpi-devel
> >> >> >>  
> >> >> >
> >> >>  
> >> >
> >> 
> >
> N¬HS^µéšŠX¬²š'²ŠŞu¼’É¶¬x„.)îÄLi­ë,Ø­Š‰İ£
å¡§g£è¬TD¸§»¨®WQy§^®À¡¢'
«uh§êß¢¶Ş²×Zµ¦Ú±ê'.)îÆm§ÿÚvÊ,vw(›ö‰ùçÏ–Z
‰õÛN¹¢œ–'$ÊbuëŞ–f¢–)à–+-ÊbuëŞ–X¬¶Ë(º·
~Šàzw­†Ûi³ÿåŠËl²‹«qçè®§zßåŠËlşX¬¶)ß£öœ¦'^½é 


-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
