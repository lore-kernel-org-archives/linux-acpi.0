From: David Brownell <david-b@pacbell.net>
Subject: Re: RTC_DRV_CMOS can break userspace interface
Date: Sun, 27 May 2007 18:44:49 -0700
Message-ID: <200705271844.54589.david-b@pacbell.net>
References: <20070527190351.GA21387@srcf.ucam.org> <20070527233911.GA23491@srcf.ucam.org> <20070528003822.GA23759@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp108.sbc.mail.mud.yahoo.com ([68.142.198.207]:46427 "HELO
	smtp108.sbc.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751365AbXE1CGd (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sun, 27 May 2007 22:06:33 -0400
In-Reply-To: <20070528003822.GA23759@srcf.ucam.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

On Sunday 27 May 2007, Matthew Garrett wrote:
> On Mon, May 28, 2007 at 12:39:11AM +0100, Matthew Garrett wrote:
> 
> > but will disable /proc/acpi/wakeup. It'll also be impossible to load 
> > CONFIG_RTC_CMOS because CONFIG_RTC has grabbed the io ports, so it's not 
> > possible to use the new interface. This situation doesn't appear to be 
> > documented, which is less than ideal...
> 
> Actually, it seems to be worse than that - the PNP entry for my cmos 
> clock doesn't appear to mention an irq, so the wakealarm entry doesn't 
> work. I can happily wake it using the /proc/acpi/alarm interface.
> 
> David, would you be happy with hardcoding the rtc-cmos IRQ to 8 on PCs 
> if there's inadequate PNP information available?

That would seem to naturally belong in the PNP code, yes?

Agreed that it seems like it needs to be hardcoded somewhere.

- Dave
