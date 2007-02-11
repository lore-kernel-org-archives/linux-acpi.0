From: Alexey Starikovskiy <alexey.y.starikovskiy@linux.intel.com>
Subject: Re: current git breaks resume
Date: Sun, 11 Feb 2007 17:34:26 +0300
Message-ID: <45CF2972.40902@linux.intel.com>
References: <20070209190307.GC6152@kernel.dk> <200702110002.38328.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------030304030100030406030309"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga07.intel.com ([143.182.124.22]:3555 "EHLO
	azsmga101.ch.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750849AbXBKOeb (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 11 Feb 2007 09:34:31 -0500
In-Reply-To: <200702110002.38328.lenb@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Jens Axboe <jens.axboe@oracle.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030304030100030406030309
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Len Brown wrote:
> On Friday 09 February 2007 14:03, Jens Axboe wrote:
>   
>> Hi,
>>
>> Unfortunately I'm a little short on time as I'll be travelling tomorrow,
>> but of course preparing a new kernel for the laptop is something you
>> want to do right before leaving. So I discovered that the current (well
>> as of yesterday, HEAD is 5986a2ec35836a878350c54af4bd91b1de6abc59)
>> doesn't resume on my x60. 2.6.20 works fine, so something broke since
>> then.
>>     
>
> resume from RAM, or resume from disk?
>
>   
Len,
resume from RAM is still broken by "Disable all wakeup GPEs". My 
previous patch for T43 does not help, only attached one helps (revert 
original patch).

--------------030304030100030406030309
Content-Type: text/plain;
 name="fix-disable_all_wake_gpes.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="fix-disable_all_wake_gpes.patch"

Disable wake GPEs only once.

From: Alexey Starikovskiy <alexey.y.starikovskiy@linux.intel.com>


---

 drivers/acpi/events/evgpe.c |   11 -----------
 1 files changed, 0 insertions(+), 11 deletions(-)

diff --git a/drivers/acpi/events/evgpe.c b/drivers/acpi/events/evgpe.c
index dfac3ec..635ba44 100644
--- a/drivers/acpi/events/evgpe.c
+++ b/drivers/acpi/events/evgpe.c
@@ -636,17 +636,6 @@ acpi_ev_gpe_dispatch(struct acpi_gpe_eve
 		}
 	}
 
-	if (!acpi_gbl_system_awake_and_running) {
-		/*
-		 * We just woke up because of a wake GPE. Disable any further GPEs
-		 * until we are fully up and running (Only wake GPEs should be enabled
-		 * at this time, but we just brute-force disable them all.)
-		 * 1) We must disable this particular wake GPE so it won't fire again
-		 * 2) We want to disable all wake GPEs, since we are now awake
-		 */
-		(void)acpi_hw_disable_all_gpes();
-	}
-
 	/*
 	 * Dispatch the GPE to either an installed handler, or the control method
 	 * associated with this GPE (_Lxx or _Exx). If a handler exists, we invoke

--------------030304030100030406030309--
