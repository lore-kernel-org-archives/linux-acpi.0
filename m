From: "=?iso-8859-2?q?Zdzis=B3aw_A=2E?= Kaleta" <sanskryt-FWhLrETftxM@public.gmane.org>
Subject: Re: Re: Smart Battery System driver
Date: Fri, 21 Jan 2005 15:17:28 +0100
Message-ID: <200501211517.28563.sanskryt@op.pl>
References: <41E81C2C.8010809@bartol.udel.edu> <41F10180.60008@arrakis.dhis.org> <41F1031E.60507@bartol.udel.edu>
Reply-To: sanskryt-FWhLrETftxM@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <41F1031E.60507-OBnUx95tOyn10jlvfTC4gA@public.gmane.org>
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
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Dnia pi=B1tek 21 stycznia 2005 14:26, Rich Townsend napisa=B3:
> Pedro Venda wrote:
> > Johan Vromans wrote:
> > | Rich Townsend <rhdt-OBnUx95tOyn10jlvfTC4gA@public.gmane.org> writes:
> > |>I do this because everything in /lib/modules/XXX/kernel/* gets
> > |>clobbered when you do a make modules_install from the kernel source
> > |>tree;
> > |
> > | I see.
> > |
> > |>I have recently realized that the whole SBS functionality can be
> > |>implemented in terms of control methods in the DSDT, without the
> > |>need for any kernel drivers.
> > |
> > | Nice. This would require a kernel recompile/reboot  for each DSDT
> > | modification...
> >
> > not nice, I guess. 99.9% of the interested (me included) wouldn't be
> > able to
> > patch their DSDT and with generated ASL (is it ASL or AML or... ACPI
> > language)
> > code for their specific case.
>
> What if you just had to run a perl script, and then add an "initrd=3D"
> line to your kernel boot parameters? Because the code would be *so* much
> cleaner if a lot of the tasks were moved to the DSDT; in particular, we
> could get rid of i2c_acpi_sbs, and thus remove the dependency of ACPI on
> I2C.
>
> cheers,
>
> Rich
What about people who didn't use initrd in their kernel?
=2D-=20
z.a.kaleta (sanskryt), registered Linux User #279350


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
