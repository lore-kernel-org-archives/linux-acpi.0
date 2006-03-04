From: Adrian Bunk <bunk@stusta.de>
Subject: [-mm patch] drivers/acpi/bus.c: make struct acpi_sci_dir static
Date: Sat, 4 Mar 2006 13:14:21 +0100
Message-ID: <20060304121421.GK9295@stusta.de>
References: <20060303045651.1f3b55ec.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mailout.stusta.mhn.de ([141.84.69.5]:17424 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751526AbWCDMOW (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 4 Mar 2006 07:14:22 -0500
Content-Disposition: inline
In-Reply-To: <20060303045651.1f3b55ec.akpm@osdl.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>, Ashok Raj <ashok.raj@intel.com>
Cc: linux-kernel@vger.kernel.org, len.brown@intel.com, linux-acpi@vger.kernel.org

On Fri, Mar 03, 2006 at 04:56:51AM -0800, Andrew Morton wrote:
>...
> Changes since 2.6.16-rc5-mm1:
>...
> +enable-sci_emulate-to-manually-simulate-physical-hotplug-testing.patch
> 
>  x86_64 CPU hotplug
>...


There's no reason for struct acpi_sci_dir being global.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.16-rc5-mm2-full/drivers/acpi/bus.c.old	2006-03-03 17:33:38.000000000 +0100
+++ linux-2.6.16-rc5-mm2-full/drivers/acpi/bus.c	2006-03-03 17:33:51.000000000 +0100
@@ -47,7 +47,7 @@
 static void acpi_sci_notify_client(char *acpi_name, u32 event);
 static int acpi_sci_notify_write_proc(struct file *file, const char *buffer, \
 	unsigned long count, void *data);
-struct proc_dir_entry 		*acpi_sci_dir;
+static struct proc_dir_entry 	*acpi_sci_dir;
 
 #else
 #define acpi_init_sci_emulate()

