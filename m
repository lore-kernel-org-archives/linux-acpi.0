From: "Mike D. Day" <ncmike@us.ibm.com>
Subject: [KJ][PATCH] acpi: remove unused variable
Date: Wed, 1 Nov 2006 14:32:48 -0500
Message-ID: <20061101193248.GA5176@silverwood.ncultra.org>
Reply-To: ncmike@us.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from e35.co.us.ibm.com ([32.97.110.153]:13766 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S2992752AbWKATc4
	(ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 1 Nov 2006 14:32:56 -0500
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e35.co.us.ibm.com (8.13.8/8.12.11) with ESMTP id kA1JWoON027138
	for <linux-acpi@vger.kernel.org>; Wed, 1 Nov 2006 14:32:50 -0500
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay04.boulder.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id kA1JWo5b340694
	for <linux-acpi@vger.kernel.org>; Wed, 1 Nov 2006 12:32:50 -0700
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id kA1JWnTJ003224
	for <linux-acpi@vger.kernel.org>; Wed, 1 Nov 2006 12:32:49 -0700
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: kernel-janitors@lists.osdl.org
Cc: len.brown@intel.com, linux-acpi@vger.kernel.org


Remove unused variable in acpi/events/evmisc.c

Signed-off-by: Mike D. Day <ncmike@us.ibm.com>

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

-- 
Mike D. Day
IBM LTC
Cell: 919 412-3900
Sametime: ncmike@us.ibm.com AIM: ncmikeday  Yahoo: ultra.runner
PGP key: http://www.ncultra.org/ncmike/pubkey.asc
