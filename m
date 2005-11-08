From: Gunter Ohrner <G.Ohrner-6V9naDJErT6662+jY7v6MhvVK+yQ3ZXh@public.gmane.org>
Subject: Re: Acer Extensa 4101 WLMI
Date: Tue, 8 Nov 2005 18:57:28 +0100
Message-ID: <200511081857.35879.G.Ohrner@post.rwth-aachen.de>
References: <2520.1131376066@www11.gmx.net>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart3528687.HTHEQuyWB4";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <2520.1131376066-mtCb7ZCModZmcu3hnIyYJQ@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Dirk Partikel <dirk.partikel-hi6Y0CQ0nG0@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

--nextPart3528687.HTHEQuyWB4
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Am Montag, 7. November 2005 16:07 schrieb Dirk Partikel:
> Liebes Acpi4Linux Team

Uhm, sending a German text to an English speaking mailing list is no very=20
promising idea, I think...

> Die DSDT vom Acer Extensa 4100 WLMI ist nat=FCtlich nicht kompatibel mit
> meinem Notebook. Laut Acer sind mein Extensa 4101 WLMI und das Aspire
> 1690 WLMI baugleich. Also habe ich erstmal ein aktuelles Bios (3C29)
> eingespielt. Leider funktioniert die DSDT von eurer Seite f=FCr das
> Aspire 1691 WLMI auch nicht.
> H=E4tte jetzt eine gro=DFe bitte an euer Team.
> Habe eine DSDT.dsl aus der /proc/acpi/dsdt erzeugt.
> Beim kompilieren gibt es 14 errors, mehrfach error 1061, kann nirgends
> eine Fehlercodeliste mit der Beschreibung f=FCr error 1061 finden, auch
> ein paar andere errors konnte ich nicht im Internet wiederfinden.
> K=F6nntet ihr euch meine DSDT mal ansehen und gucken ob ihr sie
> instandsetzten k=F6nnt??
> Boote meinen Kernel 2.6.14 mit -noapic, hat das Einfluss auf die
> Richtigkeit der DSDT.dsl bzw. /proc/acpi/dsdt??
> Acer Extensa 4101 WLMI, 1024 MB Ram DDR, Radeon X700
>
> Wenn ihr mir z.B. eine Info geben w=FCrdet, error 1061 l=E4sst sich so und
> so beheben, w=FCrde ich diese Informationen gerne an Ubuntuusers.de
> weiterleiten, dort gibt es schon eine Liste mit ein paar errors und
> einer Anweisung, wie man sie behebt, falls da nichts gegen spricht.

************

Obviously the DSDT of an Acer Extensa 4100 WLMI is not compatible with my=20
notebook. According to Acer, my Extensa 4101 WLMI and the Aspire 1690=20
WLMI are identically in this respect, however. I thus installed a current=20
BIOS version (3C29) first. Unfortunately the Aspire 1691 WLMI DSDT=20
provided on the DSDT website doesn't work as well.


So I kindly ask you to grant my request:

I created a DSDT.dsl based on my /proc/acpi/dsdt. Recompiling it causes 14=
=20
errors including multiple "error 1061" messages. I wasn't able to find an=20
error code description for error "1061", as well as some other error=20
messages I got.

Could someone please have a look at this dsdt and try to fix it?

I currently boot my kernel 2.6.14 using -noapic, does this influence the=20
DSDT?

Acer Extensa 4101 WLMI, 1024 MB Ram DDR, Radeon X700

If you can give me any hint on how to fix error 1061 and you don't mind,=20
I'll forward this information to Ubuntuusers.de, they already provide a=20
list with a few error messages and instructions on how to fix these.

************

Greetings,

  Gunter

=2D-=20
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
+ http://aachen.uni-dsl.de/   -   Der direkte Draht in's Hochschulnetz! +
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
Behind every good computer... is a jumble of wires 'n stuff.
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
+                   PGP-verschl=FCsselte Mails bevorzugt!                 +
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+

--nextPart3528687.HTHEQuyWB4
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQBDcOcP0ORHvREo8l8RAugPAJ0TE9wlSzU/wlDcrEr5TWJvcWRIAwCgmuXs
m6VTS1RUoxB4dS/jY1A1TyA=
=PZNF
-----END PGP SIGNATURE-----

--nextPart3528687.HTHEQuyWB4--


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
