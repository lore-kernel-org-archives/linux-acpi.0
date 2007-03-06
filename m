From: Andrew Morton <akpm@linux-foundation.org>
Subject: acpi-fan-after-suspend-to-mem-fix.patch
Date: Mon, 5 Mar 2007 17:04:18 -0800
Message-ID: <20070305170418.866b3921.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.24]:44049 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933689AbXCFBFq (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 5 Mar 2007 20:05:46 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, Tommi Kyntola <tommi.kyntola@ray.fi>


Should I merge this into mainline??


From: Tommi Kyntola <tommi.kyntola@ray.fi>

acpi_fan_suspend should probably set state to ACPI_D3, rather than ACPI_D0.
 With this change the fan works after S3 suspend atleast on HP nw8000
laptop, for which the suspended fan has been broken since sword-and-stone.

Why this was ACPI_D0 beats me, but it's been that way since the
_suspend/_resume functios got added in the commit
0feabb01d93e5801d1127416a66cfc3963280bca (2.6.18-rc1, I think).

The fan hasn't worked on my HP nw8000 laptop after an S3 suspend ever, but
fixing that to ACPI_D3 there finally makes it work as expected.

If there was some hidden reason why that was set to ACPI_D0, then perhaps a
config option for some ICH4 or HP laptops is called for.

Signed-off-by: Tommi Kyntola <tommi.kyntola@ray.fi>
Cc: Len Brown <lenb@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/acpi/fan.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -puN drivers/acpi/fan.c~acpi-fan-after-suspend-to-mem-fix drivers/acpi/fan.c
--- a/drivers/acpi/fan.c~acpi-fan-after-suspend-to-mem-fix
+++ a/drivers/acpi/fan.c
@@ -241,7 +241,7 @@ static int acpi_fan_suspend(struct acpi_
 	if (!device)
 		return -EINVAL;
 
-	acpi_bus_set_power(device->handle, ACPI_STATE_D0);
+	acpi_bus_set_power(device->handle, ACPI_STATE_D3);
 
 	return AE_OK;
 }
_

