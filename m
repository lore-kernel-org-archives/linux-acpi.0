From: Bernd Schubert <bernd-schubert-S0/GAf8tV78@public.gmane.org>
Subject: Re: Re: S1 and S3 on IBM Thinkpad don't work
Date: Sun, 14 Nov 2004 23:17:04 +0100
Message-ID: <200411142317.04631.bernd-schubert@web.de>
References: <200411100001.15678.bernd-schubert@web.de> <cmv06r$as3$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <cmv06r$as3$1@sea.gmane.org>
Content-Disposition: inline
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
Cc: Ari Pollak <aripollak-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi Ari,

APM suspend/resume works on my R31 but every time /proc/apm is read, my mou=
se=20
cursor is jumping and the keyboard and mouse are making random input. Not=20
nice if one wants to work ...
Could you please try out my suspend script for S1?

rmmod uhci_hcd
sleep 10
echo 1 >/proc/acpi/sleep
sleep 10 #this is necessary, as it also freezes without
modprobe uhci_hcd

(see  http://bugme.osdl.org/show_bug.cgi?id=3D3723)

Cheers,
 Bernd

On Thursday 11 November 2004 07:18, Ari Pollak wrote:
> I'm having the same problem on my T41 on nearly identical hardware. I
> haven't had time to do any extensive testing, but even APM
> suspend/resume seems to be broken on 2.6.10-rc1-mm4 :(
>
> Bernd Schubert wrote:
> > Hello,
> >
> > I just submitted a bugzilla bugreport
> > (http://bugme.osdl.org/show_bug.cgi?id=3D3723) since the S1 mode doesn't
> > work *anymore*, see below for more details. Unfortunately S3 is also not
> > working, when it wakes up, it spins up the drive, neither the display n=
or
> > the network come up. Any help getting one of the modes working is highly
> > appreciated. I'm willing to add any wakeup, sounds, reading
> > documentation, etc. from next Monday on (not earlier as I'm on a
> > conference from Thursday to Sunday).
> >
> > Thanks a lot in advance,
> >  Bernd
> >
> >
> >
> >
> > Details about the S1 mode problem reported in Bugzilla:
> >
> >
> > Distribution: Debian
> > Hardware Environment: IBM Thinkpad R31
> > Software Environment:
> > Problem Description:
> >
> > Before and with 2.6.2-rc2 S1 was (almost) working fine, only the display
> > didn't switch off. The next kernel I used was 2.6.5 and since this or a
> > version between 2.6.2-rc2 and 2.6.5 waking up from the S1 sleeping mode
> > just doesn't work anymore.
> > Sending it to sleep mode with "echo 1 >/proc/acpi/sleep" works as usual
> > (the display doesn't switch off as usual), but when it wakes up, the la=
st
> > line it prints is:
> >
> > PCI: Setting latency timer of device 0000:00:1f.5 to 64
> >
> > Afterwards no further keyboard input is possible and only a hard reset =
by
> > pressing the power button for 5 seconds works.
> > Possibly the other wakeup messages are also important, so I uploaded a
> > digicam screenshot
> >
> > http://www.pci.uni-heidelberg.de/tc/usr/bernd/downloads/R31_acpi/R31_S1=
_w
> >ake_up.jpg
> >
> >
> > It might be also interesting that this doens't happen, if I enable full
> > debugging via /proc/acpi/debug_level. Well, my whole screen is then
> > overwritten with lots of debugging messages, but after S1 sleeping, it
> > wakes up fine.
> >
> >
> > Steps to reproduce:
> > echo 1 >/proc/acpi/sleep
> >
> >
> > The dmesg, dmidecode, acpidmp, lspci and interrups files can be found at
> > http://www.pci.uni-heidelberg.de/tc/usr/bernd/downloads/R31_acpi/
>
> -------------------------------------------------------
> This SF.Net email is sponsored by:
> Sybase ASE Linux Express Edition - download now for FREE
> LinuxWorld Reader's Choice Award Winner for best database on Linux.
> http://ads.osdn.com/?ad_id=3D5588&alloc_id=3D12065&op=3Dclick
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/acpi-devel

=2D-=20
Bernd Schubert
Physikalisch Chemisches Institut / Theoretische Chemie
Universit=E4t Heidelberg
INF 229
69120 Heidelberg
e-mail: bernd.schubert-VNq4CFrKgK+dPOQpRHQ53DeJuz7u0hKX@public.gmane.org


-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
