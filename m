From: Gunter Ohrner <G.Ohrner-6V9naDJErT6662+jY7v6MhvVK+yQ3ZXh@public.gmane.org>
Subject: Re: New ACPI patch available for 2.6.10 and 2.6.11
Date: Thu, 27 Jan 2005 23:11:20 +0100
Message-ID: <200501272311.28339.G.Ohrner@post.rwth-aachen.de>
References: <1106729049.2397.317.camel@d845pe>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2377359.oB20pmR6Yi";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1106729049.2397.317.camel@d845pe>
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
List-Id: linux-acpi@vger.kernel.org

--nextPart2377359.oB20pmR6Yi
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Am Mittwoch, 26. Januar 2005 09:44 schrieb Len Brown:
> An updated ACPI patch including mostly an update to the ACPI
> interpreter is available here:

This patch simply rocks! ;)

I recompiled my kernel yesterday and just noticed that - for the first=20
time ever - C3 finally works on my machine! :-)

It's an Acer TravelMate 612TX with MobileP III 900 MHz and an i810=20
chipset. I'm using Linux 2.6.10 with Softwaresuspend 2 (not tested if it=20
still works after yesterdays recompilation but it did fine before) and=20
now the latest ACPI patch from 2005-01-25.
I'm using the fixed DSDT which can be found in the DSDT collection at=20
sourceforge with an additional modification because I recently upgraded=20
the RAM.

This notebooks problem is/was that even with the fixed DSDT C2 is not=20
supported, just C1 and C3. Previously ACPI didn't make the jump from C1=20
right into C3 but now it seems to do. (Noticed it when gkrellm's x86 CPU=20
meter displayed varying speeds around 50 MHz and below while the previous=20
minimum was 698 MHz - the CPU supports 2 speeds, and only with relaxed=20
speedstep capability checking, 900 MHz and 700 MHz.)

Thanks a lot guys! Now I'll have to check if it has any influence on the=20
average run time on batteries.

Greetings,

  Gunter

=2D-=20
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
+ http://aachen.uni-dsl.de/   -   Der direkte Draht in's Hochschulnetz! +
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
"Bonsai!"
        -- (Terry Pratchett, Reaper Man)
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
+                   PGP-verschl=FCsselte Mails bevorzugt!                 +
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+

--nextPart2377359.oB20pmR6Yi
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQBB+WcQ0ORHvREo8l8RAnWdAKCE7a+HoT9O3sAAG1/xSHZng23KAQCgjQhN
e531og8haFnPc7J/7Mq4gVY=
=d4Kd
-----END PGP SIGNATURE-----

--nextPart2377359.oB20pmR6Yi--


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
