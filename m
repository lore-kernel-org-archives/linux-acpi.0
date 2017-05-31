From: Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: Re: [PATCH v4 4/5] device property: Introduce
 fwnode_device_is_available()
Date: Wed, 31 May 2017 13:12:35 +0300
Message-ID: <9a32d562-8335-2b10-8aaa-e74d919636a0@linux.intel.com>
References: <1495443202-22817-1-git-send-email-sakari.ailus@linux.intel.com>
 <1495443202-22817-5-git-send-email-sakari.ailus@linux.intel.com>
 <20170531095804.GD2784@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:42176 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751063AbdEaKMt (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 31 May 2017 06:12:49 -0400
In-Reply-To: <20170531095804.GD2784@lahna.fi.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: linux-acpi@vger.kernel.org, devicetree@vger.kernel.org, sudeep.holla@arm.com, lorenzo.pieralisi@arm.com, rafael@kernel.org, mark.rutland@arm.com, broonie@kernel.org, robh@kernel.org, ahs3@redhat.com, frowand.list@gmail.com

On 05/31/17 12:58, Mika Westerberg wrote:
> On Mon, May 22, 2017 at 11:53:21AM +0300, Sakari Ailus wrote:
>>  /**
>> + * fwnode_device_is_available - check if a device is available for use
>> + * @fwnode: Pointer to the fwnode of the device.
>> + */
>> +bool fwnode_device_is_available(struct fwnode_handle *fwnode)
> 
> Can it be const instead? Ditto for of_fwnode_device_is_available() and
> acpi_fwnode_device_is_available) and the .device_available() hook.
> 

In principle yes, but it will require other changes in the ACPI
framework as well that do not suit well yet for this patchset.

I have another patchset that makes fwnode arguments const whenever it's
possible:

<URL:http://www.spinics.net/lists/devicetree/msg177564.html>

-- 
Sakari Ailus
sakari.ailus@linux.intel.com
