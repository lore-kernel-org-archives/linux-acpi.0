From: "Moore, Robert" <robert.moore@intel.com>
Subject: RE: [PATCH] ACPI: index off by one?
Date: Mon, 23 Feb 2009 07:36:56 -0800
Message-ID: <4911F71203A09E4D9981D27F9D83085814B540DD@orsmsx503.amr.corp.intel.com>
References: <49A0B055.5060600@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:59930 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753430AbZBWPg7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 23 Feb 2009 10:36:59 -0500
In-Reply-To: <49A0B055.5060600@gmail.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Roel Kluin <roel.kluin@gmail.com>, "lenb@kernel.org" <lenb@kernel.org>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>

No, the original code is correct.

Index must be at least as long as (ACPI_NAME_SIZE + 1) in order to account for the path separator. In other words, each segment in the pathname is not of length ACPI_NAME_SIZE, it is of length (ACPI_NAME_SIZE + 1).

Bob


>-----Original Message-----
>From: linux-acpi-owner@vger.kernel.org [mailto:linux-acpi-
>owner@vger.kernel.org] On Behalf Of Roel Kluin
>Sent: Saturday, February 21, 2009 5:54 PM
>To: lenb@kernel.org
>Cc: linux-acpi@vger.kernel.org; Andrew Morton
>Subject: [PATCH] ACPI: index off by one?
>
>Should maybe this be applied? please review.
>--------------------------->8-------------8<------------------------------
>When index equals ACPI_NAME_SIZE, that is still one too large.
>
>Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
>---
>diff --git a/drivers/acpi/acpica/nsnames.c b/drivers/acpi/acpica/nsnames.c
>index ae3dc10..232c80c 100644
>--- a/drivers/acpi/acpica/nsnames.c
>+++ b/drivers/acpi/acpica/nsnames.c
>@@ -87,7 +87,7 @@ acpi_ns_build_external_path(struct acpi_namespace_node
>*node,
> 	parent_node = node;
> 	name_buffer[index] = 0;
>
>-	while ((index > ACPI_NAME_SIZE) && (parent_node !=
>acpi_gbl_root_node)) {
>+	while ((index >= ACPI_NAME_SIZE) && (parent_node !=
>acpi_gbl_root_node)) {
> 		index -= ACPI_NAME_SIZE;
>
> 		/* Put the name into the buffer */
>--
>To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
