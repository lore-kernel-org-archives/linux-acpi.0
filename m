From: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>
Subject: Fw: powersave not working with amd64 on nforce 4 board
Date: Wed, 27 Jul 2005 16:16:46 -0700
Message-ID: <20050727161646.05c40b3a.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
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
Cc: Florian Engelhardt <flo-MALAOO1t6vMdnm+yROfE0A@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org


It might help if you were to raise a bugzilla entry for this..

Begin forwarded message:

Date: Thu, 28 Jul 2005 00:26:18 +0200
From: Florian Engelhardt <flo-MALAOO1t6vMdnm+yROfE0A@public.gmane.org>
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Subject: powersave not working with amd64 on nforce 4 board


Hello,

powersaving is not working with a 2.6.12-rc3-mm1 kernel and a amd64
3500+ on a nvidia nforce 4 mainboard.
syslog tells me the following about it:

...
ACPI: Processor [CPU0] (supports 8 throttling states)
...
powernow-k8: Found 1 AMD Athlon 64 / Opteron processors (version 1.40.2)
acpi_processor-0252 [04] acpi_processor_get_per: Error evaluating _PSS
powernow-k8: BIOS error - no PSB or ACPI _PSS objects
acpi_processor-0252 [04] acpi_processor_get_per: Error evaluating _PSS

kind regards

flo

-- 
"I may have invented it, but Bill made it famous"
David Bradley, who invented the (in)famous ctrl-alt-del key combination
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO September
19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
