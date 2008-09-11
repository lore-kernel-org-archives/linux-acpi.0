From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [Bugme-new] [Bug 11539] New: empty filename in
 /sys/firmware/acpi/tables
Date: Thu, 11 Sep 2008 12:33:49 -0700
Message-ID: <20080911123349.6689187b.akpm@linux-foundation.org>
References: <bug-11539-10286@http.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:46196 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753464AbYIKTeX (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Thu, 11 Sep 2008 15:34:23 -0400
In-Reply-To: <bug-11539-10286@http.bugzilla.kernel.org/>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: nokos@gmx.net
Cc: bugme-daemon@bugzilla.kernel.org, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>, Lin Ming <ming.m.lin@intel.com>, Len Brown <len.brown@intel.com>

On Thu, 11 Sep 2008 02:59:49 -0700 (PDT)
bugme-daemon@bugzilla.kernel.org wrote:

> http://bugzilla.kernel.org/show_bug.cgi?id=11539
> 
>            Summary: empty filename in /sys/firmware/acpi/tables
>            Product: ACPI
>            Version: 2.5
>      KernelVersion: 2.6.26
>           Platform: All
>         OS/Version: Linux
>               Tree: Mainline
>             Status: NEW
>           Severity: low
>           Priority: P1
>          Component: Other
>         AssignedTo: acpi_other@kernel-bugs.osdl.org
>         ReportedBy: nokos@gmx.net
> 
> 
> Hardware Environment:
> A system with an acpi table with an empty signature
> 
> Problem Description:
> Since commit bc45b1d39a925b56796bebf8a397a0491489d85c acpi tables are allowed
> to have an empty signature and /sys/firmware/acpi/tables uses the signature as
> filename. Applications using naive recursion through /sys loop forever. A
> possible solution would be:
> (replacing the zero length filename with the string "NULL")
> 
> 
> diff a/drivers/acpi/system.c b/drivers/acpi/system.c
> --- a/drivers/acpi/system.c
> +++ b/drivers/acpi/system.c

(argh)


Please don't submit patches via bugzilla, especially not copy-n-paste
ones.  It gets wordwrapped and tabs get replaced with spaces and
similar crap.  Patches should be submitted via email.

I cleaned this patch up and applied it locally.

Please send a Signed-off-by: for this patch as per
Documentation/SubmittingPatches, section 12.

This patch fixes what appears to be a regression in 2.6.26 and looks
like it is applicable to both 2.6.26.x and to 2.6.27.  Len, Bob: please
review asap - I can merge it with your ack if you'd like.



From: Peter Gruber <nokos@gmx.net>

Taken from http://bugzilla.kernel.org/show_bug.cgi?id=11539

Since commit bc45b1d39a925b56796bebf8a397a0491489d85c acpi tables are
allowed to have an empty signature and /sys/firmware/acpi/tables uses the
signature as filename.  Applications using naive recursion through /sys
loop forever.  A possible solution would be: (replacing the zero length
filename with the string "NULL")

Cc: Bob Moore <robert.moore@intel.com>
Cc: Lin Ming <ming.m.lin@intel.com>
Cc: Len Brown <len.brown@intel.com>
Cc: <stable@kernel.org>		[2.6.26.x]
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/acpi/system.c |   25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff -puN drivers/acpi/system.c~acpi-dont-create-empty-filenames-in-sys-firmware-acpi-tables drivers/acpi/system.c
--- a/drivers/acpi/system.c~acpi-dont-create-empty-filenames-in-sys-firmware-acpi-tables
+++ a/drivers/acpi/system.c
@@ -78,9 +78,15 @@ static ssize_t acpi_table_show(struct ko
 	    container_of(bin_attr, struct acpi_table_attr, attr);
 	struct acpi_table_header *table_header = NULL;
 	acpi_status status;
+	char name[ACPI_NAME_SIZE];
+
+	if (strncmp(table_attr->name, "NULL", 4))
+		memcpy(name, table_attr->name, ACPI_NAME_SIZE);
+	else
+		memcpy(name, "\0\0\0\0", 4);
 
 	status =
-	    acpi_get_table(table_attr->name, table_attr->instance,
+	    acpi_get_table(name, table_attr->instance,
 			   &table_header);
 	if (ACPI_FAILURE(status))
 		return -ENODEV;
@@ -95,21 +101,24 @@ static void acpi_table_attr_init(struct 
 	struct acpi_table_header *header = NULL;
 	struct acpi_table_attr *attr = NULL;
 
-	memcpy(table_attr->name, table_header->signature, ACPI_NAME_SIZE);
+	if (table_header->signature[0] != '\0')
+		memcpy(table_attr->name, table_header->signature,
+			ACPI_NAME_SIZE);
+	else
+		memcpy(table_attr->name, "NULL", 4);
 
 	list_for_each_entry(attr, &acpi_table_attr_list, node) {
-		if (!memcmp(table_header->signature, attr->name,
-			    ACPI_NAME_SIZE))
+		if (!memcmp(table_attr->name, attr->name, ACPI_NAME_SIZE))
 			if (table_attr->instance < attr->instance)
 				table_attr->instance = attr->instance;
 	}
 	table_attr->instance++;
 
 	if (table_attr->instance > 1 || (table_attr->instance == 1 &&
-					 !acpi_get_table(table_header->
-							 signature, 2,
-							 &header)))
-		sprintf(table_attr->name + 4, "%d", table_attr->instance);
+					!acpi_get_table
+					(table_header->signature, 2, &header)))
+		sprintf(table_attr->name + ACPI_NAME_SIZE, "%d",
+			table_attr->instance);
 
 	table_attr->attr.size = 0;
 	table_attr->attr.read = acpi_table_show;
_

