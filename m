From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] driver core: Implement device property accessors through
 fwnode ones
Date: Mon, 23 Mar 2015 21:13:21 +0100
Message-ID: <20150323201321.GA2071@kroah.com>
References: <1422278260-108175-1-git-send-email-heikki.krogerus@linux.intel.com>
 <CACxGe6tiDszPDpP_u1yxNgMA8HjagDKtGuu35hfkyJtZdGE0Aw@mail.gmail.com>
 <10066684.kPKm7OTnxF@vostro.rjw.lan>
 <9998673.jvqRF9ZONz@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:46167 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752120AbbCWUQ7 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 23 Mar 2015 16:16:59 -0400
Content-Disposition: inline
In-Reply-To: <9998673.jvqRF9ZONz@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Grant Likely <grant.likely@linaro.org>, Arnd Bergmann <arnd@linaro.org>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, ACPI Devel Mailing List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, devicetree@vger.kernel.org

On Mon, Mar 23, 2015 at 12:10:30AM +0100, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Now that the ACPI companions of devices are pointed to by the fwnode
> field in struct device, the device_property_*() accessor functions
> can be modified to use their fwnode_property_*() counterparts
> internally with minimum extra overhead in the IS_ENABLED(CONFIG_OF)
> case, so make those changes.
> 
> This allows us to get rid of the rather ugly DEV_PROP_READ_ARRAY()
> macro among other things.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> 
> On top of
> 
> http://git.kernel.org/cgit/linux/kernel/git/rafael/linux-pm.git/commit/?h=linux-next&id=ce793486e23e0162a732c605189c8028e0910e86

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
