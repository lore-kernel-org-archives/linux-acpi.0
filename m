From: Dominik Brodowski <linux-X3ehHDuj6sIIGcDfoQAp7BvVK+yQ3ZXh@public.gmane.org>
Subject: Re: Entering C3 Processor State without a Bus Arbiter
Date: Fri, 16 Jan 2004 10:30:55 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040116093055.GE9814@dominikbrodowski.de>
References: <Law11-OE36TK4GXSNMh0000bd93@hotmail.com> <20040115154555.V73140@root.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Ycz6tD7Th1CMF4v7"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20040115154555.V73140-Y6VGUYTwhu0@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Nate Lawson <nate-Y6VGUYTwhu0@public.gmane.org>
Cc: Dino Klein <dinoklein-PkbjNfxxIARBDgjK7y7TUQ@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


--Ycz6tD7Th1CMF4v7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 15, 2004 at 03:52:12PM -0800, Nate Lawson wrote:
> > After removing the restrictions in the source files, and adding a WBINVD
> > instruction right before the read from P_LVL3 - the processor was put in
> > the C3 state. This is on my Via Apollo Pro133A based Abit VP6 board,
> > which does not have a Bus Arbiter. Just for the record, I did pull out
> > the second CPU, so I can do "safer" experimentation.
>=20
> WBINVD is too expensive when you're entering C3 hundreds of times per
> second.  Try playing back an mp3 while dd'ing a CDROM in PIO mode to your
> hard drive.  Goodbye data, hello backups!  The CPU can't snoop the bus in
> C3.

You shouldn't enter C3 at all when the CPU is woken up hundreds of times per
second. Maximum allowed latency is 1ms, IIRC -- you really shouldn't get
into this state while dd'ing a CDROM or something else...

Problem is, WBINVD might take even longer than 1ms, even though the maximum
I got on my PIII notebook was about 900us...

	Dominik
--Ycz6tD7Th1CMF4v7
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAB69PZ8MDCHJbN8YRAsZdAKCIlss/t+sgGDlLSC2JlFzq1lX6PwCfXyMG
u28XLLzEGSOlypMPNXxiXR4=
=wFLG
-----END PGP SIGNATURE-----

--Ycz6tD7Th1CMF4v7--


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
