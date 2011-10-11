From: Huang Ying <ying.huang@intel.com>
Subject: Re: [PATCH v2] ACPI, APEI, EINJ, Refine the fix of resource conflict
Date: Tue, 11 Oct 2011 15:01:14 +0800
Message-ID: <4E93E9BA.3020106@intel.com>
References: <4E93DF1F.8030004@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:31471 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750867Ab1JKHBQ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 11 Oct 2011 03:01:16 -0400
In-Reply-To: <4E93DF1F.8030004@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Xiao, Hui" <hui.xiao@linux.intel.com>, "lenb@kernel.org" <lenb@kernel.org>
Cc: "Chen, Gong" <gong.chen@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On 10/11/2011 02:15 PM, Xiao, Hui wrote:
> Current fix for resource conflict is to remove the address region <param1 &
> param2, ~param2+1> from trigger resource, which is highly relies on valid user
> input. This patch is trying to avoid such potential issues by fetching the
> exact address region from trigger action table entry.
> 
> v2: minor fixes
> 
> Signed-off-by: Xiao, Hui <hui.xiao@linux.intel.com>

Acked-by: Huang Ying <ying.huang@intel.com>

Hi, Len,

Can you merged this patch after my APEI patchset?

Best Regards,
Huang Ying
