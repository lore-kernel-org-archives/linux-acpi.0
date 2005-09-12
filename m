From: Yann Droneaud <ydroneaud-4qZELD6FgxhWk0Htik3J/w@public.gmane.org>
Subject: Re: ACPI Linux: acpi_get_firmware fix
Date: Mon, 12 Sep 2005 13:44:52 +0200
Message-ID: <200509121344.53063.ydroneaud@mandriva.com>
References: <1121264876.8504.24.camel@firedrake.mandriva.com> <1121270181.8504.28.camel@firedrake.mandriva.com> <1125520663.16880.41.camel@toshiba>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1125520663.16880.41.camel@toshiba>
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
To: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>, "Moore, Robert" <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Wednesday 31 August 2005 22:37, Len Brown wrote:
> Applied.
>
> thanks,


I see the changelog here:
http://lkml.org/lkml/mbox/2005/9/8/30

The two bugs and patches, I sent are fixed in this tree
(event if I'm not credited for this fix:
 
   Added a check for a null RSDT pointer in
    acpi_get_firmware_table (tbxfroot.c) to prevent a fault
    in this error case.

Perhaps you fixed it too. Doesn"t really matter in fact).

Thank you.

(Sorry for this late answer, i was in holiday for a week and half).

Regards.

-- 
Yann Droneaud


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
