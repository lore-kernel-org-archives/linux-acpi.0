From: "Baicar, Tyler" <tbaicar@codeaurora.org>
Subject: Re: [PATCH] ACPI, APEI: Fix BERT resources conflict with ACPI NVS
 area
Date: Tue, 14 Feb 2017 11:44:56 -0700
Message-ID: <1e80dbf3-c7d3-2bba-1032-ce775a2ea8a5@codeaurora.org>
References: <20170214020143.29713-1-ying.huang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:60480 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752506AbdBNSpA (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 14 Feb 2017 13:45:00 -0500
In-Reply-To: <20170214020143.29713-1-ying.huang@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Huang, Ying" <ying.huang@intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>
Cc: Len Brown <lenb@kernel.org>, Tomasz Nowicki <tomasz.nowicki@linaro.org>, Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@suse.de>, Fu Wei <fu.wei@linaro.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On 2/13/2017 7:01 PM, Huang, Ying wrote:
> From: Huang Ying <ying.huang@intel.com>
>
> It was reported that some firmware will use ACPI NVS area for BERT
> address range.  This will cause resources conflict because the ACPI
> NVS area is marked as busy already.  Fix this via excluding ACPI NVS
> area when requesting IO resources for BERT.
>
> Reported-and-tested-by: Hans Kristian Rosbach <hansr@raskesider.no>
> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
Tested-by: Tyler Baicar <tbaicar@codeaurora.org>

-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project.

