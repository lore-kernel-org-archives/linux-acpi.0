From: Dominik Brodowski <linux-X3ehHDuj6sIIGcDfoQAp7BvVK+yQ3ZXh@public.gmane.org>
Subject: [PATCHES] add _CST support
Date: Sat, 27 Nov 2004 22:51:18 +0100
Message-ID: <20041127215118.GA30309@dominikbrodowski.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jI8keyz6grp/JLjh"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
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
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


--jI8keyz6grp/JLjh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On top of the processor.c splitup patchset announced earlier today I've
rediffed, modified and split up the _CST patches originally developed by Br=
uno Ducrot=20
(i.e. the static approach, not my broken dynamic patch) and tracked at=20
http://bugme.osdl.org/show_bug.cgi?id=3D1958 .

A "bigdiff" which should apply cleanly on top of 2.6.10-rc2-mm3 is availabl=
e at
http://www.brodo.de/patches/2004-11-27/01-acpi-20041127-complete (~176KB)
and zipped
http://www.brodo.de/patches/2004-11-27/01-acpi-20041127-complete (~36KB)

To apply the following individual patches, you first need the processor.c s=
plitup patches:
http://www.brodo.de/patches/2004-11-27/01-acpi-20041127-processor-splitup-p=
erflib
http://www.brodo.de/patches/2004-11-27/02-acpi-20041127-processor-splitup-t=
hrottling
http://www.brodo.de/patches/2004-11-27/03-acpi-20041127-processor-splitup-i=
dle
http://www.brodo.de/patches/2004-11-27/04-acpi-20041127-processor-splitup-t=
hermal
http://www.brodo.de/patches/2004-11-27/05-acpi-20041127-processor-splitup-c=
ore
http://www.brodo.de/patches/2004-11-27/06-acpi-20041127-throttling-disablei=
rqsforshorterperiods

Please test + apply,
	Dominik



http://www.brodo.de/patches/2004-11-27/07-acpi-20041127-cst-type

It's important to make a difference between the actual C-States and the
_type_ of the C-State. While they're always equal for ACPI 1.0 systems,
they can differ for ACPI 2.0 or later systems. Therefore, use _type_
wherever appropriate.


http://www.brodo.de/patches/2004-11-27/08-acpi-20041127-fadtpblk

Split up the extraction of information from the FADT and the pblk_address
(acpi_processor_get_power_info_fadt()) and the validation whether the state
is indeed available (acpi_processor_power_verify()).


http://www.brodo.de/patches/2004-11-27/09-acpi-20041127-power-remove-defaul=
t-state

"default_state" is unused, so remove it.


http://www.brodo.de/patches/2004-11-27/10-acpi-20041127-make-power-state-a-=
pointer

Make the current "state" in struct acpi_processor_power a pointer. If it
doesn't exist, simply use C1 type sleep...


http://www.brodo.de/patches/2004-11-27/11-acpi-20041127-power-policy-indepe=
ndent-of-states

- make the state a pointer inside struct acpi_processor_cx_policy,
- make acpi_cstate_limit aware of c-state types instead of numbers, as the
	latter mean (almost) nothing
- make the policy decisions of demotion and promotion independent of
	the assumption "one state per type"


http://www.brodo.de/patches/2004-11-27/12-acpi-20041127-cst-parsing

Add parsing for _CST


http://www.brodo.de/patches/2004-11-27/13-acpi-20041127-cst-change

Add a notifier for _CST changing events. It is necessary to unload
the processor idle handle for a short period of time to avoid for nasty
races -- and we don't want to grab too many locks so that the idle handler
continues to be speedy.


http://www.brodo.de/patches/2004-11-27/14-acpi-20041127-cst-notify_smm

Notify the BIOS that we can handle _CST.


http://www.brodo.de/patches/2004-11-27/15-acpi-20041127-power-only-init-mod=
ify-exit

Consolidate code in processor_idle(). Only symbols "exported" are
_init(), _exit() and _cst_has_changed().


--jI8keyz6grp/JLjh
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQFBqPbWZ8MDCHJbN8YRAjlPAJ9HxfIk9uWW+fxnpXtiWVaztisDqwCeO6st
4Q8tUyyXVTQbbms3nCOESZg=
=7q++
-----END PGP SIGNATURE-----

--jI8keyz6grp/JLjh--


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
