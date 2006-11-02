From: Jesper Juhl <jesper.juhl@gmail.com>
Subject: [PATCH][Trivial] ACPI: Get rid of 'unused variable' warning in  acpi_ev_global_lock_handler()
Date: Thu, 2 Nov 2006 13:13:22 +0100
Message-ID: <200611021313.22709.jesper.juhl@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from qb-out-0506.google.com ([72.14.204.227]:24553 "EHLO
	qb-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1752201AbWKBMLp (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 2 Nov 2006 07:11:45 -0500
Received: by qb-out-0506.google.com with SMTP id o24so125080qba
        for <linux-acpi@vger.kernel.org>; Thu, 02 Nov 2006 04:11:44 -0800 (PST)
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <len.brown@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, trivial@kernel.org, Jesper Juhl <jesper.juhl@gmail.com>

Fix this warning : 
  drivers/acpi/events/evmisc.c: In function `acpi_ev_global_lock_handler':
  drivers/acpi/events/evmisc.c:334: warning: unused variable `status'


Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
---

 drivers/acpi/events/evmisc.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/drivers/acpi/events/evmisc.c b/drivers/acpi/events/evmisc.c
index ee2a10b..bf63edc 100644
--- a/drivers/acpi/events/evmisc.c
+++ b/drivers/acpi/events/evmisc.c
@@ -331,7 +331,6 @@ static void ACPI_SYSTEM_XFACE acpi_ev_gl
 static u32 acpi_ev_global_lock_handler(void *context)
 {
 	u8 acquired = FALSE;
-	acpi_status status;
 
 	/*
 	 * Attempt to get the lock


