From: "Moore, Robert" <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: DSDT from within windows?
Date: Mon, 31 Jan 2005 13:18:41 -0800
Message-ID: <971FCB6690CD0E4898387DBF7552B90E7129AB@orsmsx403.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-class: urn:content-classes:message
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Starikovskiy, Alexey Y" <alexey.y.starikovskiy-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Bernard Blackham <bernard-4vSAtV5O1nc0n/F98K4Iww@public.gmane.org>, Jing Su <gargamel.su-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, "Walz, Michael" <michael.walz-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Seems like the SSDT(s) are not present in the registry, at least with
XP.

iASL -g will grab these tables out of the registry;  I have not seen an
SSDT under HKEY_LOCAL_MACHINE\HARDWARE\ACPI, however.

> -----Original Message-----
> From: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org [mailto:acpi-devel-
> admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org] On Behalf Of Starikovskiy, Alexey Y
> Sent: Monday, January 31, 2005 2:12 AM
> To: Bernard Blackham; Jing Su
> Cc: Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> Subject: RE: [ACPI] DSDT from within windows?
>=20
> It's in registry, with all other ACPI tables:
>=20
> HKEY_LOCAL_MACHINE\HARDWARE\ACPI\DSDT
>=20
>=20
> Regards,
> 	Alex.
> >-----Original Message-----
> >From: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org [mailto:acpi-devel-
> >admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org] On Behalf Of Bernard Blackham
> >Sent: Monday, January 31, 2005 5:55 AM
> >To: Jing Su
> >Cc: Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> >Subject: Re: [ACPI] DSDT from within windows?
> >
> >On Sun, Jan 30, 2005 at 09:41:03PM -0500, Jing Su wrote:
> >> I wondered if maybe Windows also allows OEMs to over-ride the
> >> DSDT.  Maybe the hardware guys only had limited time to
> >> provide a hacked up version, and their driver writers  provide a
> >> patched one later.
> >>
> >> I've tried some googling, but found no hits thus far.  Anyone know
if
> >> it's possible to pull the active DSDT from a running Windows XP
> >> session?
> >
> >I've no idea how to get it from a live session, but perhaps you
> >could grep the windows folder for the string "DSDT" to see what
> >turns up?
> >
> >Bernard.
> >
> >--
> > Bernard Blackham <bernard at blackham dot com dot au>
> >
> >
> >-------------------------------------------------------
> >This SF.Net email is sponsored by: IntelliVIEW -- Interactive
Reporting
> >Tool for open source databases. Create drag-&-drop reports. Save time
> >by over 75%! Publish reports on the web. Export to DOC, XLS, RTF,
etc.
> >Download a FREE copy at http://www.intelliview.com/go/osdn_nl
> >_______________________________________________
> >Acpi-devel mailing list
> >Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> >https://lists.sourceforge.net/lists/listinfo/acpi-devel
>=20
>=20
> -------------------------------------------------------
> This SF.Net email is sponsored by: IntelliVIEW -- Interactive
Reporting
> Tool for open source databases. Create drag-&-drop reports. Save time
> by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
> Download a FREE copy at http://www.intelliview.com/go/osdn_nl
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/acpi-devel


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
