From: "Li, Shaohua" <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: [RFC/patch] ACPI in linux PnP layer
Date: Thu, 9 Sep 2004 10:57:37 +0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <16A54BF5D6E14E4D916CE26C9AD30575168C38@pdsmsx402.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
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
To: castet.matthieu-GANU6spQydw@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi Matthieu,
Great work! We are eager for this staff for a long time. I have some
generic comments for your patches.

On Wednesday, September 08, 2004, castet.matthieu-GANU6spQydw@public.gmane.org wrote:
>Hi,
>
>I have started to plug acpi in PnP layer.
>A first patch add the function acpi_driver_scan, that allow to call a
>function
>for each acpi device.
>I have to do that because acpi is load before PnP, and it can't add my
>function
>in acpi_bus_add (driver/acpi/scan.c).
This possible is not required. We can use 'acpi_walk_namespace' and
'acpi_bus_get_device' to reach the same goal.

>The second patch is the PnP acpi driver.
>It parse possible and activated resources.
>It use acpi_register_gsi to activate irq (is that need ???)
Your patch just checked the PNP id length to verify if it's a PNP
device. This isn't sufficient, such as ACPI EC device has PNP id
'PNP0C09', but ACPI core should control it instead of PNP.

>Also there are no disable/set acpi resource support, nor ADDRESS
resource
>support.
You can _CRS, _SRS and other ACPI methods for disable/set acpi resource
support.
Thanks your patches. We are glad to work with you to make it available.

Thanks,
Shaohua


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
