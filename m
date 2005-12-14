From: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>
Subject: Re: [PATCH] Fix oops in asus_acpi.c on Samsung P30/P35 Laptops
Date: Tue, 13 Dec 2005 21:16:59 -0800
Message-ID: <20051213211659.032a0539.akpm@osdl.org>
References: <4395D945.6080108@gmx.net>
	<20051206192136.GA22615@kroah.com>
	<4395F0AB.1080408@gmx.net>
	<20051208033841.GA25008@kroah.com>
	<439A23CB.50102@gmx.net>
	<439FA436.50107@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <439FA436.50107-hi6Y0CQ0nG0@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Carl-Daniel Hailfinger <c-d.hailfinger.devel.2005-hi6Y0CQ0nG0@public.gmane.org>
Cc: torvalds-3NddpPZAyC0@public.gmane.org, greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, stable-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Carl-Daniel Hailfinger <c-d.hailfinger.devel.2005-hi6Y0CQ0nG0@public.gmane.org> wrote:
>
> please apply the following patch to your trees. It fixes
>  http://bugzilla.kernel.org/show_bug.cgi?id=5067

For some reason your patch doesn't even vaguely apply.  Mozilla.

If we're going to print "unknown integer" then we surely should print out
what the integer _is_, no?

And yeah, this patch has been hanging around for far too long.  It might be
in the acpi tree which Len is trying to get merged up (it has a few
git-related difficulties at present).



From: Christian Aichinger <Greek0-hi6Y0CQ0nG0@public.gmane.org>

For a while now asus_acpi is broken on samsung laptops (causes oopses on
module loading and kernel panic if compiled into the kernel).

Signed-off-by: Christian Aichinger <Greek0-hi6Y0CQ0nG0@public.gmane.org>
Cc: "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: <stable-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Signed-off-by: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>
---

 drivers/acpi/asus_acpi.c |   30 +++++++++++++++++++++++++++---
 1 files changed, 27 insertions(+), 3 deletions(-)

diff -puN drivers/acpi/asus_acpi.c~acpi-fix-asus_acpi-on-samsung-p30-p35 drivers/acpi/asus_acpi.c
--- devel/drivers/acpi/asus_acpi.c~acpi-fix-asus_acpi-on-samsung-p30-p35	2005-12-13 21:15:00.000000000 -0800
+++ devel-akpm/drivers/acpi/asus_acpi.c	2005-12-13 21:15:00.000000000 -0800
@@ -1006,6 +1006,24 @@ static int __init asus_hotk_get_info(voi
 	}
 
 	model = (union acpi_object *)buffer.pointer;
+
+	/* INIT on Samsung's P35 returns an integer, possible return
+	 * values are tested below */
+	if (model->type == ACPI_TYPE_INTEGER) {
+		if (model->integer.value == -1 ||
+			model->integer.value == 0x58 ||
+			model->integer.value == 0x38) {
+			hotk->model = P30;
+			printk(KERN_NOTICE
+				       "  Samsung P35 detected, supported\n");
+			goto out_known;
+		} else {
+			printk(KERN_WARNING "  unknown integer 0x%x returned "
+					"by INIT\n", model->integer.value);
+			goto out_unknown;
+		}
+	}
+
 	if (model->type == ACPI_TYPE_STRING) {
 		printk(KERN_NOTICE "  %s model detected, ",
 		       model->string.pointer);
@@ -1057,9 +1075,7 @@ static int __init asus_hotk_get_info(voi
 		hotk->model = L5x;
 
 	if (hotk->model == END_MODEL) {
-		printk("unsupported, trying default values, supply the "
-		       "developers with your DSDT\n");
-		hotk->model = M2E;
+		goto out_unknown;
 	} else {
 		printk("supported\n");
 	}
@@ -1088,6 +1104,14 @@ static int __init asus_hotk_get_info(voi
 	acpi_os_free(model);
 
 	return AE_OK;
+out_unknown:
+	printk(KERN_WARNING "  unsupported, trying default values, "
+			"supply the developers with your DSDT\n");
+	hotk->model = M2E;
+out_known:
+	hotk->methods = &model_conf[hotk->model];
+	acpi_os_free(model);
+	return AE_OK;
 }
 
 static int __init asus_hotk_check(void)
_



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
