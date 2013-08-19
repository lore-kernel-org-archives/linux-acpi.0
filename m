From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH] acpi_i2c: set MODULE_LICENSE, MODULE_AUTHOR, and
 MODULE_DESCRIPTION
Date: Mon, 19 Aug 2013 09:16:14 +0300
Message-ID: <20130819061614.GG4898@intel.com>
References: <1376702795-25912-1-git-send-email-jerry.snitselaar@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:33699 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750911Ab3HSGKq (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 19 Aug 2013 02:10:46 -0400
Content-Disposition: inline
In-Reply-To: <1376702795-25912-1-git-send-email-jerry.snitselaar@oracle.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jerry Snitselaar <jerry.snitselaar@oracle.com>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, rjw@sisk.pl

On Fri, Aug 16, 2013 at 06:26:35PM -0700, Jerry Snitselaar wrote:
> Without MODULE_LICENSE set, I get the following with modprobe:
> 
> acpi_i2c: module license 'unspecified' taints kernel.
> acpi_i2c: Unknown symbol i2c_new_device (err 0)
> acpi_i2c: Unknown symbol acpi_dev_get_resources (err 0)
> acpi_i2c: Unknown symbol acpi_dev_resource_interrupt (err 0)
> acpi_i2c: Unknown symbol acpi_dev_free_resource_list (err 0)
> 
> Signed-off-by: Jerry Snitselaar <jerry.snitselaar@oracle.com>

Looks good to me.

Acked-by: Mika Westerbeg <mika.westerberg@linux.intel.com>
