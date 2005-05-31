From: "=?iso-8859-1?Q?xavier.sinecosa?=" <xavier.droubay-QFKgK+z4sOrR7s880joybQ@public.gmane.org>
Subject: =?iso-8859-1?Q?no_event_for_/proc/acpi/event_with_acpi_?=
Date: Tue, 31 May 2005 16:27:06 +0200
Message-ID: <IHCYT6$A65ACB979DE9F2ADC9B481D1CAADB66A@laposte.net>
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
To: =?iso-8859-1?Q?acpi-devel?= <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hello, I always have troubles using acpid with acpi on =0D=0Amy dell i515=
0 HT (bios a37), nvidia graphic card. =0D=0ADoing things like =0D=0A# ech=
o 1 > /proc/acpi/sleep=0D=0Aare ok (shutdown for this actual sample )=0D=0A=
I am actually on rh9 with kernel 2.6.11.7 patched =0D=0Alinux-2.6.11.7-nv=
idia_6111-6629_compat2.diff=0D=0Aacpi-20050408-2.6.11.diff.bz2=0D=0Aand s=
oftware-suspend-2.1.8-for-2.6.11.tar.bz2.=0D=0A=0D=0ASuspending to disk u=
sing hibernate script is ok.=0D=0A=0D=0AI installed acpid v1.0.3. =0D=0AT=
he file /proc/acpi/event can been accessed only once. =0D=0AWhen acpid ru=
ns, =0D=0A# cat /proc/acpi/event=0D=0Aacpid: can't open /proc/acpi/event:=
 Device or resource =0D=0Abusy=0D=0A=0D=0AStoping acpid, and cat'ing /pro=
c/acpi/event, I get =0D=0A# cat /proc/acpi/event=0D=0A=0D=0A....=0D=0AIt =
stays like this. In another console I try acpid and =0D=0Aget : =0D=0A# a=
cpid=0D=0Aacpid: can't open /proc/acpi/event: Device or resource =0D=0Abu=
sy=0D=0A#=0D=0A=0D=0AAs acpid allows to use another file than /proc/acpi/=
=0D=0Aevent, I tried=0D=0A# touch /root/toto=0D=0A# acpid -de toto=0D=0A[=
Tue May 31 16:20:04 2005] starting up=0D=0A[Tue May 31 16:20:04 2005] DBG=
: parsing conf file /etc/=0D=0Aacpi/events/powerbtn=0D=0A[Tue May 31 16:2=
0:04 2005] DBG: parsing conf file /etc/=0D=0Aacpi/events/sleepbtn=0D=0A[T=
ue May 31 16:20:04 2005] DBG: parsing conf file /etc/=0D=0Aacpi/events/po=
werbtn1=0D=0A[Tue May 31 16:20:04 2005] DBG: parsing conf file /etc/=0D=0A=
acpi/events/powerbtn2=0D=0A[Tue May 31 16:20:04 2005] DBG: parsing conf f=
ile /etc/=0D=0Aacpi/events/powerbtn3=0D=0A[Tue May 31 16:20:04 2005] DBG:=
 parsing conf file /etc/=0D=0Aacpi/events/ac_adapter=0D=0A[Tue May 31 16:=
20:04 2005] DBG: parsing conf file /etc/=0D=0Aacpi/events/battery=0D=0A[T=
ue May 31 16:20:04 2005] 7 rules loaded=0D=0A[Tue May 31 16:20:34 2005] r=
eceived event "ac_adpater"=0D=0A[Tue May 31 16:20:34 2005] DBG: 0 total r=
ules matched=0D=0A[Tue May 31 16:20:34 2005] completed event "ac_adpater"=
=0D=0A=0D=0AAnd in another window the command =0D=0A# echo ac_adapter >> =
toto=0D=0Agives the 3 last lines 16:20:34 above.=0D=0A=0D=0AHow can I get=
 rid of this problem ? =0D=0AIs this problem relied to a fake dsdt, fake =
bios? =0D=0A=0D=0AI would like to solve the problem but I don't how. Any =
=0D=0Asuggestion is well welcome. =0D=0A=0D=0AThanks, Xavier. 



-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
