From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH] ACPI / property: Fix subnode lookup scope for data-only
 subnodes
Date: Wed, 21 Oct 2015 16:20:36 +0300
Message-ID: <20151021132036.GC1526@lahna.fi.intel.com>
References: <3607867.RKSpENdj9h@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:30863 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751069AbbJUNXy (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 21 Oct 2015 09:23:54 -0400
Content-Disposition: inline
In-Reply-To: <3607867.RKSpENdj9h@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Darren Hart <darren.hart@intel.com>

On Wed, Oct 21, 2015 at 01:51:24AM +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> The correct scope for looking up the objects to generate data packages for
> data-only subnodes pointed to by another data-only subnode is the scope
> of the parent of that subnode and not the scope containing the _DSD object
> at the top of the hierarchy (the latter works only if all of the objects
> returning data-only subnode packages in a given hierarchy are in the same
> scope).
> 
> Fix the code to work as expected.
> 
> Fixes: 445b0eb058f5 (ACPI / property: Add support for data-only subnodes)
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>

All my tests still pass so you can also add

Tested-by: Mika Westerberg <mika.westerberg@linux.intel.com>
