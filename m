From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: Fwd: Hid over I2C and ACPI interaction
Date: Mon, 9 Jul 2012 10:51:30 +0300
Message-ID: <20120709075130.GI2237@intel.com>
References: <CAN+gG=GnMX8Gu6w9za2QrjoVrmORncFgq-+hhmHvxtOPEB=nDw@mail.gmail.com>
 <4FF52C70.9010601@intel.com>
 <1341471717.1682.125.camel@rui.sh.intel.com>
 <20120706055234.GC2237@intel.com>
 <4FFA4EFD.6090708@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:12341 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751419Ab2GIHtc (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 9 Jul 2012 03:49:32 -0400
Content-Disposition: inline
In-Reply-To: <4FFA4EFD.6090708@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lan Tianyu <tianyu.lan@intel.com>
Cc: Zhang Rui <rui.zhang@intel.com>, khali@linux-fr.org, ben-linux@fluff.org, w.sang@pengutronix.de, lenb@kernel.org, linux-acpi@vger.kernel.org, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, jkosina@suse.cz, chatty@enac.fr, jj_ding@emc.com.tw, bhelgaas@google.com, abelay@mit.edu

On Mon, Jul 09, 2012 at 11:24:45AM +0800, Lan Tianyu wrote:
> I think we can add new interface to get acpi specific resources. e.g
> struct acpi_resource pnp_get_acpi_resource(...). When the pnp acpi devices
> were initialized, put those acpi specific resources into a new resource list
> pnpdev->acpi_resources. What pnp_get_acpi_resource does is to get specified
> type acpi resources and return. We also need to define some acpi resource types.

Yeah, that sounds good to me.
