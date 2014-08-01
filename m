From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH 1/2 V2] USB: Use ACPI device information
Date: Fri, 1 Aug 2014 10:22:00 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1408011021120.1185-100000@iolanthe.rowland.org>
References: <140713857.5QYWLe1hHM@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:57825 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1750947AbaHAOWB (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 1 Aug 2014 10:22:01 -0400
In-Reply-To: <140713857.5QYWLe1hHM@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Tenoutit, Faouaz" <faouaz.tenoutit@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Fri, 1 Aug 2014, Rafael J. Wysocki wrote:

> On Wednesday, July 09, 2014 04:42:38 PM Tenoutit, Faouaz wrote:
> > From: Faouaz TENOUTIT <faouaz.tenoutit@intel.com>
> > 
> > Use ACPI device pld information instead of calling
> > acpi_get_physical_device_location.
> > 
> > Signed-off-by: Faouaz TENOUTIT <faouaz.tenoutit@intel.com>
> > Acked-by: Samuel Ortiz <samuel.ortiz@intel.com>
> 
> Greg, Alan, any objections agains this?

No objection from me, aside from the fact that the posted patch was 
whitespace-damaged.

Acked-by: Alan Stern <stern@rowland.harvard.edu>

