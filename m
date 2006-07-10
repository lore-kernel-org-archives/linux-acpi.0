From: "=?ISO-8859-1?Q?Rusl=E1n_Ledesma_Garza?="
	<ruslanledesmagarza@gmail.com>
Subject: Re: ACPI not working on DELL Inspiron 1150
Date: Sun, 9 Jul 2006 20:30:07 -0500
Message-ID: <9d90148c0607091830h6f0e4c6odcf1315c4787d1f7@mail.gmail.com>
References: <CFF307C98FEABE47A452B27C06B85BB6ECF9E0@hdsmsx411.amr.corp.intel.com>
	 <BAY116-F277F9556079227022FEF23C86A0@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.182]:15763 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S964976AbWGJBaI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 9 Jul 2006 21:30:08 -0400
Received: by py-out-1112.google.com with SMTP id 57so759309pya
        for <linux-acpi@vger.kernel.org>; Sun, 09 Jul 2006 18:30:08 -0700 (PDT)
In-Reply-To: <BAY116-F277F9556079227022FEF23C86A0@phx.gbl>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: =?ISO-8859-1?Q?Rusl=E1n_Ledesma_Garza?= <ruslanledesmag@hotmail.com>
Cc: len.brown@intel.com, linux-acpi@vger.kernel.org

On 7/9/06, Rusl=E1n Ledesma Garza <ruslanledesmag@hotmail.com> wrote:
>
>
>
> >From: "Brown, Len" <len.brown@intel.com>
> >To: Rusl=E1n Ledesma Garza
> ><ruslanledesmag@hotmail.com>,<linux-acpi@vger.kernel.org>
> >Subject: RE: ACPI not working on DELL Inspiron 1150
> >Date: Sun, 9 Jul 2006 17:10:45 -0400
> >
> >
> > >Hi. I'm a newbie to linux, but I've been getting this problem ever
> > >since I installed it on my computer (I've already tested Fedora Co=
re 5
> > >and Ubuntu 6, both having the same problem).
> > >
> > >1) I first discovered that my laptop display didn't turn off when =
the
> > >lid was closed (I can tell because I can see the glare of the disp=
lay
> > >through a gap). So I started investigating and found that the lid
> > >event is not triggered whenever I close/open the lid (using
> > >acpi_listen). But the weirdest part is that the event is reported =
when
> > >doing "cat /proc/acpi/button/lid/LID/state".
> >
> >is the video driver loaded (drivers/acpi/video.c)
> When doing "lsmod", response is "video                  16260  0", so=
 I
> think answer is yes.
> >
> > >2) Then I realized no events are reported through acpi_listen, exc=
ept
> > >for "ac_adapter" event which occurs after resuming the laptop from
> > >hibernation.
> >
> >How about power button events?
> No other events rather than ac_adapter are reported, including button
> events.
> >
> > >3) I've also found that sometimes the computer freezes when resumi=
ng
> > >from hibernation (I can only confirm this under Ubuntu, I can't
> > >remember what happens with Fedora).
> > >
> > >4) Finally, for some reason gnome power manager doesn't put into
> > >hibernation my computer when battery is too low (the only time I
> > >tested this was under Ubuntu) and simply runs out of battery.
> > >
> > >Since #'s 1 & 2 have ocurred under Fedora and Ubuntu, I assume the=
re
> > >is some low level problem/incompatibility of ACPI with my computer=
's
> > >hardware. Everything works fine under WinXP, and to me power
> > >management is a must for my laptop.
> > >
> > >I've read some stuff about DST's, but sincerelly I didn't undestan=
d
> > >much (ie. where does this DST reside? Is it a firmware?),
> >
> >modified DSDT's are a debugging tool only -- not a path to a "real f=
ix".
> >Linux should work properly on your laptop without any modifications
> >to the firmware.  (though it might be a good idea to check with Dell
> >to make sure you're running the latest).
> Last time I checked (about 3 weeks ago) the bios firmware was the lat=
est
> ("A07"). By the way, are DSDT's firmwares then?
> >
> > >but I wonder
> > >if the fact that my DST says "MSFT" could be the cause of ACPI not
> > >working propertly.
> >
> >:-)  This means it was built with the MSFT ASL compiler.  Sometimes
> >that is an issue, but we try to handle those issues and re-building
> >the firmwarwe with Intel's compiler is okay for debugging, but not
> >supportable.
> >
> >build with  CONFIG_ACPI_DEBUG=3Dy and see if any new dmesg come out.
> >You can also boot with "acpi=3Dstrict" if you want to see if
> >Linux is already working around issues in your DSDT.
> I've already tried to build my DSDT using Intel's compiler. It showed
> several errors (can't remember which ones, but I can do it again if t=
his can
> help). I think I fixed them, but could never get to install the modif=
ied
> DSDT.
>
> What can I do?
> >
> >-Len
>
> _________________________________________________________________
> Prodigy/MSN Search. Todo lo que buscas ahora m=E1s rapido
> http://search.t1msn.com.mx/
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-acpi"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
