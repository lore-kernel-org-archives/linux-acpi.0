From: "Zheng, Lv" <lv.zheng@intel.com>
Subject: RE: [PATCH 2/2] gpio / ACPI: add support for GPIO operation regions
Date: Mon, 16 Sep 2013 00:46:55 +0000
Message-ID: <1AE640813FDE7649BE1B193DEA596E88024639E4@SHSMSX101.ccr.corp.intel.com>
References: <1379085280-2211-1-git-send-email-mika.westerberg@linux.intel.com>
 <1379085280-2211-2-git-send-email-mika.westerberg@linux.intel.com>
 <1AE640813FDE7649BE1B193DEA596E880246367A@SHSMSX101.ccr.corp.intel.com>
 <20130915065151.GK7393@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:49372 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754796Ab3IPArD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 15 Sep 2013 20:47:03 -0400
In-Reply-To: <20130915065151.GK7393@intel.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linus Walleij <linus.walleij@linaro.org>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, Mathias Nyman <mathias.nyman@linux.intel.com>, Grant Likely <grant.likely@secretlab.ca>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

> From: Mika Westerberg [mailto:mika.westerberg@linux.intel.com]
> Sent: Sunday, September 15, 2013 2:52 PM
> 
> On Sat, Sep 14, 2013 at 12:10:37AM +0000, Zheng, Lv wrote:
> > Is it possible to install the handler for ACPI_ROOT_OBJECT?
> > Can it be achieved by implementing a setup callback?
> 
> Yes that can be done. However, that would mean that we always install the
> operation region handler even if there is no suitable GPIO driver loaded.
> With this patch we install the handler once the GPIO driver for this device
> is registered. If nothing is registered no handlers will be installed.
> 
> What would be the advantage in doing what you propose?

A pseudo device may be created to access the GPIO operation region fields provided by one GPIO device.
The pseudo device may have other functions to access other GPIO operation region fields provided by other GPIO devices, or even worse to access other ACPI provided value-adds.
So hierarchically the pseudo device only requires CPU, thus should not be under the GPIO device, which means the GPIO operation regions have nothing to do with the GPIO devices' ACPI handle.
We cannot imply that the BIOS writers won't create such Frankenstein in the future.
So it's better to install address space handlers from ACPI_ROOT_OBJECT.

> > Maybe you can also eliminate acpi_attach_data usages by doing so.
> 
> I think we still need that for ACPI _EVT handling.

It could be good if we can find a way to eliminate all acpi_attach_data usages and make this function deprecated.
But that's fine. :-)

Thanks and best regards
-Lv
