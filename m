From: "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: Missing Sleep State object on thinkpad
Date: Sat, 9 Oct 2004 23:04:19 +0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3ACA40606221794F80A5670F0AF15F8405BD1222@pdsmsx403>
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
To: Jesse Stockall <stockall-J4oS66wZXds@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Would you please sent out output of acpidmp.
Since this list has size limit of 80k, I suggest you
to file it at bugzilla.kernel.org in ACPI category.

Thanks=20
Luming


>-----Original Message-----
>From: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org=20
>[mailto:acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org] On Behalf Of=20
>Jesse Stockall
>Sent: Saturday, October 09, 2004 10:34 PM
>To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
>Subject: [ACPI] Missing Sleep State object on thinkpad
>
>Hi
>
>I have an IBM 600x Thinkpad
>
>Using 2.6.9-rc3 I get the following error while booting:
>
>ACPI: (supports S0 S1  hwregs-0169: *** Error: Missing Sleep State
>object
>  hwregs-0208 [46] acpi_get_sleep_type_da: While evaluating sleep_state
>[\_S3_], bad Sleep object 00000000 type [NULL Object Descriptor]
> S4 S5)
>
>I applied acpi-20040816-26-latest-release.diff.gz
>
>With the same results except that I no longer get the debug=20
>output, even
>though CONFIG_ACPI_DEBUG=3Dy
>
>dmesg and config from 2.6.9.-rc3 plus acpi patch are attached
>
>Thanks
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
