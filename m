From: <foo_bar_baz_boo-acpi-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>
Subject: Re: Battery not visible?
Date: Thu, 20 Oct 2005 14:16:32 -0700 (PDT)
Message-ID: <20051020211633.31550.qmail@web81605.mail.yahoo.com>
References: <1129835275.5487.8.camel@AMD-2600>
Reply-To: foo_bar_baz_boo-acpi-/E1597aS9LQAvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1129835275.5487.8.camel@AMD-2600>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Daniel Pekelharing <legendstar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Acpi-Devel-List <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

The usual fix for AE_TIME errors: try booting latest kernel.org 2.6.xx
kernel with proper configuration for your hardware, and set kernel boot
option "ec_burst=3D1".

HTH!

--- Daniel Pekelharing <legendstar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:

> Hi all,
>=20
> I just bought a new laptop, an Acer Aspire 3613WLMI,
>=20
> I have installed Fedora Core 4 on it (after erasing the XP-Home that
> it
> came with).
>=20
> I seem to have a problem with ACPI, the battery is not visible.
> i.e. ls /proc/acpi/battery is empty, and the gnome charge monitor
> icon
> reports battery status unknown.. it does however correctly report
> whether the AC adapter is plugged in or not.
>=20
> "dmesg | grep ACPI" reports some errors, but I have no idea what they
> mean.. I have attached a text file with my output.
>=20
> Any help/ideas appreciated,
>=20
> Thanks!
>=20
> --=20
> Daniel Pekelharing
> <legendstar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
