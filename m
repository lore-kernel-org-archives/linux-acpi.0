From: Anisse Astier <anisse@astier.eu>
Subject: [PATCH] ACPICA: update documentation to reflect correct parameter
 name
Date: Fri, 4 Dec 2009 15:36:05 +0100
Message-ID: <20091204153605.73fc9202@destiny.ordissimo>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ew0-f171.google.com ([209.85.219.171]:63136 "EHLO
	mail-ew0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752688AbZLDOhv (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 4 Dec 2009 09:37:51 -0500
Received: by ewy19 with SMTP id 19so314807ewy.1
        for <linux-acpi@vger.kernel.org>; Fri, 04 Dec 2009 06:37:57 -0800 (PST)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Len Brown <lenb@kernel.org>, Bob Moore <robert.moore@intel.com>, Jiri Kosina <jkosina@suse.cz>


Second parameter for function acpi_ut_copy_iobject_to_eobject is named
ret_buffer, not buffer_ptr, since longer than git can remember.

Signed-off-by: Anisse Astier <anisse@astier.eu>
---
Hi,

ACPICA is somewhat auto-generated. How can this trivial patch be applied?

Regards,

Anisse

 drivers/acpi/acpica/utcopy.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/acpi/acpica/utcopy.c b/drivers/acpi/acpica/utcopy.c
index 0f0c64b..ecfa7f9 100644
--- a/drivers/acpi/acpica/utcopy.c
+++ b/drivers/acpi/acpica/utcopy.c
@@ -382,7 +382,7 @@ acpi_ut_copy_ipackage_to_epackage(union
acpi_operand_object *internal_object,
  * FUNCTION:    acpi_ut_copy_iobject_to_eobject
  *
  * PARAMETERS:  internal_object     - The internal object to be converted
- *              buffer_ptr          - Where the object is returned
+ *              ret_buffer          - Where the object is returned
  *
  * RETURN:      Status
  *
-- 
1.6.5.3

