From: Carlos Corbacho <carlos@strangeworlds.co.uk>
Subject: Re: acer-wmi broken in latest git kernel on TravelMate 6492 (Insufficient arguments - method [WQAA])
Date: Sat, 2 Aug 2008 17:28:45 +0100
Message-ID: <200808021728.46046.carlos@strangeworlds.co.uk>
References: <alpine.LNX.1.10.0808021640310.2294@titan.stealer.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from phoenix.slamd64.com ([217.10.145.2]:33073 "EHLO
	phoenix.slamd64.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753352AbYHBQ26 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 2 Aug 2008 12:28:58 -0400
In-Reply-To: <alpine.LNX.1.10.0808021640310.2294@titan.stealer.net>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Sven Wegener <sven.wegener@stealer.net>
Cc: Bob Moore <robert.moore@intel.com>, Andi Kleen <ak@linux.intel.com>, Lin Ming <ming.m.lin@intel.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On Saturday 02 August 2008 16:50:54 Sven Wegener wrote:
> Is it a bug in acer-wmi or in Acer's ACPI implementation? I can provide 
> more information as necessary.

Neither - it's a bug in wmi.c

Try the following patch:
---
ACPI: WMI: Set instance for query block calls

From: Carlos Corbacho <carlos@strangeworlds.co.uk>

Although the necessary data structure was set up, it was never actually
passed in, so data block calls have only been working by sheer chance.

(On Acer laptops. the data block methods we've been calling never look at
the instance value, hence acer-wmi never triggered this before).

f3454ae8104efb2dbf0d08ec42c6f5d0fe9225bc brought this to light.

Signed-off-by: Carlos Corbacho <carlos@strangeworlds.co.uk>
---

 drivers/acpi/wmi.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)


diff --git a/drivers/acpi/wmi.c b/drivers/acpi/wmi.c
index c33b1c6..cfe2c83 100644
--- a/drivers/acpi/wmi.c
+++ b/drivers/acpi/wmi.c
@@ -347,7 +347,7 @@ struct acpi_buffer *out)
 	strcpy(method, "WQ");
 	strncat(method, block->object_id, 2);
 
-	status = acpi_evaluate_object(handle, method, NULL, out);
+	status = acpi_evaluate_object(handle, method, &input, out);
 
 	/*
 	 * If ACPI_WMI_EXPENSIVE, call the relevant WCxx method, even if
