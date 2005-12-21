From: "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: [PATCH][RESEND] ACPI EC driver on IA64
Date: Tue, 20 Dec 2005 22:28:57 -0500
Message-ID: <F7DC2337C7631D4386A2DF6E8FB22B30057DD0C3@hdsmsx401.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-2022-jp"
Content-Transfer-Encoding: 7bit
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
To: Kenji Kaneshige <kaneshige.kenji-+CUm20s59erQFUHtdCDX3A@public.gmane.org>, Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Applied.

(note that x86_64 includes CONFIG_X86, so this changes IA64 only)

thanks,
-Len 

>-----Original Message-----
>From: Kenji Kaneshige [mailto:kaneshige.kenji-+CUm20s59erQFUHtdCDX3A@public.gmane.org] 
>Sent: Tuesday, December 20, 2005 10:24 PM
>To: Brown, Len; Andrew Morton; acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
>Subject: [PATCH][RESEND] ACPI EC driver on IA64
>
>Hi,
>
>This is the resend of the patch I posted before at
>
>	http://sourceforge.net/mailarchive/message.php?msg_id=14090410
>
>Please apply.
>
>Thanks,
>Kenji Kaneshige
>
>
>This patch removes "depends on X86" from config ACPI_EC. With this
>patch, ACPI EC driver will be built also on x86_64 and ia64.
>
>Signed-off-by: Kenji Kaneshige <kaneshige.kenji-+CUm20s59erQFUHtdCDX3A@public.gmane.org>
>
> drivers/acpi/Kconfig |    1 -
> 1 files changed, 1 deletion(-)
>
>Index: linux-2.6.15-rc6/drivers/acpi/Kconfig
>===================================================================
>--- linux-2.6.15-rc6.orig/drivers/acpi/Kconfig
>+++ linux-2.6.15-rc6/drivers/acpi/Kconfig
>@@ -269,7 +269,6 @@ config ACPI_DEBUG
> 
> config ACPI_EC
> 	bool
>-	depends on X86
> 	default y
> 	help
> 	  This driver is required on some systems for the 
>proper operation of
>


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
