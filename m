Return-Path: <linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 028CAC4332F
	for <linux-acpi@archiver.kernel.org>; Thu, 17 Mar 2022 14:12:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230392AbiCQOOE (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Thu, 17 Mar 2022 10:14:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233668AbiCQOOD (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 17 Mar 2022 10:14:03 -0400
Received: from srv1.home.kabele.me (unknown [IPv6:2a02:768:2704:8c1a:3eec:efff:fe00:2ce4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id ED74C1FE573
        for <linux-acpi@vger.kernel.org>; Thu, 17 Mar 2022 07:12:46 -0700 (PDT)
Received: from srv1.home.kabele.me (localhost [IPv6:::1])
        by srv1.home.kabele.me (Postfix) with ESMTP id E2AA4168FAD;
        Thu, 17 Mar 2022 15:04:42 +0100 (CET)
Received: from localhost ([2a01:c22:8dfa:1400:beea:2810:7764:7afc])
        by srv1.home.kabele.me with ESMTPSA
        id TxkYNPo/M2JI8zMAnmUwTQ
        (envelope-from <vit@kabele.me>); Thu, 17 Mar 2022 15:04:42 +0100
Date:   Thu, 17 Mar 2022 15:04:37 +0100
From:   Vit Kabele <vit@kabele.me>
To:     platform-driver-x86@kernel.org
Cc:     vit@kabele.me, r.marek@assembler.cz, devel@acpica.org,
        mingo@redhat.com, robert.moore@intel.com, linux-kernel@kernel.org,
        linux-acpi@vger.kernel.org
Subject: [PATCH 3/3] acpica: Do not touch VGA memory when EBDA < 1KiB
Message-ID: <YjM/9UrYVIKs/LOl@czspare1-lap.sysgo.cz>
Mail-Followup-To: platform-driver-x86@kernel.org, r.marek@assembler.cz,
        devel@acpica.org, mingo@redhat.com, robert.moore@intel.com,
        linux-kernel@kernel.org, linux-acpi@vger.kernel.org
References: <cover.1647525033.git.vit@kabele.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1647525033.git.vit@kabele.me>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The ACPICA code assumes that EBDA region must be at least 1KiB in size.
Because this is not guaranteed, it might happen that while scanning the
memory for RSDP pointer, the kernel touches memory above 640KiB.

This is unwanted as the VGA memory range may not be decoded or
even present when running under virtualization.

Signed-off-by: Vit Kabele <vit@kabele.me>
Reviewed-by: Rudolf Marek <r.marek@assembler.cz>
---
 drivers/acpi/acpica/tbxfroot.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/acpica/tbxfroot.c b/drivers/acpi/acpica/tbxfroot.c
index 67b7df1c0520..b1f4a91044d9 100644
--- a/drivers/acpi/acpica/tbxfroot.c
+++ b/drivers/acpi/acpica/tbxfroot.c
@@ -114,6 +114,7 @@ acpi_find_root_pointer(acpi_physical_address *table_address)
 	u8 *table_ptr;
 	u8 *mem_rover;
 	u32 physical_address;
+	u32 ebda_window_size;
 
 	ACPI_FUNCTION_TRACE(acpi_find_root_pointer);
 
@@ -143,25 +144,32 @@ acpi_find_root_pointer(acpi_physical_address *table_address)
 	 */
 	if (physical_address > 0x400 &&
 	    physical_address < 0xA0000) {
+		/* Calculate the scan window size
+		 * The EBDA is not guaranteed to be larger than a KiB
+		 * and in case that it is smaller the scanning function would
+		 * leave the low memory and continue to the VGA range.
+		 */
+		ebda_window_size = ACPI_MIN(ACPI_EBDA_WINDOW_SIZE,
+					    0xA0000 - physical_address);
+
 		/*
-		 * 1b) Search EBDA paragraphs (EBDA is required to be a
-		 *     minimum of 1K length)
+		 * 1b) Search EBDA paragraphs
 		 */
 		table_ptr = acpi_os_map_memory((acpi_physical_address)
 					       physical_address,
-					       ACPI_EBDA_WINDOW_SIZE);
+					       ebda_window_size);
 		if (!table_ptr) {
 			ACPI_ERROR((AE_INFO,
 				    "Could not map memory at 0x%8.8X for length %u",
-				    physical_address, ACPI_EBDA_WINDOW_SIZE));
+				    physical_address, ebda_window_size));
 
 			return_ACPI_STATUS(AE_NO_MEMORY);
 		}
 
 		mem_rover =
 		    acpi_tb_scan_memory_for_rsdp(table_ptr,
-						 ACPI_EBDA_WINDOW_SIZE);
-		acpi_os_unmap_memory(table_ptr, ACPI_EBDA_WINDOW_SIZE);
+						 ebda_window_size);
+		acpi_os_unmap_memory(table_ptr, ebda_window_size);
 
 		if (mem_rover) {
 
-- 
2.30.2

