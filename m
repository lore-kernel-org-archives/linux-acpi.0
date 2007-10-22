From: Jonathan McDowell <noodles@earth.li>
Subject: Re: [PATCH] Add bluetooth support to toshiba-acpi driver
Date: Mon, 22 Oct 2007 09:11:40 +0100
Message-ID: <20071022081140.GJ1880@earth.li>
References: <20071021173529.GH1880@earth.li> <20071022023023.07D74983989@smtp05.mtu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from the.earth.li ([193.201.200.66]:44202 "EHLO the.earth.li"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752097AbXJVILl (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 22 Oct 2007 04:11:41 -0400
Content-Disposition: inline
In-Reply-To: <20071022023023.07D74983989@smtp05.mtu.ru>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrey Borzenkov <arvidjaar@mail.ru>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, Oct 22, 2007 at 06:30:19AM +0400, Andrey Borzenkov wrote:
> Jonathan McDowell wrote:
> > This patch adds bluetooth support to the toshiba-acpi driver. I have
> > tried to follow the same format for the /proc/acpi/toshiba/bluetooth
> > file as followed in the thinkpad-acpi driver. In the long term the
> > rfkill infrastructure looks like the way forward for this
> > functionality, but at present it doesn't seem to be suitable.
> > 
> Would it be possible (make sense) to add config option for that? There
> are probably a bunch of older models out there that do not have BT at
> all (I am owner of such one).
 
For models without bluetooth the /proc/acpi/toshiba/bluetooth file
should end up with "status: not supported" in it. I don't have such a
laptop to test that this happens though; perhaps you could test the
patch and confirm it works as expected?

J.

-- 
The truth is out there, but also in here.
