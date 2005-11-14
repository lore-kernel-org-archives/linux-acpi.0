From: David =?utf-8?B?R8OzbWV6?= <david-0d+f1cuTMnnk1uMJSBkQmQ@public.gmane.org>
Subject: Re: New Smart Battery release (incl. updated embedded controller patches)
Date: Mon, 14 Nov 2005 22:34:05 +0100
Message-ID: <20051114213405.GA1846@fargo>
References: <4376BD90.5080603@bartol.udel.edu> <200511141805.54633.luming.yu@intel.com> <20051114121512.GB1570@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20051114121512.GB1570-I/5MKhXcvmPrBKCeMvbIDA@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Cc: "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Rich Townsend <rhdt-OBnUx95tOyn10jlvfTC4gA@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi Pavel,

On Nov 14 at 01:15:12, Pavel Machek wrote:
> > Nice to see update on smart battery.
> > I'm curious if you plan to have a smart battery driver without
> > hacking DSDT.
>=20
> I think that such support existed some time ago. IIRC resolution was
> that the support should really be in DSDT.

But that means that you need to use a patched DSDT, and in consequence
use initrd to get Smart Battery support, isn't it? In that case it'd
be good to have support for smart batteries in the kernel without
forcing to use initrd.

regards,

--=20
David G=C3=B3mez                                      Jabber ID: davidge@=
jabber.org


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Downl=
oad
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
