From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 1/2] device property: Make it possible to use secondary
 firmware nodes
Date: Fri, 3 Apr 2015 16:06:48 +0200
Message-ID: <20150403140648.GB12376@kroah.com>
References: <1422278260-108175-1-git-send-email-heikki.krogerus@linux.intel.com>
 <1594911.7FXIhSfjIv@vostro.rjw.lan>
 <1845472.ky0kR6YsnQ@vostro.rjw.lan>
 <4319396.BzsUBIbBMA@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:41324 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753089AbbDCOGx (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 3 Apr 2015 10:06:53 -0400
Content-Disposition: inline
In-Reply-To: <4319396.BzsUBIbBMA@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Grant Likely <grant.likely@linaro.org>, Arnd Bergmann <arnd@linaro.org>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, ACPI Devel Mailing List <linux-acpi@vger.kernel.org>, Darren Hart <dvhart@infradead.org>

On Fri, Apr 03, 2015 at 04:03:27PM +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Add a "secondary" pointer to struct fwnode_handle so as to make it
> possible for a device to have two firmware nodes associated with
> it at the same time, for example, an ACPI node and a node with
> a set of properties provided by platform initialization code.
> 
> In the future that will allow device property lookup to fall back
> from the primary firmware node to the secondary one if the given
> property is not present there to make it easier to provide defaults
> for device properties used by device drivers.
> 
> Introduce two helper routines, set_primary_fwnode() and
> set_secondary_fwnode() allowing callers to add a primary/secondary
> firmware node to the given device in such a way that
> 
>  (1) If there's only one firmware node for that device, it will be
>      pointed to by the device's firmware node pointer.
>  (2) If both the primary and secondary firmware nodes are present,
>      the primary one will be pointed to by the device's firmware
>      node pointer, while the secondary one will be pointed to by the
>      primary node's secondary pointer.
>  (3) If one of these nodes is removed (by calling one of the new
>      nelpers with NULL as the second argument), the other one will
>      be preserved.
> 
> Make ACPI use set_primary_fwnode() for attaching its firmware nodes
> to devices.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Tested-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> ---
> 
> Greg, any objections here?

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
