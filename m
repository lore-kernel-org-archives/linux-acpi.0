From: akpm-3NddpPZAyC0@public.gmane.org
Subject: [patch 04/12] pcc_acpi build fix
Date: Wed, 23 Feb 2005 01:53:00 -0800
Message-ID: <200502230953.j1N9rEUr020699@shell0.pdx.osdl.net>
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
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, akpm-3NddpPZAyC0@public.gmane.org
List-Id: linux-acpi@vger.kernel.org



With older gcc's:

drivers/acpi/pcc_acpi.c: In function `acpi_pcc_write_sset':
drivers/acpi/pcc_acpi.c:111: field `integer' already initialized
drivers/acpi/pcc_acpi.c:111: unknown field `value' specified in initializer
drivers/acpi/pcc_acpi.c:111: warning: excess elements in union initializer
drivers/acpi/pcc_acpi.c:111: warning: (near initialization for `in_objs[0]')
drivers/acpi/pcc_acpi.c:113: field `integer' already initialized
drivers/acpi/pcc_acpi.c:113: unknown field `value' specified in initializer
drivers/acpi/pcc_acpi.c:113: warning: excess elements in union initializer
drivers/acpi/pcc_acpi.c:113: warning: (near initialization for `in_objs[1]')


Signed-off-by: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>
---

 25-akpm/drivers/acpi/pcc_acpi.c |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

diff -puN drivers/acpi/pcc_acpi.c~pcc_acpi-build-fix drivers/acpi/pcc_acpi.c
--- 25/drivers/acpi/pcc_acpi.c~pcc_acpi-build-fix	2005-02-23 01:48:02.000000000 -0800
+++ 25-akpm/drivers/acpi/pcc_acpi.c	2005-02-23 01:48:02.000000000 -0800
@@ -107,10 +107,8 @@ static int acpi_pcc_write_sset(struct ac
 {
 	acpi_status status;
 	union acpi_object in_objs[] = {
-		{ .integer.type  = ACPI_TYPE_INTEGER,
-		  .integer.value = func, },
-		{ .integer.type  = ACPI_TYPE_INTEGER,
-		  .integer.value = val, },
+		{ .integer = { .type  = ACPI_TYPE_INTEGER, .value = func, }},
+		{ .integer = { .type  = ACPI_TYPE_INTEGER, .value = val, }},
 	};
 	struct acpi_object_list params = {
 		.count   = ARRAY_SIZE(in_objs),
_


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
