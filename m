From: "Moore, Robert" <robert.moore@intel.com>
Subject: RE: [2.6 patch] acpi_ns_get_external_pathname(): fix a memory leak
Date: Thu, 28 Aug 2008 12:36:20 -0700
Message-ID: <4911F71203A09E4D9981D27F9D8308582018E3@orsmsx503.amr.corp.intel.com>
References: <20080827220311.GN11734@cs181140183.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:19902 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752286AbYH1TgX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 28 Aug 2008 15:36:23 -0400
In-Reply-To: <20080827220311.GN11734@cs181140183.pp.htv.fi>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Adrian Bunk <bunk@kernel.org>, "Lin, Ming M" <ming.m.lin@intel.com>, Andi Kleen <ak@linux.intel.com>, "lenb@kernel.org" <lenb@kernel.org>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

I have added this to acpica, available in the next release.
Rather than patch linux now, I suggest waiting until it bubbles up from the ACPICA->Linux process.

Bob


>-----Original Message-----
>From: Adrian Bunk [mailto:bunk@kernel.org]
>Sent: Wednesday, August 27, 2008 3:03 PM
>To: Moore, Robert; Lin, Ming M; Andi Kleen; lenb@kernel.org
>Cc: linux-acpi@vger.kernel.org
>Subject: [2.6 patch] acpi_ns_get_external_pathname(): fix a memory leak
>
>This patch fixes a memory leak in an error path.
>
>Reported-by: Adrian Bunk <bunk@kernel.org>
>Signed-off-by: Adrian Bunk <bunk@kernel.org>
>
>---
>446be2de05a8c1fbf2208311673a19aaf26b188e
>diff --git a/drivers/acpi/namespace/nsnames.c
>b/drivers/acpi/namespace/nsnames.c
>index bd57738..f03410c 100644
>--- a/drivers/acpi/namespace/nsnames.c
>+++ b/drivers/acpi/namespace/nsnames.c
>@@ -150,20 +150,21 @@ char *acpi_ns_get_external_pathname(struct
>acpi_namespace_node *node)
>        name_buffer = ACPI_ALLOCATE_ZEROED(size);
>        if (!name_buffer) {
>                ACPI_ERROR((AE_INFO, "Allocation failure"));
>                return_PTR(NULL);
>        }
>
>        /* Build the path in the allocated buffer */
>
>        status = acpi_ns_build_external_path(node, size, name_buffer);
>        if (ACPI_FAILURE(status)) {
>+               ACPI_FREE(name_buffer);
>                return (NULL);
>        }
>
>        return_PTR(name_buffer);
> }
> #endif
>
>
>/**************************************************************************
>*****
>  *
>  * FUNCTION:    acpi_ns_get_pathname_length
