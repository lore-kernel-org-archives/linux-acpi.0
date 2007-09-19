From: Alexey Starikovskiy <aystarik@gmail.com>
Subject: Re: Fw: 2.6.23-rc6-mm1 and acpi
Date: Wed, 19 Sep 2007 14:33:00 +0400
Message-ID: <46F0FADC.6080805@gmail.com>
References: <20070919014932.316bb9d6.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------050400090105030507060800"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.171]:1040 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753396AbXISKc6 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 19 Sep 2007 06:32:58 -0400
Received: by ug-out-1314.google.com with SMTP id z38so208855ugc
        for <linux-acpi@vger.kernel.org>; Wed, 19 Sep 2007 03:32:57 -0700 (PDT)
In-Reply-To: <20070919014932.316bb9d6.akpm@linux-foundation.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-acpi@vger.kernel.org, Michael Gerdau <mgerdau@tiscali.de>

This is a multi-part message in MIME format.
--------------050400090105030507060800
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Please add following patch.

Thanks,
Alex.

Andrew Morton wrote:
> 
> Begin forwarded message:
> 
> Date: Tue, 18 Sep 2007 23:42:25 +0200
> From: Michael Gerdau <mgerdau@tiscali.de>
> To: linux-kernel@vger.kernel.org
> Subject: 2.6.23-rc6-mm1 and acpi
> 
> 
> Hi,
> 
> while trying to compile 2.6.23-rc6-mm1 I came across the following
> build error:
> 
> mgd@seneca:/usr/src/linux-2.6.23-rc6-mm1> make modules
>   CHK     include/linux/version.h
>   CHK     include/linux/utsrelease.h
>   CALL    scripts/checksyscalls.sh
> <stdin>:1389:2: warning: #warning syscall revokeat not implemented
> <stdin>:1393:2: warning: #warning syscall frevoke not implemented
>   CC [M]  drivers/acpi/sbs.o
> drivers/acpi/sbs.c: In function ‘acpi_battery_alarm_show’:
> drivers/acpi/sbs.c:457: error: implicit declaration of function ‘acpi_battery_get_alarm’
> drivers/acpi/sbs.c: In function ‘acpi_battery_alarm_store’:
> drivers/acpi/sbs.c:472: error: implicit declaration of function ‘acpi_battery_set_alarm’
> drivers/acpi/sbs.c: In function ‘acpi_battery_add’:
> drivers/acpi/sbs.c:829: warning: ignoring return value of ‘device_create_file’, declared with attribute warn_unused_result
> make[2]: *** [drivers/acpi/sbs.o] Fehler 1
> make[1]: *** [drivers/acpi] Fehler 2
> make: *** [drivers] Fehler 2
> 
> Not sure who to CC, which is why I send it to the list alone.
> 
> Best,
> Michael


--------------050400090105030507060800
Content-Type: text/x-patch;
 name="fix-sbs-add_alarm.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="fix-sbs-add_alarm.patch"

ACPI: SBS: fix sbs add alarm patch

From: Alexey Starikovskiy <astarikovskiy@suse.de>

Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
---

 drivers/acpi/sbs.c |    4 ----
 1 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/sbs.c b/drivers/acpi/sbs.c
index 3f249df..a8fed51 100644
--- a/drivers/acpi/sbs.c
+++ b/drivers/acpi/sbs.c
@@ -395,8 +395,6 @@ static int acpi_battery_get_state(struct acpi_battery *battery)
 	return result;
 }
 
-#ifdef CONFIG_ACPI_PROCFS
-
 static int acpi_battery_get_alarm(struct acpi_battery *battery)
 {
 	return acpi_smbus_read(battery->sbs->hc, SMBUS_READ_WORD,
@@ -433,8 +431,6 @@ static int acpi_battery_set_alarm(struct acpi_battery *battery)
 	return ret;
 }
 
-#endif
-
 static int acpi_ac_get_present(struct acpi_sbs *sbs)
 {
 	int result;

--------------050400090105030507060800--
