From: dev_zero <dev_xor-eZNTXLQAfP4@public.gmane.org>
Subject: RE: kacpid problems
Date: Mon, 8 Nov 2004 21:41:54 +0100 (CET)
Message-ID: <20041108204154.61643.qmail@web25304.mail.ukl.yahoo.com>
References: <3ACA40606221794F80A5670F0AF15F84041AC02D@pdsmsx403>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <3ACA40606221794F80A5670F0AF15F84041AC02D@pdsmsx403>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

You can download my DSDT table from my website or from
this site:
http://acpi.sourceforge.net/dsdt/view.php?id=224
website: http://home.no.net/pusleole/#dsdt

I get some double emails from this mailinglist. When
you guys send me replys you send to my email and a CC
to the mailinglist. Because of this I get some
messages two times. When I send a reply to someone
lets say luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, should I send both a
reply to this email and a CC to the mailinglist, or
should I send the reply to just the mailinglist?

> I'd like to see your box's DSDT to have a idea of
> what's going on in your box.
> 
> Thanks
> Luming 
> 
> >-----Original Message-----
> >From: Laszlo 'GCS' Boszormenyi [mailto:gcs-gKC9iF2I70U@public.gmane.org] 
> >Sent: 2004Äê11ÔÂ8ÈÕ 11:18
> >To: Yu, Luming
> >Cc: dev_zero; acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> >Subject: Re: [ACPI] kacpid problems
> >
> >* Laszlo 'GCS' Boszormenyi <gcs-gKC9iF2I70U@public.gmane.org> [2004-11-08
> 03:48:59 +0100]:
> >
> >> > Could you verify if killing kacpid can make the
> thing better?
> >>  This just happened to me again. I did
> /etc/init.d/acpid stop, and it
> >> did, but issuing halt left me with the
> acpi_power_off called message.
> >> I think some memory corruption may happen in
> kernel space, 
> >or it is just
> >> ACPI failing for some reason.
> > OK, just happened again, so update: I did
> /etc/init.d/acpid stop; but
> >as I saw CPU usage went to half kernel space, half
> user space. But(!)
> >now I can confirm that kacpid with pid 5 stuck in a
> D state, 
> >tried to do
> >something, but the box was so crawling that I chose
> to pull 
> >out the cord
> >instead.
> >
> >HTH,
> >Laszlo
> >
> >
>  


-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
