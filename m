From: Matthew Garrett <mjg@redhat.com>
Subject: Re: ACPI reads wrong temperature
Date: Sun, 2 Nov 2008 09:25:41 +0000
Message-ID: <20081102092541.GE10983@srcf.ucam.org>
References: <20081031140247.325670@gmx.net> <20081031143030.GA9177@srcf.ucam.org> <20081031210913.3180@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:39054 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753065AbYKBJZp (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 2 Nov 2008 04:25:45 -0500
Content-Disposition: inline
In-Reply-To: <20081031210913.3180@gmx.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Peter Mahlknecht <mali100@gmx.net>
Cc: linux-acpi@vger.kernel.org

On Fri, Oct 31, 2008 at 10:09:13PM +0100, Peter Mahlknecht wrote:

> Thanks for the hint. I get the wrong temperatures after loading the 
> lm90 module (hwmon driver), but also if i load em28xx_cx25843, which 
> is a part of the driver for my tv-card. Both modules depend on 
> i2c-core, so probably the bug is related to the i2c bus?

In the lm90 case it's almost certainly because you have the firmware and 
Linux trying to access the chip at the same time. Since it has indexed 
registers, this fails very miserably. I'm surprised that the TV card 
driver has any effect - it should be on an entirely spearate i2c bus. 
Are you sure you don't have lm90 loaded in that case?

-- 
Matthew Garrett | mjg59@srcf.ucam.org
