From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH 1/2] video: always update the brightness when poking "brightness"
Date: Wed, 31 Dec 2008 01:21:38 +0000
Message-ID: <20081231012138.GA24116@srcf.ucam.org>
References: <1230088058.562.219.camel@rzhang-dt> <1230633250.5328.8.camel@dax.rpnet.com> <1230686540.4091.107.camel@yakui_zhao.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:45983 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751703AbYLaBVq (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 30 Dec 2008 20:21:46 -0500
Content-Disposition: inline
In-Reply-To: <1230686540.4091.107.camel@yakui_zhao.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhao Yakui <yakui.zhao@intel.com>
Cc: Richard Purdie <rpurdie@rpsys.net>, "Zhang, Rui" <rui.zhang@intel.com>, linux-acpi <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>

On Wed, Dec 31, 2008 at 09:22:20AM +0800, Zhao Yakui wrote:

> Sometimes the brightness will be changed by BIOS and there is no
> notification event. In such case the props.brightness can't be updated.
> If we want to update the brightness, the request will have no effect.

In the common case (ie, ACPI) clients should read from actual_brightness 
and set via brightness. The distinction exists for precisely this kind 
of eventuality.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
