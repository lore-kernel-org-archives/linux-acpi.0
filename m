From: Zhao Yakui <yakui.zhao@intel.com>
Subject: Re: [PATCH] check that acpi_wakeup_address is below 1MB v2
Date: Fri, 11 Apr 2008 17:55:09 +0800
Message-ID: <1207907709.9448.19.camel@yakui_zhao.sh.intel.com>
References: <47FE87B0.7080709@free.fr>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:41764 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751821AbYDKCYr (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 10 Apr 2008 22:24:47 -0400
In-Reply-To: <47FE87B0.7080709@free.fr>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: matthieu castet <castet.matthieu@free.fr>
Cc: linux-acpi@vger.kernel.org

On Thu, 2008-04-10 at 23:33 +0200, matthieu castet wrote:
> Hi,
> 
> this patch add a check that the memory allocated for s3 wakeup is in the 
> first 1MB as required by acpi spec.
> 
Have you found whether some systems are afflicted by this ?

In fact that OS allacates the acpi_wake_address follows the below two
functions:
reserve_bootmem(0, PAGE_SIZE, BOOTMEM_DEFAULT);
reserve_bootmem(PAGE_SIZE, PAGE_SIZE, BOOTMEM_DEFAULT);

The above mechanism can insure that the acpi_wake_address is in memroy
below 1M. (It is unncessary to apply the patch. IMO)

Of course the addressing check will be more strict after this patch is
applied.

Best regards
   Yakui
> 
> Signed-off-by: "Matthieu CASTET <castet.matthieu@free.fr>"
> 

