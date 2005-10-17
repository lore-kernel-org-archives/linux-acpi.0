From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Fix /proc/acpi/events around suspend
Date: Mon, 17 Oct 2005 12:04:38 +0200
Message-ID: <20051017100438.GA2971@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
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
To: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>, kernel list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Fix -EIO on /proc/acpi/events after suspends. This actually breaks
suspending by power button in many setups.

Signed-off-by: Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>

---
commit a6660667ecd52e68a1b51ab9135d722d974ba171
tree e915e150ec69ec6b1cf15a8d9302bf06665ad1f6
parent cce1c483de7404e3d6320d650af23373be4c39af
author <pavel@amd.(none)> Tue, 11 Oct 2005 23:10:55 +0200
committer <pavel@amd.(none)> Tue, 11 Oct 2005 23:10:55 +0200

 drivers/acpi/event.c |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/event.c b/drivers/acpi/event.c
--- a/drivers/acpi/event.c
+++ b/drivers/acpi/event.c
@@ -58,9 +58,8 @@ acpi_system_read_event(struct file *file
 			return_VALUE(-EAGAIN);
 
 		result = acpi_bus_receive_event(&event);
-		if (result) {
-			return_VALUE(-EIO);
-		}
+		if (result)
+			return_VALUE(result);
 
 		chars_remaining = sprintf(str, "%s %s %08x %08x\n",
 					  event.device_class ? event.

-- 
Thanks, Sharp!


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
