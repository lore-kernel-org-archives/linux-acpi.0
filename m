From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH v4 4/5] device property: Introduce
 fwnode_device_is_available()
Date: Wed, 31 May 2017 13:17:44 +0300
Message-ID: <20170531101744.GF2784@lahna.fi.intel.com>
References: <1495443202-22817-1-git-send-email-sakari.ailus@linux.intel.com>
 <1495443202-22817-5-git-send-email-sakari.ailus@linux.intel.com>
 <20170531095804.GD2784@lahna.fi.intel.com>
 <9a32d562-8335-2b10-8aaa-e74d919636a0@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:61714 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751002AbdEaKSA (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 31 May 2017 06:18:00 -0400
Content-Disposition: inline
In-Reply-To: <9a32d562-8335-2b10-8aaa-e74d919636a0@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: linux-acpi@vger.kernel.org, devicetree@vger.kernel.org, sudeep.holla@arm.com, lorenzo.pieralisi@arm.com, rafael@kernel.org, mark.rutland@arm.com, broonie@kernel.org, robh@kernel.org, ahs3@redhat.com, frowand.list@gmail.com

On Wed, May 31, 2017 at 01:12:35PM +0300, Sakari Ailus wrote:
> On 05/31/17 12:58, Mika Westerberg wrote:
> > On Mon, May 22, 2017 at 11:53:21AM +0300, Sakari Ailus wrote:
> >>  /**
> >> + * fwnode_device_is_available - check if a device is available for use
> >> + * @fwnode: Pointer to the fwnode of the device.
> >> + */
> >> +bool fwnode_device_is_available(struct fwnode_handle *fwnode)
> > 
> > Can it be const instead? Ditto for of_fwnode_device_is_available() and
> > acpi_fwnode_device_is_available) and the .device_available() hook.
> > 
> 
> In principle yes, but it will require other changes in the ACPI
> framework as well that do not suit well yet for this patchset.

Fair enough.
