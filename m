From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: 2.6.21-rc1: T60 resume from suspend to RAM issues
Date: Sun, 25 Feb 2007 10:03:41 +0100
Message-ID: <1172394221.25076.359.camel@localhost.localdomain>
References: <20070222233803.GA4447@mellanox.co.il>
Reply-To: tglx@linutronix.de
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from www.osadl.org ([213.239.205.134]:37252 "EHLO mail.tglx.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S933681AbXBYI6T (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 25 Feb 2007 03:58:19 -0500
In-Reply-To: <20070222233803.GA4447@mellanox.co.il>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Adrian Bunk <bunk@stusta.de>, pavel@suse.cz, linux-pm@osdl.org, linux-acpi@vger.kernel.org, len.brown@intel.com, mingo@redhat.com

On Fri, 2007-02-23 at 01:38 +0200, Michael S. Tsirkin wrote:
> 1. After suspend to RAM, system wakes up but no screen.
> I can log in through ssh though.
> dmesg output at this point below.
> Works fine on 2.6.20 and below, with same .config
> .config and log file for this issue attached.
> 
> 2. As a separate test, I enabled DynTicks in .config.
> Seems to work fine but won't come out of suspend to memory at all:
> pressing Fn/F4 seems to have no effect.

Am I reading this correct, that the box is simply dead after supsend ?
Fn/F4 are the keys you use to resume, right ?

Hmm, I have no idea how dynticks should influence the keyboard wakeup.
The box is somewhere in the guts of the BIOS at this point.

	tglx


