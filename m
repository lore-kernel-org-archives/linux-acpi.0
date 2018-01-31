From: Sinan Kaya <okaya@codeaurora.org>
Subject: Re: [PATCH v1 1/4] ACPI / bus: Remove checks in acpi_get_match_data()
Date: Wed, 31 Jan 2018 17:17:23 -0500
Message-ID: <b52b3995-ec9c-660d-6c2f-afebf3864b90@codeaurora.org>
References: <20180131212959.68766-1-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:38922 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751360AbeAaWR0 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 31 Jan 2018 17:17:26 -0500
In-Reply-To: <20180131212959.68766-1-andriy.shevchenko@linux.intel.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, dmaengine <dmaengine@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>, Vinod Koul <vinod.koul@intel.com>

On 1/31/2018 4:29 PM, Andy Shevchenko wrote:
> As well as its sibling of_device_get_match_data() has no such checks,
> no need to do it in acpi_get_match_data().
> 
> First of all, we are not supposed to call fwnode API like this without
> driver attached.
> 
> Second, if pure OF driver calls this function, it's weird to have ACPI
> companion without ACPI ID in this case.

We talked about this during review. 

of_match_device() does all the checking for the OF part. ACPI doesn't have
any checks.

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
