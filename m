From: "Wang, Zhenyu Z" <zhenyu.z.wang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 0/2] acpi_bus_register_driver conflict fix patches announce
Date: Fri, 12 Nov 2004 14:12:10 +0800
Message-ID: <9DE394C12A921946AEECE1F71944ECD58E40FF@pdsmsx404>
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
To: "Li, Shaohua" <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-acpi <linux-acpi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, "Fu, Michael" <michael.fu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Liu, Bing Wei" <bing.wei.liu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi,

These patches are the result of discussion with Shaohua.=20
Current acpi_bus_register_driver does _not_ implement correctly accord
with its comment description.
It should return number of devices claimed by the driver, or negative
error, but it doesn't do that now.
This flaw causes side effect like some empty directory in
/proc/acpi/<device>, which shouldn't exist if the=20
driver doesn't find any devices.
So these patches are created to resolve this issue. They are tested on
my dell desktop.=20
Pls help to review it, and Len please consider to merge it.

thanks,
-zhen
Li, Shaohua wrote:
> Oh, It's my bad. The PCI root driver and some other drivers are
> loaded before ACPI scan, but it doesn't matter. We only care about
> ac, fan, and such devices here. =20
> Please don't return -1 if count is 0. Before acpi start scanning (so
> no any devices found), acpi_bus_register_driver will always return 0,
> with your change which will make pci_root, pci_link (they use
> subsys_init also just like scan.c) failed.  =20
>> -----Original Message-----
>> From: Wang, Zhenyu [mailto:zhenyu.z.wang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org]
>> Sent: Thursday, November 11, 2004 4:58 PM
>> To: Li, Shaohua
>> Cc: linux-acpi
>> Subject: Re: [How about add info in acpi device /proc directory?
>> was:[ACPI] ACPI fan not always working]=20
>>=20
>> On 2004.11.11 17:21:15 +0000, Li, Shaohua wrote:
>>> I agree with you. We should fix the return value.
>>> Your patch is ok for loadable module driver, but it isn't
>>> sufficient, some drivers are loaded before ACPI start scanning
>>> devices.=20


-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
