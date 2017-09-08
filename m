From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH 1/1] ACPI: Return _DSD hierarchical extension (data)
 sub-nodes correctly
Date: Fri, 8 Sep 2017 12:13:06 +0300
Message-ID: <20170908091306.GZ2477@lahna.fi.intel.com>
References: <1504859676-17375-1-git-send-email-sakari.ailus@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:28847 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751907AbdIHJNK (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 8 Sep 2017 05:13:10 -0400
Content-Disposition: inline
In-Reply-To: <1504859676-17375-1-git-send-email-sakari.ailus@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: linux-acpi@vger.kernel.org, rafael@kernel.org, andriy.shevchenko@intel.com, mika.westerberg@intel.com

On Fri, Sep 08, 2017 at 11:34:36AM +0300, Sakari Ailus wrote:
> The recetly merged patch "ACPI: Prepare for constifying
      ^^^^^^^ recently

> acpi_get_next_subnode() fwnode argument" was part of a patchset
> constifying the fwnode arguments across the fwnode property API. The
> purpose of the patch was to allow returning non-const fwnodes from a data
> structure the root of which is const.
> 
> Unfortunately the patch introduced the functionality, in particular when
> starting parsed from an ACPI device node, the hierarchical data extension
> nodes would not be enumerated.
> 
> Restore the old behaviour while still retaining constness properties of
> the patch.
> 
> Fixes: ("ACPI: Prepare for constifying acpi_get_next_subnode() fwnode argument")

This needs to have the commit id as well.

> Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>

Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
