From: Greg KH <gregkh@suse.de>
Subject: [patch 108/114] ACPI: fix broken usage of name.ascii
Date: Fri, 13 Mar 2009 18:11:25 -0700
Message-ID: <20090314011047.425424026@mini.kroah.org>
References: <20090314010937.416083662@mini.kroah.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from kroah.org ([198.145.64.141]:35832 "EHLO coco.kroah.org"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755201AbZCNBVc (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 13 Mar 2009 21:21:32 -0400
Content-Disposition: inline; filename=acpi-fix-broken-usage-of-name.ascii.patch
In-Reply-To: <20090314011649.GA26170@kroah.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-kernel@vger.kernel.org, stable@kernel.org, Len Brown <lenb@kernel.org>
Cc: Justin Forbes <jmforbes@linuxtx.org>, Zwane Mwaikambo <zwane@arm.linux.org.uk>, Theodore Ts'o <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>, Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>, Chris Wedgwood <reviews@ml.cw.f00f.org>, Michael Krufky <mkrufky@linuxtv.org>, Chuck Ebbert <cebbert@redhat.com>, Domenico Andreoli <cavokz@gmail.com>, Willy Tarreau <w@1wt.eu>, Rodrigo Rubira Branco <rbranco@la.checkpoint.com>, Jake Edge <jake@lwn.net>, Eugene Teo <eteo@redhat.com>, torvalds@linux-foundation.org, akpm@linux-foundation.org, alan@lxorguk.ukuu.org.uk, linux-acpi@vger.kernel.org, Lin Ming <ming.m.lin@intel.com>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>

2.6.28-stable review patch.  If anyone has any objections, please let us know.

------------------

From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>

This issue was fixed indirectly in mainline by commit
0175d562a29ad052c510782c7e76bc63d5155b9b.

acpi_namespace_node's name.ascii field is four chars, and not NULL-
terminated except by pure luck.  So, it cannot be used by sscanf() without
a length restriction.

This is the minimal fix for both stable 2.6.27 and 2.6.28.

Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: Lin Ming <ming.m.lin@intel.com>
Cc: Len Brown <lenb@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 drivers/acpi/ec.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -759,9 +759,10 @@ acpi_ec_register_query_methods(acpi_hand
 	struct acpi_namespace_node *node = handle;
 	struct acpi_ec *ec = context;
 	int value = 0;
-	if (sscanf(node->name.ascii, "_Q%x", &value) == 1) {
+
+	if (sscanf(node->name.ascii, "_Q%2x", &value) == 1)
 		acpi_ec_add_query_handler(ec, value, handle, NULL, NULL);
-	}
+
 	return AE_OK;
 }
 


