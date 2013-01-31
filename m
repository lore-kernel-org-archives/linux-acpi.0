From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH 2/2] ACPI / scan: Clean up acpi_bus_get_parent()
Date: Thu, 31 Jan 2013 10:46:38 +0200
Message-ID: <20130131084638.GA2239@intel.com>
References: <1451967.YMyGeCCNtu@vostro.rjw.lan>
 <7667918.svVNymu9rt@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:42247 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753424Ab3AaImq (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 31 Jan 2013 03:42:46 -0500
Content-Disposition: inline
In-Reply-To: <7667918.svVNymu9rt@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Yinghai Lu <yinghai@kernel.org>, Toshi Kani <toshi.kani@hp.com>

On Wed, Jan 30, 2013 at 11:04:03PM +0100, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Make acpi_bus_get_parent() more straightforward and remove an
> unnecessary local variable ret from it.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
