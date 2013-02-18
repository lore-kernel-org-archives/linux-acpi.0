From: Vasilis Liaskovitis <vasilis.liaskovitis@profitbricks.com>
Subject: Re: [PATCH] ACPI / scan: Make it clear that acpi_bus_trim() cannot
 fail
Date: Mon, 18 Feb 2013 13:25:49 +0100
Message-ID: <20130218122549.GA4448@dhcp-192-168-178-175.profitbricks.localdomain>
References: <1511096.zmfmBrfdmu@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-bk0-f52.google.com ([209.85.214.52]:52228 "EHLO
	mail-bk0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751569Ab3BRMZz (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 18 Feb 2013 07:25:55 -0500
Received: by mail-bk0-f52.google.com with SMTP id jk13so2449446bkc.25
        for <linux-acpi@vger.kernel.org>; Mon, 18 Feb 2013 04:25:53 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1511096.zmfmBrfdmu@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Yinghai Lu <yinghai@kernel.org>, Toshi Kani <toshi.kani@hp.com>, Jiang Liu <liuj97@gmail.com>, wency@cn.fujitsu.com

Hi,

On Thu, Jan 24, 2013 at 11:56:50PM +0100, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Since acpi_bus_trim() cannot fail, change its definition to a void
> function, so that its callers don't check the return value in vain
> and update the callers.

I have missed a few patchsets/discussions in the last month and wanted to
ask a question related to this: Does the new always-succeed 2-pass
trim_device design guarantee safe memory hot-remove operations?

Afaict if memory offline fails now, the device is ejected (_EJ0) anyways
causing a panic. Tested in a VM with linux-next-20130207 and
linux-next-20130218 by doing an SCI-eject request on a hot-plugged dimm.

Are there more patches in development for safe memory hot-remove?

thanks,

- Vasilis
