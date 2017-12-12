From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH V7 0/7] dmaengine: qcom_hidma: add support for bugfixed HW
Date: Tue, 12 Dec 2017 11:08:45 +0530
Message-ID: <20171212053845.GB18649@localhost>
References: <1512681031-11343-1-git-send-email-okaya@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:40721 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750749AbdLLFfB (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 12 Dec 2017 00:35:01 -0500
Content-Disposition: inline
In-Reply-To: <1512681031-11343-1-git-send-email-okaya@codeaurora.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Sinan Kaya <okaya@codeaurora.org>
Cc: dmaengine@vger.kernel.org, timur@codeaurora.org, devicetree@vger.kernel.org, linux-acpi@vger.kernel.org, sakari.ailus@linux.intel.com, linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Thu, Dec 07, 2017 at 04:10:24PM -0500, Sinan Kaya wrote:
> Introduce new ACPI and OF device ids for thw HW along with the helper
> functions.
> 
> Changes from v6:
> * add const to the device callback parameter in fwnode.
> * reorganize the callbacks in the code
> * rename get_match_data() as device_get_match_data()
> * place pointer checks into acpi_get_match_data()

This fails for me at 3rd patch. I am on -rc1 is there a dependency?

-- 
~Vinod
