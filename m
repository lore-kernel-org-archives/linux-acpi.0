From: dev_zero <dev_xor-eZNTXLQAfP4@public.gmane.org>
Subject: RE: kacpid problems
Date: Wed, 10 Nov 2004 14:33:35 +0100 (CET)
Message-ID: <20041110133335.84968.qmail@web25309.mail.ukl.yahoo.com>
References: <3ACA40606221794F80A5670F0AF15F84041AC045@pdsmsx403>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <3ACA40606221794F80A5670F0AF15F84041AC045@pdsmsx403>
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

kacpid still runns with 99%cpu usage when the cpu gets
too hot. I tried the game quake 2. You can play around
10 -15 minutes before the kacpid starts running on 99%
cpu usage. I also used quake 2 too test the kernel
before I applied your patch.

 --- "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> wrote: 
> It means there was NO event generated at that time.
> Do you think the symptom is gone with my debug
> patch?
> If so, I think your box need a more sane schedule
> for acpi_thermal_check 
> And, I can come up with a patch.
> 
> Thanks
> Luming 
> 
> >-----Original Message-----
> >From: dev_zero [mailto:dev_xor-eZNTXLQAfP4@public.gmane.org] 
> >Sent: 2004年11月10日 1:06
> >To: Yu, Luming
> >Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> >Subject: RE: [ACPI] kacpid problems
> >
> >When I try to output the event file I do this:
> >[root@balder: /proc/acpi]# cat event >
> /home/event.log
> >
> >But then It just stands there without doing
> anything.
> >So i tried to check what was wrong (ps ax) command:
> >2922 pts/0    S+     0:00 cat event
> >
> >I don't know if it is supposed to be suspended?
> >> I want to know what kind of events could be
> >> generated heavily, which could have corresponding
> >> pending execution of AML method issued to work
> queue
> >> handled by kacpid.  So just cat /proc/acpi/event
> >
> >> event.log
> >> to me when you were observing abnormal  cpu
> >> consumption by kacpid.  
> >> 
> >> Thanks
> >> Luming 
> >> 
> >> >-----Original Message-----
> >> >From: dev_zero [mailto:dev_xor-eZNTXLQAfP4@public.gmane.org] 
> >> >Sent: 2004Äê11ÔÂ10ÈÕ 0:00
> >> >To: Yu, Luming
> >> >Subject: RE: [ACPI] kacpid problems
> >> >
> >> >Of course.. But which log files do you want to
> take
> >> a
> >> >look at?
> >> >> >How am i supppose to get an output from
> >> >> >/proc/acpi/event ??? I can't access the file,
> >> >> because
> >> >> >it's in use.
> >> >> 
> >> >> Just kill acpid or the similar.
> >> >> 
> >> >> 
> >> >>
> >>
>
>>-------------------------------------------------------
> >> >> This SF.Net email is sponsored by:
> >> >> Sybase ASE Linux Express Edition - download
> now
> >> for
> >> >> FREE
> >> >> LinuxWorld Reader's Choice Award Winner for
> best
> >> >> database on Linux.
> >> >>
> >>
> http://ads.osdn.com/?ad_idU88&alloc_id065&op=click
> >> >>
> _______________________________________________
> >> >> Acpi-devel mailing list
> >> >> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> >> >>
> >>
>
>>https://lists.sourceforge.net/lists/listinfo/acpi-devel
> >> >>  
> >> >
> >>  
> >
> 


-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
