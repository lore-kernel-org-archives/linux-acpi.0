From: Stefan Seyfried <seife-T+3qhDtrTvDv8lqoKu5MV4HBZQ1bDw0s@public.gmane.org>
Subject: Re: bug in acpid scripts
Date: Fri, 13 Aug 2004 08:18:40 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040813061840.GA12794@message-id.gmane0305.slipkontur.de>
References: <B44D37711ED29844BEA67908EAF36F038AD732@pdsmsx401.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <B44D37711ED29844BEA67908EAF36F038AD732-4yWAQGcml65pB2pF5aRoyrfspsVTdybXVpNB7YpNyf8@public.gmane.org>
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

On Thu, Aug 12, 2004 at 03:07:17PM +0800, Li, Shaohua wrote:

> Here is it. The patch is very sample. I didn't observe any side effect
> of this patch, but maybe it must be tested widely. Could you please try
> it?

can this work? I have not tested but it seems strange to me.
acpi_event_is_masked vs. acpi_event_is_mask

===== drivers/acpi/bus.c 1.42 vs edited =====
+extern int			acpi_event_is_masked;
[...]
+	if (!event_is_open || acpi_event_is_masked)

===== drivers/acpi/event.c 1.5 vs edited =====
+int				acpi_event_is_mask;
 
===== drivers/acpi/sleep/main.c 1.38 vs edited =====
+extern int acpi_event_is_mask;
[...]
+	acpi_event_is_mask = 1;
[...]
+	acpi_event_is_mask = 0;
-- 
Stefan Seyfried



-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
