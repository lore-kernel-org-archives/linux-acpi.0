From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: Avoid critical temp shutdowns on specific ThinkPad T4x(p) and
	R50p
Date: Tue, 12 Aug 2008 09:27:23 +0800
Message-ID: <1218504443.14233.84.camel@rzhang-dt>
References: <200807301556.01815.trenn@suse.de>
	 <200808011318.02875.trenn@suse.de> <48A022BD.2040908@linux.intel.com>
	 <200808111433.25275.trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:36994 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750975AbYHLB1c (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 11 Aug 2008 21:27:32 -0400
In-Reply-To: <200808111433.25275.trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: Andi Kleen <ak@linux.intel.com>, lenb@kernel.org, linux-acpi@vger.kernel.org, ibm-acpi-devel@lists.sourceforge.net, mjg59@srcf.ucam.org

On Mon, 2008-08-11 at 20:33 +0800, Thomas Renninger wrote:
> Is this a bug in current drivers/thermal/Kconfig code:
> config THERMAL_HWMON
>         bool "Hardware monitoring support"
>         depends on HWMON=y || HWMON=THERMAL
> Should the last line be:
>         depends on HWMON
> ?

No, for thermal class device, hwmon I/F is not required.
And we don;t want hwmon sysfs I/F if thermal_sys is built in
while hwmon is compiled as a module.

thanks,
rui

