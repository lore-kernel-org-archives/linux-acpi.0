From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH] acpi-dma: Use ACPI_COMPANION() instead of
 acpi_bus_get_device()
Date: Wed, 30 Sep 2015 12:22:43 +0530
Message-ID: <20150930065243.GE21690@vkoul-mobl.iind.intel.com>
References: <1441372350-11630-1-git-send-email-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:30272 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754004AbbI3Gx3 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 30 Sep 2015 02:53:29 -0400
Content-Disposition: inline
In-Reply-To: <1441372350-11630-1-git-send-email-jarkko.nikula@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc: dmaengine@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>, linux-acpi@vger.kernel.org

On Fri, Sep 04, 2015 at 04:12:30PM +0300, Jarkko Nikula wrote:
> Get pointer to the struct acpi_device by using ACPI_COMPANION() macro. This
> is more efficient than using ACPI_HANDLE() and acpi_bus_get_device().

Applied aftre fixing the right subsystem name. Please ensure you send
patches with right tags


-- 
~Vinod
