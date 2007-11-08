From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: 2.6.24-rc1: OOPS at  acpi_battery_update
Date: Thu, 8 Nov 2007 17:16:59 +0100
Message-ID: <200711081717.00421.rjw@sisk.pl>
References: <1193652664.22149.4.camel@localhost> <200711050118.34610.rjw@sisk.pl> <20071108155344.GA12231@cataract>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:51162 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759479AbXKHP7y (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 8 Nov 2007 10:59:54 -0500
In-Reply-To: <20071108155344.GA12231@cataract>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Johannes Weiner <hannes-kernel@saeurebad.de>, Alexey Starikovskiy <astarikovskiy@suse.de>
Cc: "Michael (rabenkind) Brandstetter" <listen@selfservix.org>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

On Thursday, 8 of November 2007, Johannes Weiner wrote:
> Hi,
> 
> is there any reason, why acpi_battery_get_property() should call
> acpi_battery_update() at all?

Alex?
