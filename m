From: Nils Faerber <nils.faerber-t93Ne7XHvje5bSeCtf/tX7NAH6kLmebB@public.gmane.org>
Subject: Re: Slightly OT: Battery usage
Date: Mon, 06 Jun 2005 12:40:44 +0200
Message-ID: <42A4282C.7070808@kernelconcepts.de>
References: <m2br6jx2t1.fsf@phoenix.squirrel.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <m2br6jx2t1.fsf-KjnUIgV0B0bak1Ioo/c9IoRWq/SkRNHw@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Johan Vromans <jvromans-2pNSKKP3PSKEVqv0pETR8A@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Johan Vromans wrote:
> Thanks to Rich Townsend's work I can now see the astounding speed at
> which the Li-Ion battery of my Tavelmate degrades :-(.
> Is there a usage pattern that minimizes this? For example, always keep
> the batter maximally charged, or --the opposite-- always discharge full=
y
> before charging?

That is really OT but anyway interesting to PM so let's continue this.

As to all I know about Li-Ion and Li-Poly batteries should:

- - not be stored fully charged, charge to 30%-40% and the store at a coo=
l
place, like your food fridge, but always above 0=B0C!

- - not be charged to full all the time. All Li-* batteries like only to
be recharged after they have discharged for at least 10% or more (i.e.
max. 90% remaining). Before that they should not be recharged to full
again. Many notebook charging circuits do not honor this and kill their
batteries within approx. one year (my Asus L3C did this, my Fujitsu
Siemens Lifebook B-Series does not, IBM T42p does not, etc.)

- - be charged in at least two phases, first phase up to 75%-80% at full
charging current, after that only a very weak charging current should be
applied, like 10% of nominal current.

- - never be discharged completely, i.e. up to the point where the machin=
e
switches itself off.

Every charge/discharge discharge cycle reduces your battery's life!


> -- Johan
CU
  nils faerber

- --
kernel concepts          Tel: +49-271-771091-12
Dreisbachstr. 24         Fax: +49-271-771091-19
D-57250 Netphen          Mob: +49-176-21024535
- --
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFCpCgsJXeIURG1qHgRAj4pAKCVih+uYjJ4tdt9BjZElMhW6YOo6wCdF7Fz
qG0bA1oDQAEDmmtOZMhLtCQ=3D
=3D91dq
-----END PGP SIGNATURE-----


-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you sho=
tput
a projector? How fast can you ride your desk chair down the office luge t=
rack?
If you want to score the big prize, get to know the little guy. =20
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=3D20
