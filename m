From: =?ISO-8859-1?Q?S=E9rgio?= Monteiro Basto <sergiomb-hHo3WeeoaswVhHzd4jOs4w@public.gmane.org>
Subject: Re: the incremental patch 20030521-20030528
Date: 29 Mar 2003 20:45:26 +0000
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1048970727.1944.76.camel@darkstar.portugal>
References: <F760B14C9561B941B89469F59BA3A847E96D8E@orsmsx401.jf.intel.com>
	 <20030329151604.GA19676@hell.org.pl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-UEE/oKjniYX93zo76Wue"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20030329151604.GA19676-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Karol Kozimor <sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>
Cc: acpi-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org


--=-UEE/oKjniYX93zo76Wue
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Make the incremental patch is easy: apply the old patch to kernel and
the new patch to a copy of same kernel version, clean orig (and rej)
files and make the diff -Nur.=20

so here is the result, and don't test is yet.


On Sat, 2003-03-29 at 15:16, Karol Kozimor wrote:
> Thus wrote Grover, Andrew:
> > Fixed a problem where the error message "Failed to acquire semaphore"
> > would appear during operations on the embedded controller (EC).=20
>=20
> Thanks for that!
> I have one question though. Did you consider doing incremental ACPI
> patches? I'm using a heavily patched kernel with XFS filesystem support,
> and getting all these patches to work and applying all the rejects manual=
ly
> is a real pain. Incremental patches would really make life (mine, at leas=
t)=20
> easier. What do you think about it?
>=20
> (the above refers to the 2.4 kernel, with 2.5 changing so fast it isn't
> really a problem)
>=20
> Best regards,
>=20
> --=20
> Karol 'sziwan' Kozimor
> sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org
>=20
>=20
> -------------------------------------------------------
> This SF.net email is sponsored by:
> The Definitive IT and Networking Event. Be There!
> NetWorld+Interop Las Vegas 2003 -- Register today!
> http://ads.sourceforge.net/cgi-bin/redirect.pl?keyn0001en
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/acpi-devel
--=20
S=E9rgioMB
email: sergiomb-hHo3WeeoaswVhHzd4jOs4w@public.gmane.org

Who gives me one shell, give me everything.

--=-UEE/oKjniYX93zo76Wue
Content-Disposition: attachment; filename=05210528.diff.gz
Content-Type: application/x-gzip; name=05210528.diff.gz
Content-Transfer-Encoding: base64

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

--=-UEE/oKjniYX93zo76Wue--



-------------------------------------------------------
This SF.net email is sponsored by:
The Definitive IT and Networking Event. Be There!
NetWorld+Interop Las Vegas 2003 -- Register today!
http://ads.sourceforge.net/cgi-bin/redirect.pl?keyn0001en
