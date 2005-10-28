From: akpm-3NddpPZAyC0@public.gmane.org
Subject: [patch 4/4] pnpacpi-handle-address-descriptors-in-_prs-fix-for-git-acpi-change
Date: Fri, 28 Oct 2005 15:01:44 -0700
Message-ID: <200510282201.j9SM1QAl021823@shell0.pdx.osdl.net>
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
To: len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, akpm-3NddpPZAyC0@public.gmane.org, bjorn.helgaas-VXdhtT5mjnY@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


From: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>

Renaming that thing may not have been such a great idea.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>
Cc: "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Signed-off-by: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>
---

 drivers/pnp/pnpacpi/rsparser.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletion(-)

diff -puN drivers/pnp/pnpacpi/rsparser.c~pnpacpi-handle-address-descriptors-in-_prs-fix-for-git-acpi-change drivers/pnp/pnpacpi/rsparser.c
--- devel/drivers/pnp/pnpacpi/rsparser.c~pnpacpi-handle-address-descriptors-in-_prs-fix-for-git-acpi-change	2005-09-23 15:07:45.000000000 -0700
+++ devel-akpm/drivers/pnp/pnpacpi/rsparser.c	2005-09-23 15:07:45.000000000 -0700
@@ -463,7 +463,8 @@ pnpacpi_parse_address_option(struct pnp_
 
 	status = acpi_resource_to_address64(r, p);
 	if (!ACPI_SUCCESS(status)) {
-		pnp_warn("PnPACPI: failed to convert resource type %d", r->id);
+		pnp_warn("PnPACPI: failed to convert resource type %d",
+				r->type);
 		return;
 	}
 
_


-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.
Get Certified Today * Register for a JBoss Training Course
Free Certification Exam for All Training Attendees Through End of 2005
Visit http://www.jboss.com/services/certification for more information
