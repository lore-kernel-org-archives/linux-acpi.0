From: Mike Houston <mikeserv@bmts.com>
Subject: Re: [lm-sensors] 2.6.24-rc4 hwmon it87 probe fails
Date: Sun, 9 Dec 2007 23:02:11 -0500
Message-ID: <20071209230211.1c2077cf.mikeserv@bmts.com>
References: <20071204215154.7f26285e.mikeserv@bmts.com>
	<20071209000554.GF20441@stusta.de>
	<20071208212234.e00b74cd.mikeserv@bmts.com>
	<20071209105028.06ed52a6@hyperion.delvare>
	<E1J1TRp-0000ZF-6J@asgard.prans.org>
	<20071209220430.GK20441@stusta.de>
	<1197253887.27516.2.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754035AbXLJEC2@vger.kernel.org>
In-Reply-To: <1197253887.27516.2.camel@sli10-desk.sh.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Shaohua Li <shaohua.li@intel.com>
Cc: Adrian Bunk <bunk@stusta.de>, Elvis Pranskevichus <el@prans.net>, Jean Delvare <khali@linux-fr.org>, Mike Houston <mikeserv@bmts.com>, mhoffman@lightlink.com, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org, Bjorn Helgaas <bjorn.helgaas@hp.com>, Adam Belay <ambx1@neo.rr.com>, Zhao Yakui <yakui.zhao@intel.com>, Thomas Renninger <trenn@suse.de>, lenb@kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Mon, 10 Dec 2007 10:31:27 +0800
Shaohua Li <shaohua.li@intel.com> wrote:
> This should exist in previous kernel (before we remove acpi
> motherboard driver) too. Basically it's a broken BIOS. Could below
> patch work around it?
> 
> Thanks,
> Shaohua
> 
> Index: linux/drivers/pnp/system.c
> ===================================================================
> --- linux.orig/drivers/pnp/system.c	2007-12-10
> 10:17:46.000000000 +0800 +++ linux/drivers/pnp/system.c

Thanks Shaohua, I tested this as well and it appears to have worked
around the issue for me.

Now, in dmesg, I get:

system 00:01: ioport range 0x290-0x29f has been reserved
(...)
system 00:01: ioport range 0x290-0x294 could not be reserved

In /proc/ioports I see:

0290-029f : pnp 00:01
  0290-0297 : it87
    0290-0297 : it87

The it87 sensor now works without disabling acpipnp

Mike Houston
