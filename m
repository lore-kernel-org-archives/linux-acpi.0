From: Len Brown <len.brown@intel.com>
Subject: Re: 2.6.18-rc4-mm2
Date: Mon, 21 Aug 2006 19:22:09 -0400
Message-ID: <200608211922.10182.len.brown@intel.com>
References: <20060819220008.843d2f64.akpm@osdl.org> <20060821064411.20e61aa0.akpm@osdl.org> <44EA1585.8020303@gmail.com>
Reply-To: Len Brown <lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:9913 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S1751300AbWHUXUY (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Mon, 21 Aug 2006 19:20:24 -0400
In-Reply-To: <44EA1585.8020303@gmail.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Maciej Rutecki <maciej.rutecki@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

Please dump the stack so we can find the secretive caller to 
acpi_format_exception().

thanks,
-Len

diff --git a/drivers/acpi/utilities/utglobal.c b/drivers/acpi/utilities/utglobal.c
index 014030a..561ea5e 100644
--- a/drivers/acpi/utilities/utglobal.c
+++ b/drivers/acpi/utilities/utglobal.c
@@ -125,6 +125,7 @@ const char *acpi_format_exception(acpi_s
 			    "Unknown exception code: 0x%8.8X", status));
 
 		exception = "UNKNOWN_STATUS_CODE";
+dump_stack();
 	}
 
 	return (ACPI_CAST_PTR(const char, exception));

