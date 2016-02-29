From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH] device property: don't bother the drivers with struct
 property_set
Date: Mon, 29 Feb 2016 14:59:48 +0200
Message-ID: <20160229125948.GA1794@lahna.fi.intel.com>
References: <1456485600-129229-1-git-send-email-heikki.krogerus@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:58970 "EHLO mga04.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754372AbcB2M75 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 29 Feb 2016 07:59:57 -0500
Content-Disposition: inline
In-Reply-To: <1456485600-129229-1-git-send-email-heikki.krogerus@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Lee Jones <lee.jones@linaro.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Thierry Reding <treding@nvidia.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

On Fri, Feb 26, 2016 at 01:20:00PM +0200, Heikki Krogerus wrote:
> Since device_add_property_set() now always takes a copy of
> the property_set, and also since the fwnode type is always
> hard coded to be FWNODE_PDATA, there is no need for the
> drivers to deliver the entire struct property_set. The
> function can just create the instance of it on its own and
> bind the properties from the drivers to it on the spot.
> 
> This renames device_add_property_set() to
> device_add_properties(). The function now takes struct
> property_entry as its parameter instead of struct
> property_set.
> 
> Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

Nice!

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
