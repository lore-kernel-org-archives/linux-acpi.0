From: Alexey Starikovskiy <alexey.y.starikovskiy@linux.intel.com>
Subject: Re: 2.6.19-rc5 nasty ACPI regression, AE_TIME errors
Date: Wed, 15 Nov 2006 17:48:18 +0300
Message-ID: <455B28B2.4010707@linux.intel.com>
References: <200611142303.47325.david-b@pacbell.net> <200611150248.12578.len.brown@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------030109050807050601050305"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga07.intel.com ([143.182.124.22]:62011 "EHLO
	azsmga101.ch.intel.com") by vger.kernel.org with ESMTP
	id S1030511AbWKOOsn (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 15 Nov 2006 09:48:43 -0500
In-Reply-To: <200611150248.12578.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: David Brownell <david-b@pacbell.net>, Linux Kernel list <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org

This is a multi-part message in MIME format.
--------------030109050807050601050305
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Could you try if attached patch helps?


Regards,
    Alex







--------------030109050807050601050305
Content-Type: text/plain;
 name="ec1.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ec1.patch"

Always enable GPE after return from notify handler.

From:  Alexey Starikovskiy <alexey.y.starikovskiy@linux.intel.com>


---

 drivers/acpi/ec.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index e6d4b08..937eafc 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -465,8 +465,6 @@ static u32 acpi_ec_gpe_handler(void *dat
 
 	if (value & ACPI_EC_FLAG_SCI) {
 		status = acpi_os_execute(OSL_EC_BURST_HANDLER, acpi_ec_gpe_query, ec);
-		return status == AE_OK ?
-		    ACPI_INTERRUPT_HANDLED : ACPI_INTERRUPT_NOT_HANDLED;
 	}
 	acpi_enable_gpe(NULL, ec->gpe_bit, ACPI_ISR);
 	return status == AE_OK ?

--------------030109050807050601050305--
