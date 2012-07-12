From: Thomas Renninger <trenn@suse.de>
Subject: [PATCH] ACPICA: Fix possible fault in return package object repair code
Date: Thu, 12 Jul 2012 11:00:30 +0200
Message-ID: <201207121100.30579.trenn@suse.de>
References: <201207111943.19405.rjw@sisk.pl> <201207121057.31791.trenn@suse.de>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:49447 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932826Ab2GLJAe (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 12 Jul 2012 05:00:34 -0400
In-Reply-To: <201207121057.31791.trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux PM list <linux-pm@vger.kernel.org>, Len Brown <lenb@kernel.org>, ACPI Devel Mailing List <linux-acpi@vger.kernel.org>, Jonathan Nieder <jrnieder@gmail.com>, Lin Ming <ming.m.lin@intel.com>, Bob Moore <robert.moore@intel.com>, Vlastimil Babka <caster@gentoo.org>

From: Bob Moore <robert.moore@intel.com>

Fixes a problem that can occur when a lone package object is
wrapped with an outer package object in order to conform to
the ACPI specification. Can affect these predefined names:
_ALR,_MLS,_PSS,_TRT,_TSS,_PRT,_HPX,_DLM,_CSD,_PSD,_TSD

https://bugzilla.kernel.org/show_bug.cgi?id=44171

The bug got introduce by commit 6a99b1c94d053b3420eaa4a4bc
in v3.4-rc6, thus it needs to get pushed into 3.4 stable
kernels as well.

Reported-by: Vlastimil Babka <caster@gentoo.org>
Tested-by: Vlastimil Babka <caster@gentoo.org>
Tested-by: marc.collin@laboiteaprog.com
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
CC: stable@vger.kernel.org

---
 drivers/acpi/acpica/nspredef.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/acpi/acpica/nspredef.c b/drivers/acpi/acpica/nspredef.c
index 23ce096..fe66260 100644
--- a/drivers/acpi/acpica/nspredef.c
+++ b/drivers/acpi/acpica/nspredef.c
@@ -638,7 +638,7 @@ acpi_ns_check_package(struct acpi_predefined_data *data,
 			/* Create the new outer package and populate it */
 
 			status =
-			    acpi_ns_wrap_with_package(data, *elements,
+			    acpi_ns_wrap_with_package(data, return_object,
 						      return_object_ptr);
 			if (ACPI_FAILURE(status)) {
 				return (status);
