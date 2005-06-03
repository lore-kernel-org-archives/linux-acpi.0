From: "=?iso-8859-1?Q?xavier.sinecosa?=" <xavier.sinecosa-QFKgK+z4sOrR7s880joybQ@public.gmane.org>
Subject: =?iso-8859-1?Q?Re:_[ACPI]_no_event_for_/proc/acpi/event_with_acpi?=
Date: Fri,  3 Jun 2005 20:39:29 +0200
Message-ID: <IHIUHT$4841493C3B0D6E98A781DF67D66DE783@laposte.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "=?iso-8859-1?Q?G.Ohrner?=" <G.Ohrner-6V9naDJErT6662+jY7v6MhvVK+yQ3ZXh@public.gmane.org>, =?iso-8859-1?Q?schiotz?= <schiotz-rIHh/f1EQlCDBdmmcMluBA@public.gmane.org>, "=?iso-8859-1?Q?matt.weinecke?=" <matt.weinecke-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: =?iso-8859-1?Q?acpi-devel?= <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

I tried these but nothing happened. After a while I =0D=0Afound the subje=
ct "Bugzilla Bug 1752 ACPI (button and =0D=0Alid) not working Dell Inspir=
on 5150 with 2.6 kernel"=0D=0A at page http://bugme.osdl.org/show_bug.cgi=
?id=3D1752, =0D=0Aform  acpi-bugzilla mailing list. =0D=0AHowever I tried=
 to subscribe to this list. Weirdly, I =0D=0Ahave problems subscribing. T=
his the reason why I =0D=0Asummarize, solutions to the /proc/acpi/event p=
roblem on =0D=0ADell I5150. =0D=0A=0D=0AI read this thread, and as sugges=
ted by  Jakob Schi=F8tz, =0D=0AI thus tried bios A38 with version 2.6.11.=
7 (already =0D=0Ainstalled) and acpi_irq_balance option passed on the=0D=0A=
kernel command line in my grub.conf.=0D=0A                               =
                          =0D=0A                             =0D=0AI had =
no success doing this as well. May be because of =0D=0Aone or a combinati=
on of the following things :=0D=0A                             =0D=0A1) T=
oo many paches applied on kernel 2.6.11.7. I have =0D=0Apatched kernel 3 =
times with, in the following order,=0D=0Aan nvidia patch (linux-2.6.11.7-=
nvidia_6111-=0D=0A6629_compat2.diff), the acpi patch acpi-20050408-2.6.11=
.=0D=0Adiff.bz2, and the suspend2 patch software-suspend-2.1.8-=0D=0Afor-=
2.6.11.tar.bz2.=0D=0A                             =0D=0A2) The buggy DSDT=
: I didn't patch the kernel for this =0D=0Aversion, as explained on a gen=
too forum thread (named =0D=0AHOWTO: Fix Common ACPI Problems (DSDT, ECDT=
, etc.)).=0D=0A=0D=0A3) A missing in my .config file. Comparing ACPI in .=
=0D=0Aconfig I didn't set=0D=0ACONFIG_ACPI_SLEEP_PROC_FS=3Dy=0D=0Awhich i=
s depreceated, and=0D=0ACONFIG_X86_ACPI_CPUFREQ=3Dm=0D=0A                =
  =0D=0A4) SMP use.                                              =0D=0A  =
                                      =0D=0A5) an option missing in my ke=
rnel command line.=0D=0A =0D=0A6) a problem with usb as mentioned above, =
concerning the =0D=0Abuggy dsdt.=0D=0A                                   =
                      =0D=0A                             =0D=0AFor the .c=
onfig file, I will with try  Jakob Schi=F8tz =0D=0Asettings. But can one =
tell me about the buggy dsdt ? Do =0D=0AI have to patch the kernel ?=0D=0A=
Do I have to disable smp ?=0D=0A=0D=0A=0D=0A=0D=0AAm Dienstag 31 Mai 2005=
 16:27 schrieb xavier.sinecosa:=0D=0A> The file /proc/acpi/event can been=
 accessed only once.=0D=0A> When acpid runs,=0D=0A> # cat /proc/acpi/even=
t=0D=0A> acpid: can't open /proc/acpi/event: Device or resource=0D=0A> bu=
sy=0D=0A=0D=0ALooks ok, acpid is blocking it.=0D=0A=0D=0A> Stoping acpid,=
 and cat'ing /proc/acpi/event, I get=0D=0A> # cat /proc/acpi/event=0D=0A>=
=0D=0A> ....=0D=0A=0D=0ALooks ok, it waits for an event. Execute this com=
mand =0D=0Aand try pressind the =0D=0Apower or suspend button or (un)plug=
ging the ac adapter. =0D=0AThe event should =0D=0Ashow up.=0D=0A=0D=0A> I=
t stays like this. In another console I try acpid and=0D=0A> get :=0D=0A>=
 # acpid=0D=0A> acpid: can't open /proc/acpi/event: Device or resource=0D=
=0A> busy=0D=0A> #=0D=0A=0D=0AThis seems also ok, the cat is blocking acc=
ess to the =0D=0Afile.=0D=0A=0D=0A=0D=0AGreetings,=0D=0A=0D=0A  Gunter=0D=
=0A=0D=0A-- =0D=0A+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+=
-=0D=0A+-+-+-+-+-+-+-+-+=0D=0A+ http://aachen.uni-dsl.de/   -   Der direk=
te Draht in's =0D=0AHochschulnetz! +=0D=0A+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+=
-+-+-+-+-+-+-+-+-+-+-+-+-=0D=0A+-+-+-+-+-+-+-+-+=0D=0A- "Remember -- that=
 which does not kill us can only make =0D=0Aus stronger."=0D=0A- "And tha=
t which *does* kill us leaves us *dead*!"=0D=0A        -- (Terry Pratchet=
t, Carpe Jugulum)=0D=0A+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-=
+-+-+-=0D=0A+-+-+-+-+-+-+-+-+=0D=0A+                   PGP-verschl=FCssel=
te Mails bevorzugt!  =0D=0A               +=0D=0A+-+-+-+-+-+-+-+-+-+-+-+-=
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-=0D=0A+-+-+-+-+-+-+-+-+=0D=0A=0D=0A=0D=0A=
-------------------------------------------------------=0D=0AThis SF.Net =
email is sponsored by Yahoo.=0D=0AIntroducing Yahoo! Search Developer Net=
work - Create =0D=0Aapps using Yahoo!=0D=0ASearch APIs Find out how you c=
an build Yahoo! directly =0D=0Ainto your own=0D=0AApplications - visit ht=
tp://developer.yahoo.net/?fr



-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
