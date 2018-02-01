From: Sinan Kaya <okaya@codeaurora.org>
Subject: Re: [PATCH v2 6/6] device property: Constify device_get_match_data()
Date: Thu, 1 Feb 2018 15:35:30 -0500
Message-ID: <bfeef6d8-15d0-84f7-947f-f849616151a8@codeaurora.org>
References: <20180201202012.36524-1-andriy.shevchenko@linux.intel.com>
 <20180201202012.36524-6-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:33416 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754772AbeBAUfc (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 1 Feb 2018 15:35:32 -0500
In-Reply-To: <20180201202012.36524-6-andriy.shevchenko@linux.intel.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, dmaengine <dmaengine@vger.kernel.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>, Vinod Koul <vinod.koul@intel.com>

On 2/1/2018 3:20 PM, Andy Shevchenko wrote:
> -void *device_get_match_data(struct device *dev)
> +const void *device_get_match_data(struct device *dev)
>  {
> -	return fwnode_call_ptr_op(dev_fwnode(dev), device_get_match_data,
> -				  dev);
> +	return fwnode_call_ptr_op(dev_fwnode(dev), device_get_match_data, dev);
>  }

I remember having a checkpatch problem here.

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
