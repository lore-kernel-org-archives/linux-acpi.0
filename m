From: Nathan Bryant <nbryant-p32f3XyCuykqcZcGjlUOXw@public.gmane.org>
Subject: Re: bug in acpid scripts
Date: Thu, 12 Aug 2004 20:24:59 -0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <411C0A5B.3060606@optonline.net>
References: <B44D37711ED29844BEA67908EAF36F038AD732@pdsmsx401.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Boundary_(ID_FfR0w0k6mkUAGc4xlMdBeA)"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-reply-to: <B44D37711ED29844BEA67908EAF36F038AD732-4yWAQGcml65pB2pF5aRoyrfspsVTdybXVpNB7YpNyf8@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Li, Shaohua" <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: russell-1vnkWVZi4QaVc3sceRu5cw@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

This is a multi-part message in MIME format.

--Boundary_(ID_FfR0w0k6mkUAGc4xlMdBeA)
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7BIT

Li, Shaohua wrote:

>Russell Neches Sunday, July 25, 2004 9:42 AM wrote:
>  
>
>>To: Li, Shaohua
>>Cc: ACPI-Devel
>>Subject: RE: [ACPI] bug in acpid scripts
>>
>>Neat! I'd like to help test your patch, if you wouldn't mind posting
>>    
>>
>it.
>  
>
>>Is there anything specific behavior (good or bad) you would like me to
>>check for?
>>    
>>
>Here is it. The patch is very sample. I didn't observe any side effect
>of this patch, but maybe it must be tested widely. Could you please try
>it?
>  
>
Shaohua,

My system has the same problem. Unfortunately, your patch doesn't fix 
it. Also, I had to apply the attached just to get it to build (against 
current -rc4 bitkeeper plus linux-acpi-test-2.6.8)

Nathan

--Boundary_(ID_FfR0w0k6mkUAGc4xlMdBeA)
Content-type: text/plain; name=maskevent.patch2
Content-transfer-encoding: 7BIT
Content-disposition: inline; filename=maskevent.patch2

===== drivers/acpi/bus.c 1.43 vs edited =====
--- 1.43/drivers/acpi/bus.c	2004-08-12 02:39:43 -04:00
+++ edited/drivers/acpi/bus.c	2004-08-12 20:09:51 -04:00
@@ -283,7 +283,7 @@
 DECLARE_WAIT_QUEUE_HEAD(acpi_bus_event_queue);
 
 extern int			event_is_open;
-extern int			acpi_event_is_masked;
+static int			acpi_event_is_masked;
 
 int
 acpi_bus_generate_event (

--Boundary_(ID_FfR0w0k6mkUAGc4xlMdBeA)--


-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
