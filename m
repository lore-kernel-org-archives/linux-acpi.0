From: Luca Capello <luca-wlebWZzHoyE@public.gmane.org>
Subject: Re: problem with suspension
Date: Fri, 18 Feb 2005 14:13:52 +0100
Message-ID: <873bvu9fjj.fsf@gismo.pca.it>
References: <web-47803451@infinito.it> <20050218124035.GB1523@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-="; micalg=pgp-sha1;
 protocol="application/pgp-signature"
In-reply-to: <20050218124035.GB1523-I/5MKhXcvmPrBKCeMvbIDA@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>
Cc: pj.harvey-97W46K3QqA41GQ1Ptb7lUw@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


--=-=-=

Hi Pavel!

On Fri 18 Feb 2005 13:40, Pavel Machek wrote:
>>    I have a problem with suspension.
<cut>
>> I have a problem with modules of SCSI controller, aic7xxx.
<cut>
> Fix aic7xxx so that it rmmods cleanly as a first step?

It's clear that this is something which should be done, but...

I discussed with Luca about his problem on an Italian LUG mailing-list
and we found out that there's a preliminary suspend/resume support for
the aic7xxx [1] [2], the patch for which actually doesn't apply to the
latest stable 2.6.10. So I suggested him to post on this mailing-list
hoping that someone could point to a more recent patch (or provide any
solution other than not loading the module).

But, indeed, there're two problems:

1) removing the aic7xxx is not a clean process

2) the aic7xxx supsend/resume support is in progress

Just my 0.02c.

Thx, bye,
Gismo / Luca

[1] http://lkml.org/lkml/2004/07/22/210
[2] http://lkml.org/lkml/2004/12/17/187

--=-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQBCFeoRVAp7Xm10JmkRAmZrAJ9PqkDqOHSdRUDhxKz9uPZI+uP0gACeI75y
e4nlylbr+3kCorsJ8IBnNYI=
=XUA6
-----END PGP SIGNATURE-----
--=-=-=--


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
