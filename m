From: Alexey Starikovskiy <alexey.y.starikovskiy@linux.intel.com>
Subject: Re: [PATCH 10/20] ACPI: ec: fix race in status register access
Date: Sat, 10 Mar 2007 10:29:04 +0300
Message-ID: <45F25E40.3040908@linux.intel.com>
References: <11734985781377-git-send-email-len.brown@intel.com> <11734985791126-git-send-email-len.brown@intel.com> <1173498580364-git-send-email-len.brown@intel.com> <11734985813852-git-send-email-len.brown@intel.com> <11734985822692-git-send-email-len.brown@intel.com> <11734985822425-git-send-email-len.brown@intel.com> <11734985831806-git-send-email-len.brown@intel.com> <11734985842575-git-send-email-len.brown@intel.com> <1173498585454-git-send-email-len.brown@intel.com> <11734985862291-git-send-email-len.brown@intel.com> <11734985863491-git-send-email-len.brown@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga07.intel.com ([143.182.124.22]:24149 "EHLO
	azsmga101.ch.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S933509AbXCJH3I (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 10 Mar 2007 02:29:08 -0500
In-Reply-To: <11734985863491-git-send-email-len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <len.brown@intel.com>
Cc: linux-acpi@vger.kernel.org, Alexey Starikovskiy <alexey.y.starikovskiy@intel.com>

Len Brown wrote:
> @@ -807,6 +812,7 @@ acpi_fake_ecdt_callback(acpi_handle handle,
>  	acpi_status status;
>  
>  	mutex_init(&ec_ecdt->lock);
> +	atomic_set(&ec->event_count, 1);
>  	if (acpi_ec_mode == EC_INTR) {
>  		init_waitqueue_head(&ec_ecdt->wait);
>  	}
>   
here it should be ec_ecdt, not ec to make it compile...
