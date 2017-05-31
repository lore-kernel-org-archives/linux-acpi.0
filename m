From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH v4 4/5] device property: Introduce
 fwnode_device_is_available()
Date: Wed, 31 May 2017 12:58:04 +0300
Message-ID: <20170531095804.GD2784@lahna.fi.intel.com>
References: <1495443202-22817-1-git-send-email-sakari.ailus@linux.intel.com>
 <1495443202-22817-5-git-send-email-sakari.ailus@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:51245 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751004AbdEaJ6W (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 31 May 2017 05:58:22 -0400
Content-Disposition: inline
In-Reply-To: <1495443202-22817-5-git-send-email-sakari.ailus@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: linux-acpi@vger.kernel.org, devicetree@vger.kernel.org, sudeep.holla@arm.com, lorenzo.pieralisi@arm.com, rafael@kernel.org, mark.rutland@arm.com, broonie@kernel.org, robh@kernel.org, ahs3@redhat.com, frowand.list@gmail.com

On Mon, May 22, 2017 at 11:53:21AM +0300, Sakari Ailus wrote:
>  /**
> + * fwnode_device_is_available - check if a device is available for use
> + * @fwnode: Pointer to the fwnode of the device.
> + */
> +bool fwnode_device_is_available(struct fwnode_handle *fwnode)

Can it be const instead? Ditto for of_fwnode_device_is_available() and
acpi_fwnode_device_is_available) and the .device_available() hook.
