From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [RFC PATCH v2 02/16] Driver core: Unified device properties
 interface for platform firmware
Date: Wed, 17 Sep 2014 11:28:40 -0700
Message-ID: <20140917182840.GA8346@kroah.com>
References: <1410868367-11056-1-git-send-email-mika.westerberg@linux.intel.com>
 <1410868367-11056-3-git-send-email-mika.westerberg@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:53352 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755492AbaIQS33 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 17 Sep 2014 14:29:29 -0400
Content-Disposition: inline
In-Reply-To: <1410868367-11056-3-git-send-email-mika.westerberg@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Bryan Wu <cooloney@gmail.com>, Lee Jones <lee.jones@linaro.org>, Grant Likely <grant.likely@linaro.org>, Arnd Bergmann <arnd@arndb.de>, Aaron Lu <aaron.lu@intel.com>, Darren Hart <dvhart@linux.intel.com>

On Tue, Sep 16, 2014 at 02:52:33PM +0300, Mika Westerberg wrote:
> From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> 
> Add a uniform interface by which device drivers can request device
> properties from the platform firmware by providing a property name
> and the corresponding data type.  The purpose of it is to help to
> write portable code that won't depend on any particular platform
> firmware interface.
> 
> Three general helper functions, device_get_property(),
> device_read_property() and device_read_property_array() are provided.
> The first one allows the raw value of a given device property to be
> accessed by the driver.  The remaining two allow the value of a numeric
> or string property and multiple numeric or string values of one array
> property to be acquired, respectively.  Static inline wrappers are also
> provided for the various property data types that can be passed to
> device_read_property() or device_read_property_array() for extra type
> checking.
> 
> In addition to that new generic routines are provided for retrieving
> properties from device description objects in the platform firmware
> in case there are no struct device objects for them (either those
> objects have not been created yet or they do not exist at all).
> Again, three functions are provided, dev_node_get_property(),
> dev_node_read_property(), dev_node_read_property_array(), in analogy
> with device_get_property(), device_read_property() and
> device_read_property_array() described above, respectively, along
> with static inline wrappers for all of the propery data types that
> can be used.  For all of them, the first argument is a pointer to
> struct fw_dev_node (new type) that in turn contains exactly one
> valid pointer to a device description object (depending on what
> platform firmware interface is in use).
> 
> Finally, device_for_each_child_node() is added for iterating over
> the children of the device description object associated with the
> given device.
> 
> The interface covers both ACPI and Device Trees.
> 
> This change set includes material from Mika Westerberg and Aaron Lu.
> 
> Signed-off-by: Aaron Lu <aaron.lu@intel.com>
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Looks good to me, feel free to take this through your tree with my:

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
