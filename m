From: =?iso-8859-2?Q?Zden=ECk?= OGAR =?iso-8859-2?Q?Skal=E1k?=
	<skalak-Bh/+Xfn7orxQjibfaplwYw@public.gmane.org>
Subject: Re: Compaq EVO N110, bad state handling?
Date: Fri, 18 Apr 2003 16:13:51 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3EA0081F.2DC2B9DB@monetplus.cz>
References: <20030418123144.GB2623@nostromo>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Jiri Musil <musil-TFwWp4wlsn4@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi,

> Hi,
> i didn't recieve answer in acpi-support so i'm trying to send mail here=
 to devel
> list.
> =

> I have Compaq EVO N110, i compiled 2.4.21-pre6 with acpi for this kerne=
l. I can
> read info about battery, CPU etc. but state file shows bad values.
> =

> When i try to read state of battery at first time it shows probably goo=
d value.
> But when i try to read it one more time there is crazy value (ten time =
more
> then capacity of my battery) which decreases very quickly and when it r=
eaches
> zero value it returns to some crazy high value and the fast decreasing =
repeats.
> That all the time.

	I had the same behaviour on Compaq ARMADA 110. You can search this list =
for
mail from me with title Armada 110, examine if it is applicable & try to =
repair
it yourself :-). Or you could send me your dsdt (cat /proc/acpi/dsdt > ds=
dt.dat)
& I'll have a look.

> CPU stat shows 50C all the time and it is not possible. (it shows 50C e=
ven if my
> fan rotates, according to my BIOS my fan turns on when temperature get =
over
> 76C).

	This thing I didn't care :-{

> Does it exist some solution of this problem or do i have to wait for so=
me next
> version of your kernel patch?

	Sure, solution exist, but you have to repair yourself (or find somebody =
to do
it for you :-)

	Bye
		Zdenek OGAR Skalak

-- =

Ing. Zden=ECk OGAR Skal=E1k
Monet+ a.s.
Z=E1meck=E1 365
763 14 Zl=EDn - =A9t=EDpa, CZ
Tel: +420 / 577 110 411,  Fax: +420 / 577 914 557


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
