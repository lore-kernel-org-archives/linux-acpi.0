From: "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: Missing Sleep State object on thinkpad
Date: Mon, 11 Oct 2004 23:35:29 +0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3ACA40606221794F80A5670F0AF15F8405C29CE8@pdsmsx403>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-class: urn:content-classes:message
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Jesse Stockall <stockall-J4oS66wZXds@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hmmm.., I'm trying to download the acpidmp output you attached,
But there seems to have bandwidth issue to me. :-(

According to ACPI spec, all system states supported by the system
must provide a package with two values: the first is the SLP_TYPa value
and the secnod is the SLP_TYPb value. If the object is missing, then
OSPM
assumes the hardware does not support that sleeping state.

So, "Error: Missing Sleep State object" you found means NO s3 support
for
your 600x, if ACPI interpreter was reporting correctly.

To verify it, just simply do "cp /proc/acpi/dsdt  ./dsdt.dat; iasl -d
/proc/acpi/dsdt",=20
and go searching for _S3 or _S1. And post the searching result.

Thanks,
Luming=20
=20

>-----Original Message-----
>From: Jesse Stockall [mailto:stockall-J4oS66wZXds@public.gmane.org]=20
>Sent: Monday, October 11, 2004 10:48 PM
>To: Yu, Luming
>Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
>Subject: RE: [ACPI] Missing Sleep State object on thinkpad
>
>On Sat, 2004-10-09 at 11:04, Yu, Luming wrote:
>> Would you please sent out output of acpidmp.
>> Since this list has size limit of 80k, I suggest you
>> to file it at bugzilla.kernel.org in ACPI category.
>>=20
>
>Hi
>
>Not sure if you got the bugzilla emails, so...
>
>http://bugme.osdl.org/show_bug.cgi?id=3D3534
>
>Thanks
>
>Jesse
>
>--=20
>Jesse Stockall <stockall-J4oS66wZXds@public.gmane.org>
>
>


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
