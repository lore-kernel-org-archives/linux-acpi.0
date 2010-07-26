From: Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH] acpi: fix apei related table size checking
Date: Mon, 26 Jul 2010 09:13:17 +0200
Message-ID: <4C4D358D.8070709@linux.intel.com>
References: <4C49D3C5.4000007@kernel.org> <201007252223.32671.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:40720 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753335Ab0GZHNW (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 26 Jul 2010 03:13:22 -0400
In-Reply-To: <201007252223.32671.bjorn.helgaas@hp.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Yinghai Lu <yinghai@kernel.org>, Len Brown <lenb@kernel.org>, Huang Ying <ying.huang@intel.com>, Stephen Rothwell <sfr@canb.auug.org.au>, Tejun Heo <tj@kernel.org>, Daniel J Blueman <daniel.blueman@gmail.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

  On 7/26/2010 6:23 AM, Bjorn Helgaas wrote:
> On Friday, July 23, 2010 11:39:17 am Yinghai Lu wrote:
>> also check if we can find right action in apei.
>>
>> Signed-off-by: Yinghai Lu<yinghai@kernel.org>
> This should be split into two patches that each fix one thing.

... and the description actually describe what it is supposed to fix.

-Andi

