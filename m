From: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [patch 09/12] acpi: video.c: properly remove notify handlers
Date: Thu, 11 Aug 2005 18:59:36 -0400
Message-ID: <1123801177.6574.13.camel@toshiba>
References: <200507300818.j6U8IYKd017318@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200507300818.j6U8IYKd017318-bipKiLWnuIsyyg0EjBt7GtHuzzzSOjJt@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: akpm-3NddpPZAyC0@public.gmane.org
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Andrew,
Please exclude acpi-videoc-properly-remove-notify-handlers.patch
from the -mm patch.

While it was correct to include it earlier, it is now
included in the git-acpi.patch and the version you've got in
2.6.13-rc5-mm1 appears to have been refreshed
such that it patches the wrong routine.
http://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.13-rc5/2.6.13-rc5-mm1/broken-out/acpi-videoc-properly-remove-notify-handlers.patch

acpi_video_bus_remove_fs() instead of acpi_video_bus_put_one_device()

thanks,
-Len




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
