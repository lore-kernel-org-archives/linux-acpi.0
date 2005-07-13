From: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>
Subject: Fw: Followup on 2.6.13-rc3 ACPI processor C-state regression
Date: Wed, 13 Jul 2005 16:13:54 -0700
Message-ID: <20050713161354.656272b6.akpm@osdl.org>
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
To: "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


There's another regression being reported over on lkml.

Begin forwarded message:

Date: Wed, 13 Jul 2005 18:05:30 -0400
From: Kevin Radloff <radsaq-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Subject: Followup on 2.6.13-rc3 ACPI processor C-state regression


Previously, I had said that in 2.6.13-rc3, C2/C3 capabilities were not
detected on my Fujitsu Lifebook P7010D. I found that in the merge at:

http://kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=blobdiff;h=893b074e3d1a48a4390cf84b4c1a10ef6be2460c;hp=c9d671cf7857dbc7101e99d469fa24eed711ac60;hb=5028770a42e7bc4d15791a44c28f0ad539323807;f=drivers/acpi/processor_idle.c

.. in the section at (please forgive my destruction of the formatting) ...

@@ -787,10 +843,7 @@ static int acpi_processor_get_power_info
         if ((result) || (acpi_processor_power_verify(pr) < 2)) {
             result = acpi_processor_get_power_info_fadt(pr);
             if (result)
-                return_VALUE(result);
-
-            if (acpi_processor_power_verify(pr) < 2)
-                return_VALUE(-ENODEV);
+               result = acpi_processor_get_power_info_default_c1(pr);
         }

.. a call to acpi_processor_power_verify() is removed, which breaks
detection of C2/C3 capabilities if the above
acpi_processor_get_power_info_cst() failed. It it had succeeded (and
returned 0), then acpi_processor_power_verify() is called in the
conditional statement, which will set the valid flags for C2/C3. But
if it fails, like on my laptop, then the valid flags will never be
set, despite the fact that the acpi_processor_get_power_info_fadt()
function finds the necessary info for a subsequent
acpi_processor_power_verify() call to succeed.

I don't know what exactly the proper fix here is (with the
introduction of the acpi_processor_get_power_info_default_c1()
function, that is), but simply reversing this part of the patch fixes
detection of C2/C3 on my laptop.

Please CC me with any followups, as I'm not on the list.

-- 
Kevin 'radsaq' Radloff
radsaq-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
http://saqataq.us/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/


-------------------------------------------------------
This SF.Net email is sponsored by the 'Do More With Dual!' webinar happening
July 14 at 8am PDT/11am EDT. We invite you to explore the latest in dual
core and dual graphics technology at this free one hour event hosted by HP, 
AMD, and NVIDIA.  To register visit http://www.hp.com/go/dualwebinar
