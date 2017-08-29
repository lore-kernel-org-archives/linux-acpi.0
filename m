From: Sinan Kaya <okaya@codeaurora.org>
Subject: Re: [PATCH] acpi: apei: call into AER handling regardless of severity
Date: Tue, 29 Aug 2017 18:34:49 -0400
Message-ID: <0fb1fe1b-207a-93fe-4ac6-b886451e488e@codeaurora.org>
References: <1503940314-29526-1-git-send-email-tbaicar@codeaurora.org>
 <20170829082055.u3qpwtgyzxjxfvup@pd.tnic>
 <9abb2e99-44be-3315-47d9-2689b6c76d79@codeaurora.org>
 <20170829221932.ojkvr4y6s76hcpkj@pd.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:42706 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751270AbdH2Wey (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 29 Aug 2017 18:34:54 -0400
In-Reply-To: <20170829221932.ojkvr4y6s76hcpkj@pd.tnic>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Borislav Petkov <bp@suse.de>, "Baicar, Tyler" <tbaicar@codeaurora.org>, Tony Luck <tony.luck@intel.com>
Cc: rjw@rjwysocki.net, lenb@kernel.org, will.deacon@arm.com, james.morse@arm.com, prarit@redhat.com, punit.agrawal@arm.com, shiju.jose@huawei.com, andriy.shevchenko@linux.intel.com, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Linux PCI <linux-pci@vger.kernel.org>

+linux-pci

On 8/29/2017 6:19 PM, Borislav Petkov wrote:
> if (entry.severity == AER_NONFATAL)
> 		do_recovery(pdev, entry.severity);

Providing input from PCI perspective only:

PCIe defines the the following error categories:

1. Correctable error
2. Uncorrectable non-fatal errors
3. Uncorrectable fatal errors

The do_recovery function needs to be called for both uncorrectable error
categories. (#2 and #3 above)

How these map to GHES error categories is out of know-how.

Below are references to some of the PCIe error docs:

https://www.kernel.org/doc/Documentation/PCI/pcieaer-howto.txt
https://www.kernel.org/doc/Documentation/PCI/pci-error-recovery.txt

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
