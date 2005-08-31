From: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: ACPI Linux: acpi_get_firmware fix
Date: Wed, 31 Aug 2005 16:37:43 -0400
Message-ID: <1125520663.16880.41.camel@toshiba>
References: <1121264876.8504.24.camel@firedrake.mandriva.com>
	 <1121270181.8504.28.camel@firedrake.mandriva.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1121270181.8504.28.camel-UvLOT2mcgw93qojSD/UXlMfpnLc0EkqF@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Yann Droneaud <ydroneaud-4qZELD6FgxhWk0Htik3J/w@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>, "Moore, Robert" <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Applied.

thanks,
-Len

-----------
Index: linux-acpi-2.6/drivers/char/ipmi/ipmi_si_intf.c
===================================================================
--- linux-acpi-2.6.orig/drivers/char/ipmi/ipmi_si_intf.c
+++ linux-acpi-2.6/drivers/char/ipmi/ipmi_si_intf.c
@@ -1484,6 +1484,9 @@ static int try_init_acpi(int intf_num, s
        char             *io_type;
        u8               addr_space;

+       if (acpi_disabled)
+               return -ENODEV;
+
        if (acpi_failure)
                return -ENODEV;





-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
