Return-Path: <SRS0=VdvG=YR=vger.kernel.org=linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1F88CA9EC2
	for <linux-acpi@archiver.kernel.org>; Thu, 24 Oct 2019 19:13:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87F5B21A4C
	for <linux-acpi@archiver.kernel.org>; Thu, 24 Oct 2019 19:13:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406569AbfJXTNs (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Thu, 24 Oct 2019 15:13:48 -0400
Received: from mga01.intel.com ([192.55.52.88]:56945 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392926AbfJXTNr (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 24 Oct 2019 15:13:47 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Oct 2019 12:13:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,225,1569308400"; 
   d="scan'208";a="188686290"
Received: from sibelius.jf.intel.com ([10.54.75.23])
  by orsmga007.jf.intel.com with ESMTP; 24 Oct 2019 12:13:43 -0700
From:   Erik Schmauss <erik.schmauss@intel.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-acpi@vger.kernel.org
Cc:     Erik Schmauss <erik.schmauss@intel.com>,
        Bob Moore <robert.moore@intel.com>
Subject: [PATCH 10/12] ACPICA: acpiexec: initialize all simple types and field units from user input
Date:   Thu, 24 Oct 2019 11:55:54 -0700
Message-Id: <20191024185556.4606-11-erik.schmauss@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191024185556.4606-1-erik.schmauss@intel.com>
References: <20191024185556.4606-1-erik.schmauss@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

ACPICA commit 367b363edc5fa1f93bbc14e4a1e05f34fef765a2

acpiexec allows a user to provide a file that indicates values to
initialize named objects during table load with the -fi option. This
can provide more accurate simulation by setting named objects to
values found during OS runtime.

Previously, this option only supported integer objects. This change
adds user initialization support for field units, strings, buffers,
and packages.

Link: https://github.com/acpica/acpica/commit/367b363e
Signed-off-by: Erik Schmauss <erik.schmauss@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
---
 drivers/acpi/acpica/dsfield.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/acpica/dsfield.c b/drivers/acpi/acpica/dsfield.c
index 9151f00dfbdc..faa38a22263a 100644
--- a/drivers/acpi/acpica/dsfield.c
+++ b/drivers/acpi/acpica/dsfield.c
@@ -263,7 +263,6 @@ acpi_ds_get_field_names(struct acpi_create_field_info *info,
 	union acpi_parse_object *child;
 
 #ifdef ACPI_EXEC_APP
-	u64 value = 0;
 	union acpi_operand_object *result_desc;
 	union acpi_operand_object *obj_desc;
 	char *name_path;
@@ -405,19 +404,17 @@ acpi_ds_get_field_names(struct acpi_create_field_info *info,
 					name_path =
 					    acpi_ns_get_external_pathname(info->
 									  field_node);
-					obj_desc =
-					    acpi_ut_create_integer_object
-					    (value);
 					if (ACPI_SUCCESS
 					    (ae_lookup_init_file_entry
-					     (name_path, &value))) {
+					     (name_path, &obj_desc))) {
 						acpi_ex_write_data_to_field
 						    (obj_desc,
 						     acpi_ns_get_attached_object
 						     (info->field_node),
 						     &result_desc);
+						acpi_ut_remove_reference
+						    (obj_desc);
 					}
-					acpi_ut_remove_reference(obj_desc);
 					ACPI_FREE(name_path);
 #endif
 				}
-- 
2.21.0

