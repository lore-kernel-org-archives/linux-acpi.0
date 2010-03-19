From: Huang Ying <ying.huang@intel.com>
Subject: Re: [PATCH -v3 0/2] ACPI, APEI, use general HEST tabling parsing
 in AER firmware_first setup
Date: Fri, 19 Mar 2010 15:40:03 +0800
Message-ID: <1268984403.3596.14.camel@yhuang-dev.sh.intel.com>
References: <1268636261-31554-1-git-send-email-ying.huang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:28778 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751527Ab0CSHkH (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 19 Mar 2010 03:40:07 -0400
In-Reply-To: <1268636261-31554-1-git-send-email-ying.huang@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Jesse Barnes <jbarnes@virtuousgeek.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Andi Kleen <ak@linux.intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>

Hi, Len,

What do you think about this patchset?

Best Regards,
Huang Ying

On Mon, 2010-03-15 at 14:57 +0800, Huang, Ying wrote:
> Changelog:
> 
> v3:
> 
> - Move pcie_aer_get_firmware_first into aerdrv_acpi.c, and make
>   aer_set_firmware_first static in aerdrv_acpi.c. This makes external
>   interface simple and clear.
> 
> v2:
> 
> - Setup firmware_first for every PCIE end point instead of just root point.
> 
> - Wrap firmware_first accessing in a function, because HEST parsing involved.


