From: "Georg C. F. Greve" <greve-mXXj517/zsQ@public.gmane.org>
Subject: Re: acpi-20040715: functional regression on ASUS M2N
Date: Wed, 01 Sep 2004 17:16:13 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <m37jre81fm.fsf@brain.gnuhh.org>
References: <B44D37711ED29844BEA67908EAF36F03AC6ACF@pdsmsx401.ccr.corp.intel.com>
	<m3zn4bbf6x.fsf@brain.gnuhh.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <m3zn4bbf6x.fsf-eMhNhoSsuh6q92djB/mqZw@public.gmane.org> (Georg C. F. Greve's message of
	"Tue, 31 Aug 2004 15:38:30 +0200")
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Li, Shaohua" <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

--=-=-=

 || On Tue, 31 Aug 2004 15:38:30 +0200
 || "Georg C. F. Greve" <greve-mXXj517/zsQ@public.gmane.org> wrote: 

 gg> If swsusp2 would also work now, things would be pretty nice.

Okay, it seems I got software suspend 2 working for this kernel, as
well -- the problem was that somewhere between version 2.0.0.100 and
2.0.0.105 behaviour changed in a way that the userland script is
expected to switch consoles.

I can now suspend to & resume from disk successfully as often as I
want with this kernel, it seems. Also, it appears I can suspend to &
resume from ram successfully as often as I want with this kernel.

Unfortunately, after having done a successful suspend to ram cycle,
the suspend from disk will hang while "Cleaning Up".


So it seems that the state the machine is in after resume from ram is
not identical to the one after resume from disk. Whether this is due
to a problem in the suspend to ram or swsusp2 code, I cannot say.


Given that the suspend to ram has seemed more shaky than the swsusp2
code and only got to work after making the change by hand that Li,
Shaohua suggested, I am (maybe unfairly) suspecting that something is
still not quite right in suspend to ram.

If I can help by providing some more information, please let me know.

Thanks,
Georg

-- 
Georg C. F. Greve                                       <greve-mXXj517/zsQ@public.gmane.org>
Free Software Foundation Europe	                 (http://fsfeurope.org)
Brave GNU World	                           (http://brave-gnu-world.org)

--=-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBBNee9bvivwoZXSsoRAs4WAJ4kQItxIRNIlp6gj8fTIJw7G96O4wCglIZe
27bCz79KVmRa5k9+4Dv7Kdo=
=BF75
-----END PGP SIGNATURE-----
--=-=-=--


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
