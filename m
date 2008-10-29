From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: Jetway J2F2WE-1G5: S1 leaves video on
Date: Wed, 29 Oct 2008 22:43:14 +0000
Message-ID: <20081029224314.GA4450@srcf.ucam.org>
References: <20081029182544.GA14582@storm.local.network>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:58196 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754479AbYJ2WnS (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 29 Oct 2008 18:43:18 -0400
Content-Disposition: inline
In-Reply-To: <20081029182544.GA14582@storm.local.network>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Forest Bond <forest@alittletooquiet.net>
Cc: linux-acpi@vger.kernel.org

On Wed, Oct 29, 2008 at 02:25:44PM -0400, Forest Bond wrote:
> Hi,
> 
> I'm using vanilla 2.6.27.4.  I `echo standby >/sys/power/state` and the machine
> switches to a console and acts like it is about to go into some sort of lower
> power mode, but the video stays on.  Is this normal?

Yes, that's common. You'll need an in-kernel video driver that provides 
a suspend method for the device.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
