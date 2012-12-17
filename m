From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [Update][PATCH] ACPI / PCI: Set root bridge ACPI handle in
 advance
Date: Mon, 17 Dec 2012 10:44:05 -0800
Message-ID: <20121217184405.GB4945@kroah.com>
References: <1558789.gX8cmBgyDV@vostro.rjw.lan>
 <4085861.TBmZVTPOvU@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-da0-f46.google.com ([209.85.210.46]:53585 "EHLO
	mail-da0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753229Ab2LQSoK (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 17 Dec 2012 13:44:10 -0500
Received: by mail-da0-f46.google.com with SMTP id p5so2976259dak.19
        for <linux-acpi@vger.kernel.org>; Mon, 17 Dec 2012 10:44:10 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4085861.TBmZVTPOvU@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, David Miller <davem@davemloft.net>, tony.luck@intel.com, "H. Peter Anvin" <hpa@zytor.com>, Yinghai Lu <yinghai@kernel.org>, Jiang Liu <liuj97@gmail.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Jan Glauber <jang@linux.vnet.ibm.com>

On Mon, Dec 17, 2012 at 01:20:15PM +0100, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> The ACPI handles of PCI root bridges need to be known to
> acpi_bind_one(), so that it can create the appropriate
> "firmware_node" and "physical_node0" files for them, but currently
> the way it gets to know those handles is not exactly straightforward
> (to put it lightly).

That's just crazy, thanks for unwinding this mess, nice job.

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
