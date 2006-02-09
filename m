From: Borislav Deianov <borislav@users.sf.net>
Subject: Re: [PATCH] Make ibm_acpi use generic backlight infrastructure
Date: Thu, 9 Feb 2006 01:33:51 -0800
Message-ID: <20060209093351.GI2271@aero.ensim.com>
References: <20060208161056.GA28922@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp1.ensim.com ([65.164.64.254]:40806 "EHLO
	exchange-svr2.exch.ensim.com") by vger.kernel.org with ESMTP
	id S1030310AbWBIJd5 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 9 Feb 2006 04:33:57 -0500
Content-Disposition: inline
In-Reply-To: <20060208161056.GA28922@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linux-acpi@vger.kernel.org

Hi Matthew,

On Wed, Feb 08, 2006 at 04:10:56PM +0000, Matthew Garrett wrote:
> The included patch allows brightness to be controlled through 
> /sys/class/backlight on IBM ACPI machines.

Looks good to me (except for some extra white space). I won't get a
chance for a while to test it or roll it into the out-of-kernel
tarball, but go ahead and submit it to Len for inclusion into the
kernel.

Thanks,
Boris
