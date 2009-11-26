From: Jonathan Cameron <jic23@cam.ac.uk>
Subject: Re: [PATCH 2/2] als: add unique device-ids to the als device class
Date: Thu, 26 Nov 2009 18:40:04 +0000
Message-ID: <4B0ECB84.9010503@cam.ac.uk>
References: <1259237081-4403-1-git-send-email-amit.kucheria@verdurent.com> <1259237186-5459-1-git-send-email-amit.kucheria@verdurent.com> <20091126160713.5e19eb04@hyperion.delvare> <4B0EB891.4010309@cam.ac.uk> <20091126180646.GA9059@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ppsw-0.csi.cam.ac.uk ([131.111.8.130]:46211 "EHLO
	ppsw-0.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751517AbZKZSkD (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 26 Nov 2009 13:40:03 -0500
In-Reply-To: <20091126180646.GA9059@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Greg KH <gregkh@suse.de>
Cc: Jean Delvare <khali@linux-fr.org>, Amit Kucheria <amit.kucheria@verdurent.com>, List Linux Kernel <linux-kernel@vger.kernel.org>, rui.zhang@intel.com, alan@linux.intel.com, linux-acpi@vger.kernel.org

Greg KH wrote:
> On Thu, Nov 26, 2009 at 05:19:13PM +0000, Jonathan Cameron wrote:
>>> That being said... If we want user-space to know what device is there,
>>> we may want to still let drivers pass a name string to
>>> als_device_register() and let the ALS core create a "name" sysfs
>>> attribute returning the string in question. This would be much lighter
>>> (for individual drivers) than the previous situation, as the string in
>>> question would be a constant (e.g. "TSL2550".) Opinions?
>>>
>> Makes sense given we want all drivers to support some form of identification.
>> We could do it by stating they will all have that attribute, but given it's constant
>> will save repetition to put it in the driver. Conversely it might complicate the handling
>> of subsequent attribute_groups so I'd probably favour adding relevant documentation lines
>> and leaving it up to the drivers to implement this attribute.
>>
>> Thus we'd require (within reason) all drivers to have illuminance0 and name.
> 
> Why have a name attribute when you can just use the name of the device
> itself instead?  Isn't that what it is there for?
Could do, though I'm not entirely sure all bus types are implementing a name
attribute (I may be wrong, but I don't think spi does for example though it might
have gone in with the recent device table stuff).  We could just specify that it
should be present for the device.

Jonathan

