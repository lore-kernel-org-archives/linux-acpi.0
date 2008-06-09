From: akpm@linux-foundation.org
Subject: [patch 05/11] acpi video: blacklist Fujitsu Lifebook S6410
Date: Mon, 09 Jun 2008 16:22:21 -0700
Message-ID: <200806092322.m59NML9K013967@imap1.linux-foundation.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:51645 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755414AbYFIXX2 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 9 Jun 2008 19:23:28 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, akpm@linux-foundation.org, nokos@gmx.net, mjg59@srcf.ucam.org, robert.moore@intel.com, trenn@suse.de

From: Peter Gruber <nokos@gmx.net>

Taken from http://bugzilla.kernel.org/show_bug.cgi?id=10454

On Thu, 1 May 2008 12:59:46 +0100 Matthew Garrett <mjg59@srcf.ucam.org> wrote:

> On Thu, May 01, 2008 at 02:52:04AM -0700, akpm@linux-foundation.org wrote:
> 
> > Taken from http://bugzilla.kernel.org/show_bug.cgi?id=10454
> 
> Checking the bug, it seems like discussion is ongoing and a better 
> solution is possible - this seems to be a case of us differing in 
> behaviour from Vista, so we probably want to fix it up properly.
> 
> -- 
> Matthew Garrett | mjg59@srcf.ucam.org

Cc: Len Brown <lenb@kernel.org>
Cc: "Moore, Robert" <robert.moore@intel.com>
Cc: Thomas Renninger <trenn@suse.de>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/acpi/blacklist.c |    8 ++++++++
 1 file changed, 8 insertions(+)

diff -puN drivers/acpi/blacklist.c~acpi-video-balcklist-fujitsu-lifebook-s6410 drivers/acpi/blacklist.c
--- a/drivers/acpi/blacklist.c~acpi-video-balcklist-fujitsu-lifebook-s6410
+++ a/drivers/acpi/blacklist.c
@@ -448,6 +448,14 @@ static struct dmi_system_id acpi_osi_dmi
 	 	     DMI_MATCH(DMI_PRODUCT_NAME, "ESPRIMO Mobile V5505"),
 		},
 	},
+	{
+	.callback = dmi_disable_osi_vista,
+	.ident = "Fujitsu Siemens",
+	.matches = {
+		DMI_MATCH(DMI_SYS_VENDOR, "FUJITSU SIEMENS"),
+		DMI_MATCH(DMI_PRODUCT_NAME, "LIFEBOOK S6410"),
+		},
+	},
 	/*
 	 * Disable OSI(Linux) warnings on all "Hewlett-Packard"
 	 *
_
