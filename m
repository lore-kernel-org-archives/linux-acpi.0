From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 2/2] device property: Introduce firmware node type for
 platform data
Date: Fri, 3 Apr 2015 16:06:57 +0200
Message-ID: <20150403140657.GC12376@kroah.com>
References: <1422278260-108175-1-git-send-email-heikki.krogerus@linux.intel.com>
 <1594911.7FXIhSfjIv@vostro.rjw.lan>
 <1845472.ky0kR6YsnQ@vostro.rjw.lan>
 <3619014.N4Tg0UgJKE@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:41328 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753083AbbDCOHC (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 3 Apr 2015 10:07:02 -0400
Content-Disposition: inline
In-Reply-To: <3619014.N4Tg0UgJKE@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Grant Likely <grant.likely@linaro.org>, Arnd Bergmann <arnd@linaro.org>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, ACPI Devel Mailing List <linux-acpi@vger.kernel.org>, Darren Hart <dvhart@infradead.org>

On Fri, Apr 03, 2015 at 04:05:11PM +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Introduce data structures and code allowing "built-in" properties
> to be associated with devices in such a way that they will be used
> by the device_property_* API if no proper firmware node (neither DT
> nor ACPI) is present for the given device.
> 
> Each property is to be represented by a property_entry structure.
> An array of property_entry structures (terminated with a null
> entry) can be pointed to by the properties field of struct
> property_set that can be added as a firmware node to a struct
> device using device_add_property_set().  That will cause the
> device_property_* API to use that property_set as the source
> of properties if the given device does not have a DT node or
> an ACPI companion device object associated with it.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Tested-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> ---
> 
> Greg, any objections?

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
