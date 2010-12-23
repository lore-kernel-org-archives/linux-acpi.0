From: Jesse Barnes <jbarnes@virtuousgeek.org>
Subject: Re: [Resend][PATCH] PCI / Hotplug: Fix unexpected driver unregister
 in pciehp_acpi.c
Date: Thu, 23 Dec 2010 12:52:10 -0800
Message-ID: <20101223125210.07cc350f@jbarnes-desktop>
References: <201012181329.46071.rjw@sisk.pl>
	<4D0EA38C.2090003@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from oproxy2-pub.bluehost.com ([67.222.39.60]:34615 "HELO
	oproxy2-pub.bluehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751938Ab0LWUwN (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 23 Dec 2010 15:52:13 -0500
In-Reply-To: <4D0EA38C.2090003@jp.fujitsu.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, LKML <linux-kernel@vger.kernel.org>, linux-pci@vger.kernel.org, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Matthew Garrett <mjg59@srcf.ucam.org>

On Mon, 20 Dec 2010 09:30:04 +0900
Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com> wrote:

> (2010/12/18 21:29), Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki<rjw@sisk.pl>
> > 
> > If pcie_ports_disabled is set, pcie_port_service_register() returns
> > error code and select_detection_mode() should not attempt to
> > unregister dummy_driver and use dummy_slots.  It should return
> > PCIEHP_DETECT_ACPI immediately instead.
> > 
> > Signed-off-by: Rafael J. Wysocki<rjw@sisk.pl>
> 
> Reviewed-by: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
> Acked-by: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
> 
> 

Applied to my for-linus branch, thanks guys.

-- 
Jesse Barnes, Intel Open Source Technology Center
