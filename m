From: Timo Hoenig <thoenig-dCxI//HcOdFeoWH0uzbU5w@public.gmane.org>
Subject: Re: generic ACPI video and hotkey drivers vs. platform-specific
 drivers
Date: Fri, 04 Mar 2005 10:34:40 +0100
Message-ID: <1109928881.7747.36.camel@nouse.net>
References: <200502230953.j1N9rPLp020723@shell0.pdx.osdl.net>
	 <1109790760.2097.587.camel@d845pe>
	 <20050302205324.GA5486@deep-space-9.dsnet>
	 <1109839245.4866.10.camel@nouse.net>
	 <20050303093949.GB3346@crusoe.alcove-fr>
	 <1109844371.4866.31.camel@nouse.net>  <1109884125.2102.781.camel@d845pe>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-5NibWwmabpoyNkRHCuPE"
In-Reply-To: <1109884125.2102.781.camel@d845pe>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: John Belmonte <john-wanGne27zNesTnJN9+BGXg@public.gmane.org>, Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>, Karol Kozimor <sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>, Luming Yu <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, toshiba_acpi-7wiBuN1tZDdg9hUCZPvPmw@public.gmane.org, vojtech-IBi9RG/b67k@public.gmane.org, Stelian Pop <stelian-ibX4/ixPftWsTnJN9+BGXg@public.gmane.org>, ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org


--=-5NibWwmabpoyNkRHCuPE
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,

thanks for opening this discussion.

On Thu, 2005-03-03 at 16:08 -0500, Len Brown wrote:
>It is great that programmers -- sometimes with little or no

[...]

>As I've said before, it is fine with me for exotic drivers
>to handle exotic hardware -- nobody wants to muck-up generic
>code for a few exotics.  But we need a design where
>standard systems we've never heard of "just work";
>and we need to make the use, administration, and support
>of exotic systems as much like standard sytems
>as possible.

Yes.  What do you think of providing an API for specific drivers as
proposed by Stelian on acpi-devel before?  We then could move the
specific drivers out of the ACPI maintree.

Regarding hotkeys for example we could provide an interface which is
used by the specific drivers to report events.  Such events would be
reported into user-space like the one's triggered by the generic driver.
Perhaps by using the Linux input core.  But I guess this still needs to
be discussed thoroughly.

[...]

>I believe that Bruno's generic video driver (in tree)
>is a step in this direction.  I believe that Luming's
>generic hot key driver (on list, but not yet in tree)
>is a step in this direction.  Are either of these
>"final"?  heck no, but I'm confident that they're
>heading us in the right direction.
>
>I plan to pull Luming's hot-key driver into the ACPI patch
>soon -- the only reason we didnt' do it earlyer is because
>the previous version would have immediately broken the
>existing platform specific drivers...

Luming, can you please give some comment on the state of your driver?

>We also need to think about the kernel<->user interface
>we've currently got.
>
>We need to think through the suggestion that hot keys
>should appear to Linux like other keyboard keys -- and
>wind their way throught the input layer.  I think the important
>thing will be what the user or administrator has to do in
>order to map which keys to which functions; and if this
>can work automatically without a call to 1-800-distro.

I will write some document which will pinpoint the current problems
depending on vendor and/or machine.  For that purpose I'll have quite a
few machines provided by the SUSE Labs. For other systems I will call
users for help.

[...]

We still have to face the fact that we will not be able to cover all
systems by a generic driver.  Vendors are -- and will -- go their own
way. See Sony and Toshiba for example.  Since we do not want to clutter
the generic driver with exceptions we will have to find a proper design
for implementing specific drivers.

Maybe the number of systems which require a specific driver will
decrease -- but never to zero.

I've added Andrew and John to cc.

See you,

  -- Timo

..............................................................
Timo H=F6nig <thoenig at nouse dot net>
..................................................:: gpg ::...
Fingerprint: 0998 0ACA A1D2 2612 4D96 DD8B E03F 084B B305 4066

--=-5NibWwmabpoyNkRHCuPE
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQBCKCuw4D8IS7MFQGYRAk36AJ94bHvrByMNq4WGtsbZK2HFqI+c7QCeKURn
vcX1BIgttkmVQlwnwrMR7zk=
=vMdO
-----END PGP SIGNATURE-----

--=-5NibWwmabpoyNkRHCuPE--



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
