From: Bernard Blackham <bernard-4vSAtV5O1nc0n/F98K4Iww@public.gmane.org>
Subject: Cause of Suspend2 resume failures on Toshiba laptops
Date: Sat, 5 Mar 2005 01:50:59 +0800
Message-ID: <20050304175058.GA4042__20363.0424141467$1109958709$gmane$org@blackham.com.au>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="dDRMvlgZJXvWKvBx"
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
To: suspend2-devel-g/J2nbn7YhmWn91e4EydUaxOck334EZe@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


--dDRMvlgZJXvWKvBx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

As some of you will know, some laptops (notably almost all recent
Toshibas) have issues resuming with Software Suspend 2, resulting in
a hang during "Reading caches", or a stream of "Unable to queue
event ..." messages. If you try and resume enough times,
occasionally it will make it to the end of resuming and the system
will be perfectly usable.

The attached patch more or less reverts the change in 2.6.9-rc1 that
began this all. If you have a Toshiba or other laptop that's
affected by this, I ask you to see if it helps your problems. (It
hacks around the problem rather than fixing it, but I'm not entirely
sure what functionality it disables).

To the ACPI developers:

I'm not entirely sure what this is breaking. What uses these GPEs?
It seems the hangs are caused by one of these GPEs firing upon
resume (though I'm not sure why it causes a hang - perhaps related
to the low memory conditions during a suspend/resume cycle?)

The comment above the line I changed mentions that the GPE enable
mask is updated, but not the HW GPE itself. Whereabouts are these
later enabled?

Are the HW GPE enable masks stored in memory that might be replaced
when resuming, with their values from suspend? If so, could/should
GPEs be disabled before suspending so that they aren't enabled at an
unfortunate moment on resume?

Apologies if none of the above makes much sense - it doesn't make
all that much sense to me yet :)

Thanks,

Bernard.

-- 
 Bernard Blackham <bernard at blackham dot com dot au>

--dDRMvlgZJXvWKvBx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="toshiba-acpi-hack.diff"

--- linux-2.6.9-rc1/drivers/acpi/events/evgpeblk.c.orig	2005-03-05 01:24:29.000000000 +0800
+++ linux-2.6.9-rc1/drivers/acpi/events/evgpeblk.c	2005-03-05 01:25:28.000000000 +0800
@@ -314,7 +314,7 @@
 
 	/* Update enable mask, but don't enable the HW GPE as of yet */
 
-	status = acpi_ev_enable_gpe (gpe_event_info, FALSE);
+	status = AE_OK;
 
 	ACPI_DEBUG_PRINT ((ACPI_DB_LOAD,
 		"Registered GPE method %s as GPE number 0x%.2X\n",

--dDRMvlgZJXvWKvBx--


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
