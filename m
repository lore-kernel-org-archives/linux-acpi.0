From: Toshi Kani <toshi.kani@hp.com>
Subject: Re: [PATCH 1/3] ACPI / hotplug: Fix acpi_bus_get_device() return
 value check
Date: Mon, 18 Nov 2013 11:03:10 -0700
Message-ID: <1384797790.1791.10.camel@misato.fc.hp.com>
References: <2434673.zhjYZOTQ4A@vostro.rjw.lan>
	 <1785834.mvVFipiyRh@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g4t0017.houston.hp.com ([15.201.24.20]:48553 "EHLO
	g4t0017.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751281Ab3KRSHt (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 18 Nov 2013 13:07:49 -0500
In-Reply-To: <1785834.mvVFipiyRh@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Linux PCI <linux-pci@vger.kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Yinghai Lu <yinghai@kernel.org>

On Thu, 2013-11-14 at 00:15 +0100, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Since acpi_bus_get_device() returns plain int and not acpi_status,
> ACPI_FAILURE() should not be used for checking its return value.  Fix
> that.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Acked-by: Toshi Kani <toshi.kani@hp.com>

Thanks,
-Toshi

