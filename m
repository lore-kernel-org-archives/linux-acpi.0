From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: acpi: sleep/proc.c cleanups
Date: Sat, 19 Mar 2005 12:06:57 +0100
Message-ID: <20050319110657.GA1530@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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
To: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, ACPI mailing list <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi!

This removes strange constructs and makes code shorter/clearer. Please
apply,

								Pavel
Signed-off-by: Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>

--- clean/drivers/acpi/sleep/proc.c	2005-01-12 11:07:39.000000000 +0100
+++ linux/drivers/acpi/sleep/proc.c	2005-01-12 11:20:13.000000000 +0100
@@ -372,14 +368,10 @@
 		if (!dev->wakeup.flags.valid)
 			continue;
 		spin_unlock(&acpi_device_lock);
-		if (dev->wakeup.flags.run_wake)
-			seq_printf(seq, "%4s	%4d		%8s\n",
-				dev->pnp.bus_id, (u32) dev->wakeup.sleep_state,
-				dev->wakeup.state.enabled ? "*enabled" : "*disabled");
-		else
-			seq_printf(seq, "%4s	%4d		%8s\n",
-				dev->pnp.bus_id, (u32) dev->wakeup.sleep_state,
-				dev->wakeup.state.enabled ? "enabled" : "disabled");
+		seq_printf(seq, "%4s	%4d		%s%8s\n",
+			   dev->pnp.bus_id, (u32) dev->wakeup.sleep_state,
+			   dev->wakeup.flags.run_wake ? "*" : "",
+			   dev->wakeup.state.enabled ? "enabled" : "disabled");
 		spin_lock(&acpi_device_lock);
 	}
 	spin_unlock(&acpi_device_lock);
@@ -413,7 +405,7 @@
 			continue;
 
 		if (!strncmp(dev->pnp.bus_id, str, 4)) {
-			dev->wakeup.state.enabled = dev->wakeup.state.enabled ? 0:1;
+			dev->wakeup.state.enabled = !dev->wakeup.state.enabled;
 			found_dev = dev;
 			break;
 		}
 
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
