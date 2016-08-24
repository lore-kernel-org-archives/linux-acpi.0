From: Sinan Kaya <okaya@codeaurora.org>
Subject: Re: [PATCH] PCI: release pci_host_bridge resource after remove root
 bus
Date: Wed, 24 Aug 2016 17:48:48 -0400
Message-ID: <c9129658-d500-ac4c-ccd7-090ebcbf731d@codeaurora.org>
References: <1466682138-25281-1-git-send-email-wangyijing@huawei.com>
 <20160822172821.GG18628@localhost> <57BBB383.50503@huawei.com>
 <20160824213921.GH23914@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:35366 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757085AbcHXVsw (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 24 Aug 2016 17:48:52 -0400
In-Reply-To: <20160824213921.GH23914@localhost>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <helgaas@kernel.org>, wangyijing <wangyijing@huawei.com>
Cc: bhelgaas@google.com, rjw@rjwysocki.net, linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org

On 8/24/2016 5:39 PM, Bjorn Helgaas wrote:
>> Yes, may some pci drivers make a mistake, the refcount control the device object
>> > release is fine, but I think move the mem resource release out is better.
> If this is caused by driver bugs, I think we need to fix the driver
> bugs.
> 
> So far all I see here is "it works when I do this."  What we need is
> an argument for "it's correct to do this."  It's certainly possible
> that you're already making that argument and I'm just not
> understanding it.
> 

I also want to point out that the sysfs is not the only device removal
path. As Bjorn pointed out, you were moving resource free code into the sysfs
path and breaking other path (ACPI hotplug).

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
