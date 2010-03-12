From: "Moore, Robert" <robert.moore@intel.com>
Subject: RE: [patch 1/2] acpica: fix acpi_ex_release_mutex() comment
Date: Fri, 12 Mar 2010 12:19:37 -0800
Message-ID: <4911F71203A09E4D9981D27F9D83085859FF960C@orsmsx503.amr.corp.intel.com>
References: <201003112159.o2BLx3MG012830@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:64330 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932176Ab0CLUTj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 12 Mar 2010 15:19:39 -0500
In-Reply-To: <201003112159.o2BLx3MG012830@imap1.linux-foundation.org>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "lenb@kernel.org" <lenb@kernel.org>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "bzolnier@gmail.com" <bzolnier@gmail.com>, "error27@gmail.com" <error27@gmail.com>, "Lin, Ming M" <ming.m.lin@intel.com>

I just added this to the base ACPICA code, no need for this patch
Bob


>-----Original Message-----
>From: akpm@linux-foundation.org [mailto:akpm@linux-foundation.org]
>Sent: Thursday, March 11, 2010 1:59 PM
>To: lenb@kernel.org
>Cc: linux-acpi@vger.kernel.org; akpm@linux-foundation.org;
>bzolnier@gmail.com; error27@gmail.com; Lin, Ming M; Moore, Robert
>Subject: [patch 1/2] acpica: fix acpi_ex_release_mutex() comment
>
>From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
>
>trivial, leftover from my NULL pointer dereference patch which got
>'superseded' by commit fbc3be2
>
>Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
>Cc: Len Brown <lenb@kernel.org>
>Cc: Lin Ming <ming.m.lin@intel.com>
>Cc: Bob Moore <robert.moore@intel.com>
>Cc: Dan Carpenter <error27@gmail.com>
>Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
>---
>
> drivers/acpi/acpica/exmutex.c |    3 +--
> 1 file changed, 1 insertion(+), 2 deletions(-)
>
>diff -puN drivers/acpi/acpica/exmutex.c~acpica-fix-acpi_ex_release_mutex-
>comment drivers/acpi/acpica/exmutex.c
>--- a/drivers/acpi/acpica/exmutex.c~acpica-fix-acpi_ex_release_mutex-
>comment
>+++ a/drivers/acpi/acpica/exmutex.c
>@@ -234,8 +234,7 @@ acpi_ex_acquire_mutex(union acpi_operand
> 		return_ACPI_STATUS(AE_BAD_PARAMETER);
> 	}
>
>-	/* Must have a valid thread ID */
>-
>+	/* Must have a valid thread. */
> 	if (!walk_state->thread) {
> 		ACPI_ERROR((AE_INFO,
> 			    "Cannot acquire Mutex [%4.4s], null thread info",
>_
