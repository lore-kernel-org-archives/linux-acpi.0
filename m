From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH 01/11] ACPI: video: Ignore devices that aren't present
	in hardware
Date: Fri, 18 Jul 2008 15:48:18 +0800
Message-ID: <1216367298.1617.221.camel@rzhang-fc9.sh.intel.com>
References: <1216315935-20998-1-git-send-email-trenn@suse.de>
	 <1216315935-20998-2-git-send-email-trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:62910 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751856AbYGRHtf (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 18 Jul 2008 03:49:35 -0400
In-Reply-To: <1216315935-20998-2-git-send-email-trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: ak@linux.intel.com, linux-acpi@vger.kernel.org

On Thu, 2008-07-17 at 19:32 +0200, Thomas Renninger wrote:
> This is a reimplemention of commit
> 0119509c4fbc9adcef1472817fda295334612976
> from Matthew Garrett <mjg59@srcf.ucam.org>
> 
> This patch got removed because of a regression: ThinkPads with a
> Intel graphics card and an Integrated Graphics Device BIOS implementation
> stopped working.
> In fact, they only worked because the ACPI device of the discrete, the
> wrong one, got used (via int10). So ACPI functions were poking on the wrong
> hardware used which is a sever bug.
> The next patch provides support for above ThinkPads to be able to
> switch brightness via the legacy thinkpad_acpi driver and automatically
> detect when to use it.

Sorry, but I still can't find the code to detect thinkpad laptops.
there should be a dmi check in video_detect.c, right?
Or do I miss something?

thanks,
rui

> 
> Original commit message from Matthew Garrett:
>     Vendors often ship machines with a choice of integrated or discrete
>     graphics, and use the same DSDT for both. As a result, the ACPI video
>     module will locate devices that may not exist on this specific platform.
>     Attempt to determine whether the device exists or not, and abort the
>     device creation if it doesn't.
> 
> http://bugzilla.kernel.org/show_bug.cgi?id=9614
> 
> Signed-off-by: Thomas Renninger <trenn@suse.de>


