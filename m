From: Yu Luming <luming.yu@intel.com>
Subject: Re: Hang on S3 resume with Acer TravelMate 222X
Date: Tue, 5 Sep 2006 14:28:32 +0800
Message-ID: <200609051428.32974.luming.yu@intel.com>
References: <1157066944.1826.62.camel@timaeus.sophrosune.org> <1157424745.19942.2.camel@timaeus.sophrosune.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:59449 "EHLO
	orsmga101-1.jf.intel.com") by vger.kernel.org with ESMTP
	id S965178AbWIEGWp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 5 Sep 2006 02:22:45 -0400
In-Reply-To: <1157424745.19942.2.camel@timaeus.sophrosune.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Todd Pytel <tppytel@sophrosune.org>
Cc: linux-acpi@vger.kernel.org

On Tuesday 05 September 2006 10:52, Todd Pytel wrote:
> Please? Anybody? Just some Google fodder or pointers on how to genera=
te
>  better debugging information for the list would be greatly appreciat=
ed.
Not sure if this can help you. http://acpi.sourceforge.net/

>  > I've got a rather old Acer TravelMate 222X for which I would *real=
ly*
>  > like to get proper S3 support. Right now, doing an
>  >
>  > echo -n "mem" > /sys/power/state
>  >
>  > suspends the machine to RAM OK. But when it tries to resume, it sh=
ows a
>  > bit of disk activity and then hard locks - nothing on the screen, =
no
>  > keyboard input is accepted, and it doesn't respond to pings. This =
is
>  > using 2.6.17, entirely from text mode with no framebuffer. I've tr=
ied
>  > various combinations of acpi_sleep parameters and noapic/lapic wit=
h no
>  > visible effect.
Does windows work?
If you think this is a ACPI bug , please file it on bugzilla.kernel.org=
 in=20
ACPI category.

>  >
>  > I've been reading through many of the ACPI docs on the net, and ha=
ve
>  > fixed my DSDT and added it to the kernel according to those
>  > instructions. This had no visible effect on the resume behavior. M=
ost of
>  > the fixes were pretty obvious, but one I wasn't sure about - perha=
ps
>  > it's related to my problem. I received the error "Method local var=
iable
>  > is not initialized (Local0)" for the statement "Store (Local0,
>  > \_SB.PCI0.PCI1.OBLN.PMES" in the following code block:
>  >
>  > Method (_L0B, 0, NotSerialized)
>  > {
>  >=A0=A0 Store (0x0B, PX80)
>  >=A0=A0 And (\_SB.PCI0.PCI1.OZ68.PWRS, 0xFC, \_SB.PCI0.PCI1.OZ68.PWR=
S)
>  >=A0=A0 Or (\_SB.PCI0.PCI1.OZ68.PMES, 0x80, \_SB.PCI0.PCI1.OZ68.PMES=
)
>  >=A0=A0 Store (Local0, \_SB.PCI0.PCI1.OBLN.PMES)
>  >=A0=A0 Notify (\_SB.SLPB, 0x02)
>  > }
>  >
>  > Well, yeah... it's not initialized. I assumed that the second Stor=
e
>  > statement was just a sloppy way to zero out the variable. So I rep=
laced
>  > "Local0" with "0x00". That compiles without error, but I don't kno=
w if
>  > it makes sense - is there a way that Local0 can be used as somethi=
ng
>  > like a global variable in this specification?
>  >
>  > Other than that, I'm not sure what information is helpful to fix t=
his
>  > problem, but I'm *more* than happy to do whatever diagnostics will=
 shed
>  > better light on the problem. I really want to get this working! Th=
ere's
>  > nothing of obvious interest in my logs - the machine doesn't get f=
ar
>  > enough when it tries to resume to write anything to syslog, and no=
thing
>  > during bootup looks particularly suspicious. But maybe I just don'=
t what
>  > I should be looking for.

The first step, please take a close look at Documentation/power/video.t=
xt


--=20
Thanks,
Luming
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
