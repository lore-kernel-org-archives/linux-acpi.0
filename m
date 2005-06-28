From: Klaus Muth <muth-5lHx5lHeYlQ@public.gmane.org>
Subject: Re: ACPI: RSDP - ERROR: Invalid checksum
Date: Tue, 28 Jun 2005 09:24:58 +0200
Message-ID: <200506280925.00165.muth@hagos.de>
References: <200506071546.57120.muth@hagos.de> <200506081529.49355.muth@hagos.de> <200506091113.14327.muth@hagos.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200506091113.14327.muth-5lHx5lHeYlQ@public.gmane.org>
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

Am Donnerstag, 9. Juni 2005 11:13 schrieb Klaus Muth:

> It seems to happen, that the IBM BIOS contains just the string "RSD PTR "
> exactly at a 16-Byte-Boundary before the real RSDP block, so the wrnog
> address is returned and acpi_table_init() in drivers/acpi/tables.c fails to
> checksum this block of course.
[... 2.4 kernel finding the real RSDP ...]
> Is there any patch to do the same with a vanilla 2.6 Kernel?

Ahem. Did I hit a FAQ? If so: I could not find the answer. Could just someone 
be so kind to point me in the right direction?

TIA
-- 
Klaus Muth
HAGOS eG                      Industriestr. 62      fon: (+49) 711 78805-86
EDV-Programmierung            70565  Stuttgart      fax: (+49) 711 78805-35
http://www.hagos.de               Germany              mailto:muth-5lHx5lHeYlQ@public.gmane.org


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
