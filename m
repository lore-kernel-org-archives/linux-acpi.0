From: Ruud Koendering <ruud.koendering-EIBgga6/0yRmR6Xm/wNWPw@public.gmane.org>
Subject: Re: RE: Presario DANGER
Date: Mon, 4 Nov 2002 18:40:58 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200211041840.59356.ruud.koendering@planet.nl>
References: <200211041130.44371.ruud.koendering@planet.nl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200211041130.44371.ruud.koendering-EIBgga6/0yRmR6Xm/wNWPw@public.gmane.org>
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

On Monday 04 November 2002 11:30 am, ruud koendering wrote:
> All the Compaq Presario's are in danger without ACPI. This is confirmed=
 by
> new HP. (They d'ont feel to be responcible as always in certain compani=
es.
> Make something, sell it and then so0rry c'ant help you)
>
> When will companies like Suse, RedHat, Mandrake etc. do something about=
 it?


Alan Cox wrote:

On Mon, 2002-11-04 at 10:30, ruud koendering wrote:
> All the Compaq Presario's are in danger without ACPI. This is confirmed=
 by=20
new=20
> HP. (They d'ont feel to be responcible as always in certain companies. =
Make=20
> something, sell it and then so0rry c'ant help you)

That means you cannot even run DOS on that laptop or any software which
disables interrupts for a long time thus stopping ACPI running. It also
means it is not a PC compatible system. So its not even safe to boot
your old PC games on, not even Doom

I'm under the impression ACPI requires proper thermal protection too.
I'd have to go and read the specification again.

You can expect companies to ship ACPI when it works well enough. Right
now even the newest 2.5.4x code crashes on boot on some systems (eg IBM
TP600) but its getting a lot lot better. The more people try it and the
more they report problems the quicker it gets fixed

Markus Gaugusch wrote:

On Nov 4, ruud koendering <ruud.koendering-EIBgga6/0yRmR6Xm/wNWPw@public.gmane.org> wrote:
> All the Compaq Presario's are in danger without ACPI. This is confirmed
> by new HP. (They d'ont feel to be responcible as always in certain
> companies. Make something, sell it and then so0rry c'ant help you)
>
> When will companies like Suse, RedHat, Mandrake etc. do something about
> it?
SuSE delivers 8.1 with acpi 2002-08-29
But everything is built as module and not loaded by default :-(
(especially processor.o, which is really sad)

Markus
--=20
__________________    /"\
Markus Gaugusch       \ /    ASCII Ribbon Campaign
markus-z+rTbpWsRgbk7+2FdBfRIA@public.gmane.org     X     Against HTML Mail
                      / \

Alan Cox wrote again:

On Mon, 2002-11-04 at 10:30, ruud koendering wrote:
> All the Compaq Presario's are in danger without ACPI. This is confirmed=
 by=20
new=20
> HP. (They d'ont feel to be responcible as always in certain companies. =
Make=20
> something, sell it and then so0rry c'ant help you)

That means you cannot even run DOS on that laptop or any software which
disables interrupts for a long time thus stopping ACPI running. It also
means it is not a PC compatible system. So its not even safe to boot
your old PC games on, not even Doom

I'm under the impression ACPI requires proper thermal protection too.
I'd have to go and read the specification again.

You can expect companies to ship ACPI when it works well enough. Right
now even the newest 2.5.4x code crashes on boot on some systems (eg IBM
TP600) but its getting a lot lot better. The more people try it and the
more they report problems the quicker it gets fixed

Sergio Monteiro Basto wrote:

Citando ruud koendering <ruud.koendering-EIBgga6/0yRmR6Xm/wNWPw@public.gmane.org>:

} All the Compaq Presario's are in danger without ACPI.
} This is confirmed by new=20
} HP. (They d'ont feel to be responcible as always in
} certain companies. Make=20
} something, sell it and then so0rry c'ant help you)
}=20
} When will companies like Suse, RedHat, Mandrake etc.
} do something about it?

I really don't know if is correct  what I am about to say.
but in case of some broken thermal for compaq pressario, on
overheat  the computer turn off automatically (for Compaqs, not
HPs). This have been report for some strange Compaq pressario
7xx models.=20
But just in case of one broken thermal module, we have overheat.=20
In this case its better doesn't use ACPI and fan will work always ?

I really don't know if is correct  what I had write.

I MUST SAY: NICE ANSWERS, THEY REALLY SOLVE MY PROBLEM.

I OWN A PRESARIO 7XX SUPPLIED BY THE NEW HP. COMPAQ IS NO LONGER =3D ONLY=
 A=20
PRODUCT NAME NOT A COMPANY ANYMORE.

I BELIEVE THAT IF MORE PEOPLE TEST ACPI AND ACPI CAN BE SET AS RPM's ON T=
HE=20
WEBSIOTE MORE PEOPLE CAN WORK WITH IT.

MABY A GOOD DESCRIPTION FOR PEOPLE NOT AWARE OF THE INTERNAL WORKINGS!

--=20
Regards
Ruud Koendering
Sr. Program-,Project-,Interim Manager
De Wickelaan 11
2265 DG  Leidschendam
Netherlands
Phone:+31(0)703271506
E-mail:ruud.koendering-EIBgga6/0yRmR6Xm/wNWPw@public.gmane.org


-------------------------------------------------------
This SF.net email is sponsored by: ApacheCon, November 18-21 in
Las Vegas (supported by COMDEX), the only Apache event to be
fully supported by the ASF. http://www.apachecon.com
