From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH] Eject button handling in quickstart driver
Date: Wed, 7 Mar 2012 15:21:10 +0000
Message-ID: <20120307152110.GA10945@srcf.ucam.org>
References: <4F576A87.1080401@ts.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:39436 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756111Ab2CGPVM (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 7 Mar 2012 10:21:12 -0500
Content-Disposition: inline
In-Reply-To: <4F576A87.1080401@ts.fujitsu.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Rainer Koenig <Rainer.Koenig@ts.fujitsu.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Wed, Mar 07, 2012 at 03:02:47PM +0100, Rainer Koenig wrote:
> +                if (strncasecmp(quickstart->btn->name, "ODDE", 4) == 0) {
> +                  /* ODDE is Optical Disc Drive Eject */
> +                  quickstart_data.pressed = quickstart->btn;
> +                }

This is wrong. Since the GHID method returns an arbitrary 
vendor-specific value, you should just make sure that there's 
appropriate keymap remapping support and then provide a udev fragment 
that does the appropriate GHID->keycode assignment. Also, you really do 
need to report this as KEY_CDEJECT - it's not acceptable to require an 
acpid script.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
