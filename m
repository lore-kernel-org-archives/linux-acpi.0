From: Luis Henriques <luis.henriques-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>
Subject: Re: [PATCH][v3.16.y-ckt] ACPICA: Add new GPE public interface -
 acpi_mark_gpe_for_wake.
Date: Fri, 16 Jan 2015 14:21:46 +0000
Message-ID: <20150116142146.GD2438@charon>
References: <54B820E7.4080406@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <54B820E7.4080406-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Joseph Salisbury <joseph.salisbury-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>
Cc: "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Len Brown <lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Thu, Jan 15, 2015 at 03:19:51PM -0500, Joseph Salisbury wrote:
> Hello,
>=20
> Please consider including mainline commit c12f07d and bd9b2f9 in the
> next v3.16.y-ckt release.  They
> were included in the mainline tree as of v3.17-rc1.  A test kernel ha=
s
> been built and tested, which was confirmed to resolve:
> http://bugs.launchpad.net/bugs/1406767 .
>=20
> commit c12f07d17c12193256a99e20c9a0f130fb8f7be8
> Author: Rafael J. Wysocki <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> Date:   Wed Jul 23 13:12:16 2014 +0800
>=20
>     ACPICA: Add new GPE public interface - acpi_mark_gpe_for_wake.
>=20
>=20
> Commit c12f07d does not cherry-pick cleanly in 3.16.y.  However, it w=
ill
> if commit bd9b2f9aff26c185c1f8e0cd08a850ee4ace391a is cherry picked f=
irst:
>=20
> commit bd9b2f9aff26c185c1f8e0cd08a850ee4ace391a
> Author: Rafael J. Wysocki <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> Date:   Mon Jul 14 22:41:41 2014 +0200
>=20
>     ACPI / scan: No implicit wake notification for buttons
>=20
>   =20
>=20
>

Thanks, I'll queue both commits to the 3.16 kernel.

Cheers,
--
Lu=EDs


> Sincerely,
> Joseph Salisbury
>=20
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe stable" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
