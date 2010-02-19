From: "Chumbalkar, Nagananda" <Nagananda.Chumbalkar@hp.com>
Subject: RE: [Devel] [PATCH] ACPICA: exfield: minor format change in error
	message (fwd)
Date: Fri, 19 Feb 2010 16:37:35 +0000
Message-ID: <66D9D2F0CDB5C9428E6166B01EC85EE161E3A2E496@GVW0676EXC.americas.hpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g5t0008.atlanta.hp.com ([15.192.0.45]:47512 "EHLO
	g5t0008.atlanta.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751718Ab0BSQiQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 19 Feb 2010 11:38:16 -0500
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Moore, Robert" <robert.moore@intel.com>, Len Brown <lenb@kernel.org>, "devel@acpica.org" <devel@acpica.org>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

[PATCH v2] ACPICA: exfield: minor format change in error message

Change %X to %u.

V1->V2:
%d to %u

Signed-off-by: Naga Chumbalkar <nagananda.chumbalkar@hp.com>

diff --git a/drivers/acpi/acpica/exfield.c b/drivers/acpi/acpica/exfield.c
index 1588a2d..b9400e7 100644
--- a/drivers/acpi/acpica/exfield.c
+++ b/drivers/acpi/acpica/exfield.c
@@ -281,7 +281,8 @@ acpi_ex_write_data_to_field(union acpi_operand_object *source_desc,
 
 		if (source_desc->buffer.length < length) {
 			ACPI_ERROR((AE_INFO,
-				    "SMBus or IPMI write requires Buffer of length %X, found length %X",
+				    "SMBus or IPMI write requires Buffer of "
+				    "length %u, found length %u",
 				    length, source_desc->buffer.length));
 
 			return_ACPI_STATUS(AE_AML_BUFFER_LIMIT);


-----Original Message-----
From: Moore, Robert [mailto:robert.moore@intel.com] 
Sent: Friday, February 19, 2010 1:49 AM
To: Len Brown; devel@acpica.org
Cc: linux-acpi@vger.kernel.org; Chumbalkar, Nagananda
Subject: RE: [Devel] [PATCH] ACPICA: exfield: minor format 
change in error message (fwd)

Yes.

One nit:
+				    "length %d, found length %d",

We usually use %u on these:

+				    "length %u, found length %u",

>-----Original Message-----
>From: devel-bounces@acpica.org 
[mailto:devel-bounces@acpica.org] On Behalf
>Of Len Brown
>Sent: Thursday, February 18, 2010 10:43 PM
>To: devel@acpica.org
>Cc: linux-acpi@vger.kernel.org; Naga Chumbalkar
>Subject: [Devel] [PATCH] ACPICA: exfield: minor format change in error
>message (fwd)
>
>Bob,
>one for you.
>
>thanks,
>Len Brown, Intel Open Source Technology Center
>
