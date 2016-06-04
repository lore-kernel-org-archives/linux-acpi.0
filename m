From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: re: ACPICA: ACPI 2.0, Interpreter: Fix MLC issues by switching to
 new TermList grammar for table loading
Date: Sat, 4 Jun 2016 17:04:15 +0300
Message-ID: <20160604140415.GA3344@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:30125 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750862AbcFDOEg (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 4 Jun 2016 10:04:36 -0400
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lv.zheng@intel.com
Cc: linux-acpi@vger.kernel.org

Hello Lv Zheng,

The patch 0bfd2f1ec274: "ACPICA: ACPI 2.0, Interpreter: Fix MLC
issues by switching to new TermList grammar for table loading" from
May 13, 2016, leads to the following static checker warning:

	drivers/acpi/acpica/nsparse.c:139 acpi_ns_execute_table()
	error: we previously assumed 'info' could be null (see line 110)

drivers/acpi/acpica/nsparse.c
   135          (void)acpi_ut_acquire_mutex(ACPI_MTX_NAMESPACE);
   136  
   137  cleanup:
   138          acpi_ut_remove_reference(method_obj);
   139          ACPI_FREE(info->full_pathname);
                          ^^^^^^^^^^^^^^^^^^^
Archetypal one err bug.  It's better to unwind in reverse order from how
you allacted things and only free things you have allocated.  Use more
than one label.  Also you can use more descriptive label names.

	(void)acpi_ut_acquire_mutex(ACPI_MTX_NAMESPACE);

free_pathname:
	ACPI_FREE(info->full_pathname);
free_info:
	ACPI_FREE(info);
remove_method:
	acpi_ut_remove_reference(method_obj);

	return_ACPI_STATUS(status);


   140          info->full_pathname = NULL;
   141          ACPI_FREE(info);
   142          return_ACPI_STATUS(status);
   143  }

regards,
dan carpenter
