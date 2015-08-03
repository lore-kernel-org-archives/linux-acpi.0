From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH] ACPI / bus: Move duplicate code to a separate new
 function
Date: Mon, 3 Aug 2015 12:48:32 +0300
Message-ID: <20150803094832.GA1540@lahna.fi.intel.com>
References: <4854608.nIfMTUvZQu@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:39067 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752854AbbHCJsh (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 3 Aug 2015 05:48:37 -0400
Content-Disposition: inline
In-Reply-To: <4854608.nIfMTUvZQu@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>

On Sat, Aug 01, 2015 at 02:39:43AM +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> After merging commit 712e960f0ee9 (ACPI / PM: Attach ACPI power
> domain only once) with commit 1dcc3d3362b0 (ACPI / bus: Move ACPI
> bus type registration) there is some duplicate code in
> acpi_device_is_first_physical_node() and acpi_companion_match()
> that can be moved to a separate routine and called from both
> places.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
