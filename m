From: Al Stone <ahs3@redhat.com>
Subject: [PATCH 0/2] minor ACPI source file cleanup
Date: Fri, 19 Aug 2016 17:16:33 -0600
Message-ID: <1471648595-7365-1-git-send-email-ahs3@redhat.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:58712 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755137AbcHSXQl (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 19 Aug 2016 19:16:41 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: ahs3@redhat.com

The first patch is a trivial whitespace cleanup.  The second is also
simple in that it removes a duplicate declaration from a header file.

Al Stone (2):
  ACPI: remove extraneous whitespace from a comment
  ACPI: remove duplicate declaration for acpi_table_parse_entries()

 drivers/acpi/tables.c | 2 +-
 include/linux/acpi.h  | 4 ----
 2 files changed, 1 insertion(+), 5 deletions(-)

-- 
2.7.4

