From: Dominik Brodowski <linux-X3ehHDuj6sIIGcDfoQAp7BvVK+yQ3ZXh@public.gmane.org>
Subject: Re: Entering C3 Processor State without a Bus Arbiter
Date: Fri, 16 Jan 2004 19:02:25 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040116180225.GB5090@dominikbrodowski.de>
References: <Law11-OE36TK4GXSNMh0000bd93@hotmail.com> <20040115154555.V73140@root.org> <20040116093055.GE9814@dominikbrodowski.de> <20040116092917.W76365@root.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="uQr8t48UFsdbeI+V"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20040116092917.W76365-Y6VGUYTwhu0@public.gmane.org>
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


--uQr8t48UFsdbeI+V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jan 16, 2004 at 09:33:05AM -0800, Nate Lawson wrote:
> The processor code in Linux degrades to C2 when the last sleep was less
> than its latency.  So if you have 900 us C3 latency, you can be woken up a
> thousand times a second without degrading to C2.

Well, then maybe the Cx policy code is something which needs to be looked
at... will do that when I implement _CST support [soon, as my notebook wants
to be put into C4]

	Dominik

--uQr8t48UFsdbeI+V
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFACCcxZ8MDCHJbN8YRAtZ5AJ9gfz+TCLYXkUzt91N9pZ6oF0MEIACfRw6b
MapqhMlFTFfE8rBgzGBLo2E=
=Mao0
-----END PGP SIGNATURE-----

--uQr8t48UFsdbeI+V--


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
