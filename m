From: Vasilis Liaskovitis <vasilis.liaskovitis@profitbricks.com>
Subject: [PATCH 0/2] mm/acpi hotplug fixes for hot-remove
Date: Thu,  5 Apr 2012 20:07:00 +0200
Message-ID: <1333649222-24285-1-git-send-email-vasilis.liaskovitis@profitbricks.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:48627 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753796Ab2DESHv (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 5 Apr 2012 14:07:51 -0400
Received: by bkcik5 with SMTP id ik5so1590279bkc.19
        for <linux-acpi@vger.kernel.org>; Thu, 05 Apr 2012 11:07:50 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-mm@kvack.org, linux-acpi@vger.kernel.org
Cc: Vasilis Liaskovitis <vasilis.liaskovitis@profitbricks.com>

On memory hot-remove, the acpi_memhotplug driver currently offlines memory but
does not remove section mappings and sysfs entries. Additionally, memory
resource registration is done inconsistently on hot-add and hot-remove. This
series attempts to address the 2 issues.

(Note that testing memory hot-remove with SPARSEMEM_VMEMMAP=y will currently
fail, since freeing the sparse_vmemmap is not yet supported.)

Vasilis Liaskovitis (2):
  acpi: remove section mappings on memory hot-remove
  mm: consistently register / release memory resource

 drivers/acpi/acpi_memhotplug.c |   17 ++++++++++++++++-
 mm/memory_hotplug.c            |    4 ++--
 2 files changed, 18 insertions(+), 3 deletions(-)

-- 
1.7.9

