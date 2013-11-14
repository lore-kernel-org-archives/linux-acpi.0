From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 1/2] ACPI: Eliminate the DEVICE_ACPI_HANDLE() macro
Date: Thu, 14 Nov 2013 11:44:07 +0900
Message-ID: <20131114024407.GB9899@kroah.com>
References: <3268437.YsusHvklcv@vostro.rjw.lan>
 <1803808.ghCmmaO2Cj@vostro.rjw.lan>
 <5216191.8B6uiYXXe4@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:44604 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751150Ab3KNCoK (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 13 Nov 2013 21:44:10 -0500
Content-Disposition: inline
In-Reply-To: <5216191.8B6uiYXXe4@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Linux PCI <linux-pci@vger.kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Aaron Lu <aaron.lu@intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Lan Tianyu <tianyu.lan@intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, "Luck, Tony" <tony.luck@intel.com>

On Thu, Nov 14, 2013 at 12:26:00AM +0100, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Since DEVICE_ACPI_HANDLE() is now literally identical to
> ACPI_HANDLE(), replace it with the latter everywhere and drop its
> definition from include/acpi.h.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
