From: Dave Jones <davej-bguaPGIxBblWITc6zSkvfdi2O/JbrIOy@public.gmane.org>
Subject: Re: [PATCH 2/2] acpi_bus_register_driver conflict fix in acpi drivers
Date: Fri, 12 Nov 2004 06:37:44 +0000
Message-ID: <20041112063744.GA19373@kernelslacker.org>
References: <9DE394C12A921946AEECE1F71944ECD58E4126@pdsmsx404>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <9DE394C12A921946AEECE1F71944ECD58E4126@pdsmsx404>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Wang, Zhenyu Z" <zhenyu.z.wang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: "Li, Shaohua" <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-acpi <linux-acpi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, "Fu, Michael" <michael.fu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Liu, Bing Wei" <bing.wei.liu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Fri, Nov 12, 2004 at 02:29:41PM +0800, Wang, Zhenyu Z wrote:

 > This patch is accord with acpi_bus_register_driver return value fix.
 > acpi driver won't cause any side effect if no device found to that
 > driver. 
 > After this patch, output on my dell looks like:
 > ACPI: AC [not found]
 > ACPI: Asus_acpi [not found]
 > ACPI: Battery [not found]
 > ACPI: Power Button (FF) [PWRF]
 > ACPI: Fan [not found]
 > ACPI: Processor [CPU0] (supports C1)
 > ACPI: Thermal [not found]
 > 
 > which tell "not found" devices that acpi can't handle on that box.

Why on earth would we want to clutter the boot logs like this ?
ACPI is by far one of the most verbose subsystems already,
without making the problem worse.

		Dave



-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
