From: Arnaud Fevrier <fevrier-mGjiqC8JayDH3mj/uWlBYqb9WTlM5w7aUBSOeVevoDU@public.gmane.org>
Subject: Re: Testing: NVidia closed driver fails.
Date: Tue, 24 Sep 2002 16:22:46 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <15760.30006.534759.107599@ohgma.iut-gtr.univ-mrs.fr>
References: <200209221329.g8MDTL009929@pfn1.pefnos>
Reply-To: fevrier-94MxA55sdNz4HDTGivPSywpplqO2vBoV@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200209221329.g8MDTL009929-a1J+ToZc0kR3t0M9ZKkFCQ@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=acpi-devel>
To: "P. Christeas" <p_christ-U04EIuiosng@public.gmane.org>
Cc: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


Hi,

 I have a fujitsu-Siemens CelsiusH which comes with a nvidia card. The
 nvidia driver (1.0-2960) shares it interupts with the allegro sound
 card.

I compiled the kernel 20-pre7 acpi 2002 09 18, and it boots fine.=20

I cannot run the make xconfig, and I had to set the SMP. It did not
compile for a uniprocessor.

A lot of acpi features work fine, but I cannot sleep or hibernate the
laptop.

Sincerly,

--=20

			    Arnaud F=E9vrier
			    fevrier-94MxA55sdNz4HDTGivPSy1aPQRlvutdw@public.gmane.org
			    +33 () 491 177 926
                 =20
                =20


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
