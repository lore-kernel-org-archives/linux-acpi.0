From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [update][PATCH 4/4] ACPI / scan: Rework modalias creation when
 "compatible" is present
Date: Fri, 10 Apr 2015 15:29:02 +0300
Message-ID: <20150410122902.GW1734@lahna.fi.intel.com>
References: <4378053.gHTT51U7FJ@vostro.rjw.lan>
 <1584233.lpv5odbKkI@vostro.rjw.lan>
 <20150410081224.GO1734@lahna.fi.intel.com>
 <5371556.t424ylyKHo@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:54047 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753989AbbDJM3H (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 10 Apr 2015 08:29:07 -0400
Content-Disposition: inline
In-Reply-To: <5371556.t424ylyKHo@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Darren Hart <dvhart@infradead.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Fri, Apr 10, 2015 at 02:34:44PM +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Subject: ACPI / scan: Rework modalias creation when "compatible" is present
> 
> Currently, the ACPI modalias creation covers two mutually exclusive
> cases: If the PRP0001 device ID is present in the device's list of
> ACPI/PNP IDs and the "compatible" property is present in _DSD, the
> created modalias will follow the OF rules of modalias creation.
> Otherwise, ACPI rules are used.
> 
> However, that is not really desirable, because the presence of PRP0001
> in the list of device IDs generally does not preclude using other
> ACPI/PNP IDs with that device and those other IDs may be of higher
> priority.  In those cases, the other IDs should take preference over
> PRP0001 and therefore they also should be present in the modalias.
> 
> For this reason, rework the modalias creation for ACPI so that it
> shows both the ACPI-style and OF-style modalias strings if the
> device has a non-empty list of ACPI/PNP IDs (other than PRP0001)
> and a valid "compatible" property at the same time.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Works fine now, thanks!

For the whole series,

Tested-by: Mika Westerberg <mika.westerberg@linux.intel.com>
