From: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: FW: Help with suspend / hybernate
Date: Mon, 30 Jun 2003 09:34:22 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <F760B14C9561B941B89469F59BA3A847E96FE2@orsmsx401.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
content-class: urn:content-classes:message
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org



-----Original Message-----
From: Frederik Nosi [mailto:fredi-X9IQk7V7lNg1GQ1Ptb7lUw@public.gmane.org]=20
Sent: Monday, June 30, 2003 7:43 AM
To: Grover, Andrew
Subject: Help with suspend / hybernate


Andrew,
sorry to bother you with mailing directly but I subscribed at the=20
linux-pm-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org and sourceforge seems to not accept
mail=20
from me. Tryed with acpi-support too but nothing. So I choosed to mail
you=20
directly becouse it seems you are the main ACPI developer.

Hi to all!
I have a compaq laptop (evo n1020v,=20
http://h10010.www1.hp.com/wwpc/us/en/sm/WF06a/321957-64295-89315-212727-
f1-240898.html)=20
and I'm trying to get power management with this.
Tryed with ACPI (latest 2.4 patch included in 2.4.21-pre[12]) , the BIOS

passes the blacklist check just fine. With acpi I get the battery time
left,=20
events so I can poweroff with lkaptop's power key and the two termal=20
controlls. Now, reading /proc/acpi/sleep I get this modes:
S0 S3 S4 S5
But trying with echo <n> > sleep I can only poweroff with S5. The other
values=20
for sleep do nothing, tried with debug enabled too and nothing in the
logs. So=20
I can not get the=20
laptop in sleep or hybernate.
With APM when doing "apm -S " everything is fine, the laptop goes to
sleep and=20
wakeyps when pressing some key. With "apm -s" The laptop goes in
hybernate=20
but I can't get it awake, I have to shutdown it pressing the power key
for 4=20
seconds.
As It seems that this laptop's ACPI/BIOS is good, is there any chance to
get=20
sleep=20
/ hybernate with ACPI on this laptop? This will be the best option if=20
possible. And yes, I accept patches for this and I'll gladly try them
and=20
report if needed. If not, is there any way to wake up this laptop after
a=20
"apm -s" ?

I'll provide any needed info, just ask. And sorry again if you are not
the=20
person to ask for this.

Thank you for your attention,
Fredi


-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100006ave/direct;at.asp_061203_01/01
