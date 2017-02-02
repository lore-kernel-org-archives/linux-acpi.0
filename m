From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH v3 3/4] driver property: constify property arrays values
Date: Thu, 2 Feb 2017 12:08:04 +0200
Message-ID: <20170202100804.GF2053@lahna.fi.intel.com>
References: <20170201173125.40354-1-dmitry.torokhov@gmail.com>
 <20170201173125.40354-4-dmitry.torokhov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:59492 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751037AbdBBKIJ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 2 Feb 2017 05:08:09 -0500
Content-Disposition: inline
In-Reply-To: <20170201173125.40354-4-dmitry.torokhov@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Hans de Goede <hdegoede@redhat.com>, Wolfram Sang <wsa@the-dreams.de>

On Wed, Feb 01, 2017 at 09:31:24AM -0800, Dmitry Torokhov wrote:
> Data that is fed into property arrays should not be modified, so let's mark
> relevant pointers as const. This will allow us making source arrays as
> const/__initconst.
> 
> Also fix memory leaks on errors in property_entry_copy().
> 
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
