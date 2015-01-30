From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] ACPI / LPSS: Remove non-existing clock control from Intel Lynxpoint I2C
Date: Fri, 30 Jan 2015 01:08:55 +0100
Message-ID: <2768476.P0otSvAqZD@vostro.rjw.lan>
References: <1421998959-6595-1-git-send-email-jarkko.nikula@linux.intel.com> <20150123105239.GO1850@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:57475 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752349AbbA2XqH (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 29 Jan 2015 18:46:07 -0500
In-Reply-To: <20150123105239.GO1850@lahna.fi.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Jarkko Nikula <jarkko.nikula@linux.intel.com>, linux-acpi@vger.kernel.org

On Friday, January 23, 2015 12:52:39 PM Mika Westerberg wrote:
> On Fri, Jan 23, 2015 at 09:42:39AM +0200, Jarkko Nikula wrote:
> > Intel Lynxpoint I2C does not have clock parameter register like SPI and UART
> > do have. Therefore remove LPSS_CLK_GATE flag from the Lynxpoint I2C device
> > description in order to not needlessly toggle clock enable bit in
> > non-existing register.
> > 
> > Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
> > ---
> > For linux-next branch. This has been here since commit f58b082aed43
> > ("ACPI / scan: Add special handler for Intel Lynxpoint LPSS devices")
> > without known problems.
> > 
> > Mika: I assumed this holds true for INT3432 and INT3433 too?
> 
> Yes.
> 
> IIRC there used to be versions of Lynxpoint where the clock was actually
> gated even if the document said the register is reserved. That's why the
> I2C still tries to ungate the clock.
> 
> As long as you tested this properly,
> 
> Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Queued up for 3.20 then, thanks!


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
