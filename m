From: "Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org>
Subject: Re: Fw: 2.6.13-rc5 - ACPI regression
Date: Thu, 4 Aug 2005 22:28:52 +0200
Message-ID: <200508042228.52975.rjw@sisk.pl>
References: <20050804113048.1ce41cae.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20050804113048.1ce41cae.akpm-3NddpPZAyC0@public.gmane.org>
Content-Disposition: inline
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
Cc: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Thursday, 4 of August 2005 20:30, Andrew Morton wrote:
>=20
> Quite a list of problems over on linux-kernel.  I suspect we've
> fixed some of them post-2.6.13-rc5.  Could someone take a look, please?

AFAIRC, the ec_polling patch helped in this case and the EC burst mode is n=
ow
disabled by default, so this should be fixed.

Greets,
Rafael

=20
> Begin forwarded message:
>=20
> Date: Tue, 2 Aug 2005 19:53:36 +0200
> From: Lukas Hejtmanek <xhejtman-IGZnsrowxP9fmBTHTHKXmQ@public.gmane.org>
> To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> Subject: 2.6.13-rc5 - ACPI regression
>=20
>=20
> Hello,
>=20
> newly with 2.6.13-rc5 (previous -rc1 was quite ok)
>=20
> $ time cat /proc/acpi/battery/BAT0/info =20
> present:                 yes
> design capacity:         6000 mAh
> last full capacity:      6000 mAh
> battery technology:      rechargeable
> design voltage:          14800 mV
> design capacity warning: 600 mAh
> design capacity low:     300 mAh
> capacity granularity 1:  60 mAh
> capacity granularity 2:  60 mAh
> model number:            M6A
> serial number:           =20
> battery type:            LIon
> OEM info:                ASUSTEK
>=20
> real    0m32.521s
> user    0m0.001s
> sys     0m0.015s
>=20
> --=20
> Luk=E1__ Hejtm=E1nek
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>=20
>=20
> -------------------------------------------------------
> SF.Net email is Sponsored by the Better Software Conference & EXPO
> September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practic=
es
> Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
> Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/acpi-devel
>=20
>=20

=2D-=20
=2D Would you tell me, please, which way I ought to go from here?
=2D That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
