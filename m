From: Sergey Vlasov <vsu-u2l5PoMzF/Uox3rIn2DAYQ@public.gmane.org>
Subject: Re: ACPI vs Asus A8v
Date: Sat, 5 Mar 2005 14:22:45 +0300
Message-ID: <20050305142245.40c8914a.vsu@altlinux.ru>
References: <42289943.6030303@travellingkiwi.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1";
 boundary="Signature=_Sat__5_Mar_2005_14_22_45_+0300_ukh8o+qBB321Ylyr"
In-Reply-To: <42289943.6030303-CM5YN7r2dWBr4tq51QLIbdBPR1lH4CV8@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Hamie <hamish-CM5YN7r2dWBr4tq51QLIbdBPR1lH4CV8@public.gmane.org>
Cc: gentoo-amd64-cnFmAm88PdgLnqt3yJz4RQ@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

--Signature=_Sat__5_Mar_2005_14_22_45_+0300_ukh8o+qBB321Ylyr
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

On Fri, 04 Mar 2005 17:22:11 +0000 Hamie wrote:

> I have an athlon64 in an Asus A8V motherboard, running gentoo with 
> kernel 2.6.11 (Also tried with 2.6.9 and 2.6.10). Although it works, and 
> cool&quiet kicks in before boot, I can get no thermal or fan information 
> from acpi...
[skip]
> What sort of info & control SHOULD I be able to see out of this 
> motherboard? How can I get the level of control that Asus offer with 
> their windoze applications?

You should try to use lm_sensors - there are some success reports
about this board:

http://archives.andrew.net.au/lm-sensors/msg29514.html

In fact, most desktop machines do not support access to thermal or fan
information via ACPI (because the code for this is not present in
DSDT); and even if it is supported, the capabilities compared to
lm_sensors are reduced (e.g., most hardware monitoring chips support
voltage monitoring, which is not available through ACPI interfaces).

--Signature=_Sat__5_Mar_2005_14_22_45_+0300_ukh8o+qBB321Ylyr
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFCKZaIW82GfkQfsqIRAtncAJ9fX3mprCWQuJNBXL39BIdaZBiZ0ACfbpQ3
RkCltxZRu+mFGEOM0v8GJyQ=
=El0P
-----END PGP SIGNATURE-----

--Signature=_Sat__5_Mar_2005_14_22_45_+0300_ukh8o+qBB321Ylyr--


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
