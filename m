From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH v4 1/5] acpi: battery: Split battery driver for reuse by
 DPTF power participant
Date: Thu, 30 Jun 2016 15:39:05 -0700
Message-ID: <1467326345.4497.0.camel@linux.intel.com>
References: <1467244819-19046-1-git-send-email-srinivas.pandruvada@linux.intel.com>
	 <1467244819-19046-2-git-send-email-srinivas.pandruvada@linux.intel.com>
	 <CAJZ5v0geNqtMi99JE4NTVByxUB-JECKPpVGRnO8=YKQMZCAoGA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:39323 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752539AbcF3Wkc (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 30 Jun 2016 18:40:32 -0400
In-Reply-To: <CAJZ5v0geNqtMi99JE4NTVByxUB-JECKPpVGRnO8=YKQMZCAoGA@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>

On Fri, 2016-07-01 at 00:08 +0200, Rafael J. Wysocki wrote:
> On Thu, Jun 30, 2016 at 2:00 AM, Srinivas Pandruvada
> <srinivas.pandruvada@linux.intel.com> wrote:
> > DPTF power participant device have common objects with ACPI battery
> > device
> > "PNP0C0A". For example the main battery objects:
> > _BST: returns dynamic battery information
> > _BIX: The static battery properties and control method
> > Also both can register with power_supply class to present
> > properties
> > of a typical battery device.
> > 
> > To avoid code duplication, the existing battery driver is split
> > into two
> > parts:
> > - A common part
> > - ACPI battery driver
> > 
> > battery_common
> > Most of the existing battery driver source, except ACPI enumeration
> > part
> > moved a separate file. It exposes an interface, which can be used
> > by ACPI
> > battery driver and DPTF power participant driver.
> > Also the current battery driver code had lots of check_patch
> > errors.
> > These check_patch errors are addressed in this battery_common.
> > These are
> > the main interface functions:
> > acpi_battery_common_add
> > acpi_battery_common_remove
> > acpi_battery_common_resume
> > acpi_battery_common_notify
> > 
> > battery: This is ACPI battery driver, which just enumerate on
> > PNP0C0A
> > device and use interface functions offered by battery common part.
> > 
> > Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel
> > .com>
> 
> Are there any functional changes in this patch?
No.

Thanks,
Srinivas
