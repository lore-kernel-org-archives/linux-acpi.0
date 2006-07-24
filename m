From: "=?ISO-8859-1?Q?Rusl=E1n_Ledesma_Garza?="
	<ruslanledesmagarza@gmail.com>
Subject: Re: ACPI not working on DELL Inspiron 1150
Date: Mon, 24 Jul 2006 13:34:23 -0500
Message-ID: <9d90148c0607241134sf0faf86x79bf17a622612b1e@mail.gmail.com>
References: <9d90148c0607091830h6f0e4c6odcf1315c4787d1f7@mail.gmail.com>
	 <BAY116-F20092C1033135B41AA7359C86B0@phx.gbl>
	 <9d90148c0607091943s4fe0c879tbbe13a2d7778a6a7@mail.gmail.com>
	 <1153730717.4302.29.camel@queen.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.181]:55045 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751349AbWGXSeZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 24 Jul 2006 14:34:25 -0400
Received: by py-out-1112.google.com with SMTP id t32so2729931pyc
        for <linux-acpi@vger.kernel.org>; Mon, 24 Jul 2006 11:34:24 -0700 (PDT)
In-Reply-To: <1153730717.4302.29.camel@queen.suse.de>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: trenn@suse.de, linux-acpi@vger.kernel.org

Thanks a lot. I'll try to open a bug as soon as I can. Please let me
know if I can help in any other way.

Rusl=E1n

On 7/24/06, Thomas Renninger <trenn@suse.de> wrote:
> On Sun, 2006-07-09 at 21:43 -0500, Rusl=E1n Ledesma Garza wrote:
> > I see I get no response, where should I go to get some help on this=
 issue?
> >
> > If I have to fix it by myself, could you give me some hint on where=
 to start?
>
> Sorry about the late reply, I just read the last weeks of acpi-devel.
> First, be a bit more patient, it may take some days until someone
> answers.
>
> I have not read the list to the end until now, maybe someone else
> already answered...:
> Can you please open a bug at bugzilla.kernel.org and take me into CC.
> Please provide acpidump and dmesg as attachemnts.
>
> Thanks.
>
>         Thomas
>
> >
> > On 7/9/06, Rusl=E1n Ledesma Garza <ruslanledesmag@hotmail.com> wrot=
e:
> > >
> > >
> > >
> > > >From: "Rusl=E1n Ledesma Garza" <ruslanledesmagarza@gmail.com>
> > > >To: "Rusl=E1n Ledesma Garza" <ruslanledesmag@hotmail.com>
> > > >CC: len.brown@intel.com, linux-acpi@vger.kernel.org
> > > >Subject: Re: ACPI not working on DELL Inspiron 1150
> > > >Date: Sun, 9 Jul 2006 20:30:07 -0500
> > > >
> > > >On 7/9/06, Rusl=E1n Ledesma Garza <ruslanledesmag@hotmail.com> w=
rote:
> > > >>
> > > >>
> > > >>
> > > >> >From: "Brown, Len" <len.brown@intel.com>
> > > >> >To: Rusl=E1n Ledesma Garza
> > > >> ><ruslanledesmag@hotmail.com>,<linux-acpi@vger.kernel.org>
> > > >> >Subject: RE: ACPI not working on DELL Inspiron 1150
> > > >> >Date: Sun, 9 Jul 2006 17:10:45 -0400
> > > >> >
> > > >> >
> > > >> > >Hi. I'm a newbie to linux, but I've been getting this probl=
em ever
> > > >> > >since I installed it on my computer (I've already tested Fe=
dora Core 5
> > > >> > >and Ubuntu 6, both having the same problem).
> > > >> > >
> > > >> > >1) I first discovered that my laptop display didn't turn of=
f when the
> > > >> > >lid was closed (I can tell because I can see the glare of t=
he display
> > > >> > >through a gap). So I started investigating and found that t=
he lid
> > > >> > >event is not triggered whenever I close/open the lid (using
> > > >> > >acpi_listen). But the weirdest part is that the event is re=
ported when
> > > >> > >doing "cat /proc/acpi/button/lid/LID/state".
> > > >> >
> > > >> >is the video driver loaded (drivers/acpi/video.c)
> > > >>When doing "lsmod", response is "video                  16260  =
0", so I
> > > >>think answer is yes.
> > > >> >
> > > >> > >2) Then I realized no events are reported through acpi_list=
en, except
> > > >> > >for "ac_adapter" event which occurs after resuming the lapt=
op from
> > > >> > >hibernation.
> > > >> >
> > > >> >How about power button events?
> > > >>No other events rather than ac_adapter are reported, including =
button
> > > >>events.
> > > >> >
> > > >> > >3) I've also found that sometimes the computer freezes when=
 resuming
> > > >> > >from hibernation (I can only confirm this under Ubuntu, I c=
an't
> > > >> > >remember what happens with Fedora).
> > > >> > >
> > > >> > >4) Finally, for some reason gnome power manager doesn't put=
 into
> > > >> > >hibernation my computer when battery is too low (the only t=
ime I
> > > >> > >tested this was under Ubuntu) and simply runs out of batter=
y.
> > > >> > >
> > > >> > >Since #'s 1 & 2 have ocurred under Fedora and Ubuntu, I ass=
ume there
> > > >> > >is some low level problem/incompatibility of ACPI with my c=
omputer's
> > > >> > >hardware. Everything works fine under WinXP, and to me powe=
r
> > > >> > >management is a must for my laptop.
> > > >> > >
> > > >> > >I've read some stuff about DST's, but sincerelly I didn't u=
ndestand
> > > >> > >much (ie. where does this DST reside? Is it a firmware?),
> > > >> >
> > > >> >modified DSDT's are a debugging tool only -- not a path to a =
"real fix".
> > > >> >Linux should work properly on your laptop without any modific=
ations
> > > >> >to the firmware.  (though it might be a good idea to check wi=
th Dell
> > > >> >to make sure you're running the latest).
> > > >>Last time I checked (about 3 weeks ago) the bios firmware was t=
he latest
> > > >>("A07"). By the way, are DSDT's firmwares then?
> > > >> >
> > > >> > >but I wonder
> > > >> > >if the fact that my DST says "MSFT" could be the cause of A=
CPI not
> > > >> > >working propertly.
> > > >> >
> > > >> >:-)  This means it was built with the MSFT ASL compiler.  Som=
etimes
> > > >> >that is an issue, but we try to handle those issues and re-bu=
ilding
> > > >> >the firmwarwe with Intel's compiler is okay for debugging, bu=
t not
> > > >> >supportable.
> > > >> >
> > > >> >build with  CONFIG_ACPI_DEBUG=3Dy and see if any new dmesg co=
me out.
> > > >> >You can also boot with "acpi=3Dstrict" if you want to see if
> > > >> >Linux is already working around issues in your DSDT.
> > > >>I've already tried to build my DSDT using Intel's compiler. It =
showed
> > > >>several errors (can't remember which ones, but I can do it agai=
n if this
> > > >>can
> > > >>help). I think I fixed them, but could never get to install the=
 modified
> > > >>DSDT.
> > > >>
> > > >>What can I do?
> > > >> >
> > > >> >-Len
> > > >>
> > > >>_______________________________________________________________=
__
> > > >>Prodigy/MSN Search. Todo lo que buscas ahora m=E1s rapido
> > > >>http://search.t1msn.com.mx/
> > > >>
> > > >>-
> > > >>To unsubscribe from this list: send the line "unsubscribe linux=
-acpi" in
> > > >>the body of a message to majordomo@vger.kernel.org
> > > >>More majordomo info at  http://vger.kernel.org/majordomo-info.h=
tml
> > > >>
> > >
> > > _________________________________________________________________
> > > Platica con tus amigos en linea con MSN  Messenger
> > > http://messenger.t1msn.com.mx/
> > >
> > > -
> > > To unsubscribe from this list: send the line "unsubscribe linux-a=
cpi" in
> > > the body of a message to majordomo@vger.kernel.org
> > > More majordomo info at  http://vger.kernel.org/majordomo-info.htm=
l
> > >
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-acp=
i" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
