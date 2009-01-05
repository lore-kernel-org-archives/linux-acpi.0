From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: 2.6.28 regression: xbacklight broken on ThinkPad X61s
Date: Mon, 05 Jan 2009 17:06:15 +0800
Message-ID: <1231146375.32473.52.camel@rzhang-dt>
References: <20090105083911.GA3694@x61>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:18636 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751756AbZAEJE5 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 5 Jan 2009 04:04:57 -0500
In-Reply-To: <20090105083911.GA3694@x61>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Tino Keitel <tino.keitel@gmx.de>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, trenn@suse.de, mjg59@srcf.ucam.org

On Mon, 2009-01-05 at 16:39 +0800, Tino Keitel wrote:
> Hi,
> 
> xbacklight is broken as of 2.6.28 on my ThinkPad X61s. It works with
> 2.6.27(.8) The difference I can see between both kernels is that 2.6.27
> has 2 backlight ACPI devices, whereas 2.6.28 only has one device.  With
> 2.6.28, I can use xbacklight and see the values change in xbacklight
> -get, but the actual display brightness doesn't change.
> 
hmm, this regression is caused by commit 
22c13f9d8179f4c9caecfcb60a95214562b9addc

but the real problem is that the IGD OpRegion doesn't work well on this
laptop.

please file a bug at bugzilla.kernel.org and attach the acpidump there.

thanks,
rui

