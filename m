From: Lorenzo Colitti <lorenzo-Z4WAQ3j+MphBDgjK7y7TUQ@public.gmane.org>
Subject: [patch] swsusp2 should execute _WAK on resume
Date: Mon, 07 Mar 2005 15:41:30 +0100
Message-ID: <422C681A.5040208@colitti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------070804090804030801090305"
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: softwaresuspend-devel-0fE9KPoRgkgATYTw5x5z8w@public.gmane.org
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

This is a multi-part message in MIME format.
--------------070804090804030801090305
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable

Hi,

[CCing ACPI-devel in case someone wants to comment]

Using swsusp2 2.1.8 on a vanilla 2.6.11 kernel (but I have been seeing=20
this since v2.1 on 2.6.9), my laptop (HP nc6000) doesn't generate any=20
ACPI thermal events after resume. This means the fans only come on=20
(screaming) if the CPU reaches 85 =B0C or so, which is not very healthy.

This is due to the fact that unlike swsusp and S3, swsusp2 does not call=20
the ACPI _WAK method, which the ACPI spec says should be called when the=20
machine comes out of a sleep state. If I hack swsusp2 so that it calls=20
the _WAK method on resume, the fans work correctly after resume.

I do this via the attached hack, but I don't know much about the=20
workings of swsusp2, so I don't know if it's the right approach. It does=20
work for me though, and even if the details of the patch aren't right,=20
based on my reading of the ACPI spec I think this should be done.

Comments? Is it fit to apply to the swsusp2 tree?


Cheers,
Lorenzo

P.S. I have been using swsusp2 since v2.1 for 2.6.9, and it works like a=20
charm. A big thank you to the people that made it possible. :)

--------------070804090804030801090305
Content-Type: text/plain;
 name="patch-swsusp2-acpiwakeonresume.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-swsusp2-acpiwakeonresume.diff"

diff -u linux-2.6.11/kernel/power/suspend2_core/suspend.c linux-2.6.11-patched/kernel/power/suspend2_core/suspend.c
--- linux-2.6.11/kernel/power/suspend2_core/suspend.c	2005-03-07 15:17:31.000000000 +0100
+++ linux-2.6.11-patched/kernel/power/suspend2_core/suspend.c	2005-03-07 15:18:47.000000000 +0100
@@ -404,6 +404,10 @@
  * Called From     : do_suspend2_lowlevel
  */
 
+#ifdef CONFIG_ACPI
+extern u32 acpi_leave_sleep_state (u8 sleep_state);
+#endif
+
 static void do_suspend2_resume_2(void)
 {
 	set_suspend_state(SUSPEND_NOW_RESUMING);
@@ -433,6 +437,11 @@
 	suspend_checksum_print_differences();
 
 	prepare_status(0, 0, "Cleaning up...");
+
+#ifdef CONFIG_ACPI
+	if (suspend_powerdown_method)
+		acpi_leave_sleep_state(suspend_powerdown_method);
+#endif
 }
 
 /*

--------------070804090804030801090305--


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
