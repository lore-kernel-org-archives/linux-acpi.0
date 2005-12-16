From: "Moore, Robert" <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: RE: [PATCH 1/2] make acpi_path_name() global
Date: Fri, 16 Dec 2005 12:11:44 -0800
Message-ID: <971FCB6690CD0E4898387DBF7552B90E03BF8335@orsmsx403.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
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
To: "Shah, Rajesh" <rajesh.shah-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Alexey Starikovskiy <alexey.y.starikovskiy-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Suietov, Fiodor F" <fiodor.f.suietov-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Podrezov, Valery A" <valery.a.podrezov-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Randy Dunlap <randy_d_dunlap-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, pcihpd-discuss-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, "Accardi, Kristen C" <kristen.c.accardi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, gregkh-l3A5Bk7waGM@public.gmane.org, "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Therien, Guy" <guy.therien-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

AcpiGetName is in fact an external interface to ACPICA, and is declared
in acpixf.h.

The three headers that are intended to be "public" are as follows:

Acpiosxf.h - Interfaces to be implemented by the OS interface layer
(OSL).
Acpixf.h - Interfaces to ACPICA, to be used by drivers, etc.
Actypes.h - Types and structs required to use the public interfaces.

The naming convention for ACPICA is that all "non-public" interfaces
contain the prefix "Acpi??" where ?? is the short abbreviation for the
component (Ut =3D Utilities, Dm =3D Disassembler, etc.) Anything without =
the
?? abbreviation is a public interface. Rather than use another
abbreviation, we decided to just drop it for the public interfaces to
keep things short and descriptive.

To clarify things for the world, I would have no problem with renaming
the existing "acpi.h" to something else that indicates it is internal
only, and then renaming actypes.h to acpi.h (or acpica.h) and pulling in
both acpiosxf.h and acpixf.h within it.

This way, we could export acpi.h (or acpica.h) to the world as the
external header for ACPICA.

Bob


> -----Original Message-----
> From: Rajesh Shah [mailto:rajesh.shah-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org]
> Sent: Friday, December 16, 2005 10:39 AM
> To: Brown, Len
> Cc: Randy Dunlap; acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org; pcihpd-
> discuss-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org; Accardi, Kristen C; gregkh-l3A5Bk7waGM@public.gmane.org;
Moore,
> Robert
> Subject: Re: [ACPI] RE: [PATCH 1/2] make acpi_path_name() global
>=20
> On Thu, Dec 15, 2005 at 11:56:47PM -0500, Brown, Len wrote:
> >
> > an example of this is acpi_get_name(), which as declared
> > isn't supposed to be available outside the core.
> > All the uses of it to print ACPI namespace tokens in /proc
> > are totally bogus and should be deleted.  The other use
> > of it is to print out debug strings -- stuff the OS
> > doesn't really need to "know" and maybe something the
> > core should do for it.  That leaves the hotplug use,
> > which I don't understand.  What does SATA need
>=20
> Hotplug drivers use it to print where we found good, bad or missing
> ACPI methods like _HPP, OSHP, _OSC that we need to work properly.
> This is very useful as a debug aid, since ACPI namespace problems
> have always been the number one reason why the hotplug drivers
> fail to work.
>=20
> thanks,
> Rajesh



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
