From: "Moore, Robert" <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: acpi-ca reports \_SB as a device
Date: Mon, 10 Jan 2005 10:12:38 -0800
Message-ID: <971FCB6690CD0E4898387DBF7552B90E3900E6@orsmsx403.amr.corp.intel.com>
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
To: Nate Lawson <nate-Y6VGUYTwhu0@public.gmane.org>, ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Cc: acpi-HZy0K5TPuP5AfugRpC6u6w@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

For _SB_, this allows the _SB_._INI method to be run.

For _TZ, this allows notifies on the _TZ object.  Some ASL code does
this.


> -----Original Message-----
> From: Nate Lawson [mailto:nate-Y6VGUYTwhu0@public.gmane.org]
> Sent: Saturday, January 08, 2005 1:05 AM
> To: ACPI Developers
> Cc: acpi-HZy0K5TPuP5AfugRpC6u6w@public.gmane.org
> Subject: acpi-ca reports \_SB as a device
>=20
> If you call AcpiGetType on \_SB, you get "device" and \_TZ gives
> "thermal".  I don't think this is valid since these are system scopes,
> not devices and thermal zones.
>=20
> I found this while testing a patch that scans the whole namespace (\)
> for devices.  It turns out some systems put PCI link devices (PNP0C0F)
> in \, so we weren't probing them.
>=20
> --
> Nate


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
