From: "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: Missing Sleep State object on thinkpad
Date: Tue, 12 Oct 2004 00:42:25 +0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3ACA40606221794F80A5670F0AF15F8405C29D04@pdsmsx403>
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
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, "Moore, Robert" <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hmmm,  your 600x should have S3 support.
The root cause of failure is that  linux is using element in
const char      *acpi_gbl_sleep_state_names[ACPI_S_STATE_COUNT] =3D
{
        "\_S0_",
        "\_S1_",
        "\_S2_",
        "\_S3_",
        "\_S4_",
        "\_S5_"
};

to call acpi_get_sleep_type_data, but your box define _S3 under the
device PNP0A03. So, the evaluating \_S3 will fail.
We can come up with a workaround for this case soon.

Thanks,
Luming

=20


>> To verify it, just simply do "cp /proc/acpi/dsdt  ./dsdt.dat; iasl -d
>> /proc/acpi/dsdt",=20
>> and go searching for _S3 or _S1. And post the searching result.
>>=20
>
>There are 2 references to both _S1 and _S3 the first are at line 941=20
>(see attached file) inside the declaration of the device named=20
>"PNP0A03"
>
>Name (_S1D, 0x01)
>Name (_S3D, 0x01)
>
>The other references are:
>
>    Name (\_S1, Package (0x04)
>    {
>        0x04,=20
>        0x04,=20
>        0x00,=20
>        0x00
>    })
>    Method (_S3, 0, NotSerialized)
>    {
>        If (BXPT)
>        {
>            Return (Package (0x04)
>            {
>                0x06,=20
>                0x06,=20
>                0x00,=20
>                0x00
>            })
>        }
>        Else
>        {
>            Return (Package (0x04)
>            {
>                0x01,=20
>                0x01,=20
>                0x00,=20
>                0x00
>            })
>        }
>    }
>
>Thanks for looking in to this
>
>Jesse
>
>--=20
>Jesse Stockall <stockall-J4oS66wZXds@public.gmane.org>
>


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
