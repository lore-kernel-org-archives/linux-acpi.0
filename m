From: "Wang, Zhenyu Z" <zhenyu.z.wang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: [PATCH 2/2] acpi_bus_register_driver conflict fix in acpi drivers
Date: Fri, 12 Nov 2004 14:45:18 +0800
Message-ID: <9DE394C12A921946AEECE1F71944ECD58E413E@pdsmsx404>
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
To: Dave Jones <davej-bguaPGIxBblWITc6zSkvfdi2O/JbrIOy@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-acpi <linux-acpi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Dave Jones wrote:
> On Fri, Nov 12, 2004 at 02:29:41PM +0800, Wang, Zhenyu Z wrote:
>=20
>  > This patch is accord with acpi_bus_register_driver return value
>  fix. > acpi driver won't cause any side effect if no device found to
>  that > driver.
>  > After this patch, output on my dell looks like:
>  > ACPI: AC [not found]
>  > ACPI: Asus_acpi [not found]
>  > ACPI: Battery [not found]
>  > ACPI: Power Button (FF) [PWRF]
>  > ACPI: Fan [not found]
>  > ACPI: Processor [CPU0] (supports C1)
>  > ACPI: Thermal [not found]
>  >
>  > which tell "not found" devices that acpi can't handle on that box.
>=20
> Why on earth would we want to clutter the boot logs like this ?
> ACPI is by far one of the most verbose subsystems already,
> without making the problem worse.
>=20
> 		Dave

Ok, blame me. it's for my own test now, removing them is ok.

thanks,
-zhen


-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
