From: "Moore, Robert" <robert.moore@intel.com>
Subject: RE: [PATCH] ACPICA: update documentation to reflect correct
 parameter name
Date: Fri, 4 Dec 2009 06:40:31 -0800
Message-ID: <4911F71203A09E4D9981D27F9D8308583E8F2737@orsmsx503.amr.corp.intel.com>
References: <20091204153605.73fc9202@destiny.ordissimo>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:53261 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751211AbZLDOka convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 4 Dec 2009 09:40:30 -0500
In-Reply-To: <20091204153605.73fc9202@destiny.ordissimo>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Anisse Astier <anisse@astier.eu>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Cc: Len Brown <lenb@kernel.org>, Jiri Kosina <jkosina@suse.cz>

> since longer than git can remember.

What does this mean?


>-----Original Message-----
>From: Anisse Astier [mailto:anisse@astier.eu]
>Sent: Friday, December 04, 2009 6:36 AM
>To: linux-acpi@vger.kernel.org
>Cc: Len Brown; Moore, Robert; Jiri Kosina
>Subject: [PATCH] ACPICA: update documentation to reflect correct parameter
>name
>
>
>Second parameter for function acpi_ut_copy_iobject_to_eobject is named
>ret_buffer, not buffer_ptr, since longer than git can remember.
>
>Signed-off-by: Anisse Astier <anisse@astier.eu>
>---
>Hi,
>
>ACPICA is somewhat auto-generated. How can this trivial patch be applied?
>
>Regards,
>
>Anisse
>
> drivers/acpi/acpica/utcopy.c |    2 +-
> 1 files changed, 1 insertions(+), 1 deletions(-)
>
>diff --git a/drivers/acpi/acpica/utcopy.c b/drivers/acpi/acpica/utcopy.c
>index 0f0c64b..ecfa7f9 100644
>--- a/drivers/acpi/acpica/utcopy.c
>+++ b/drivers/acpi/acpica/utcopy.c
>@@ -382,7 +382,7 @@ acpi_ut_copy_ipackage_to_epackage(union
>acpi_operand_object *internal_object,
>  * FUNCTION:    acpi_ut_copy_iobject_to_eobject
>  *
>  * PARAMETERS:  internal_object     - The internal object to be converted
>- *              buffer_ptr          - Where the object is returned
>+ *              ret_buffer          - Where the object is returned
>  *
>  * RETURN:      Status
>  *
>--
>1.6.5.3

