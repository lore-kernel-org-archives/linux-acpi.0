From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH] ACPI / LPSS: Remove non-existing clock control from
 Intel Lynxpoint I2C
Date: Fri, 23 Jan 2015 12:52:39 +0200
Message-ID: <20150123105239.GO1850@lahna.fi.intel.com>
References: <1421998959-6595-1-git-send-email-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:28752 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752031AbbAWKwm (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 23 Jan 2015 05:52:42 -0500
Content-Disposition: inline
In-Reply-To: <1421998959-6595-1-git-send-email-jarkko.nikula@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc: linux-acpi@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>

On Fri, Jan 23, 2015 at 09:42:39AM +0200, Jarkko Nikula wrote:
> Intel Lynxpoint I2C does not have clock parameter register like SPI and UART
> do have. Therefore remove LPSS_CLK_GATE flag from the Lynxpoint I2C device
> description in order to not needlessly toggle clock enable bit in
> non-existing register.
> 
> Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
> ---
> For linux-next branch. This has been here since commit f58b082aed43
> ("ACPI / scan: Add special handler for Intel Lynxpoint LPSS devices")
> without known problems.
> 
> Mika: I assumed this holds true for INT3432 and INT3433 too?

Yes.

IIRC there used to be versions of Lynxpoint where the clock was actually
gated even if the document said the register is reserved. That's why the
I2C still tries to ungate the clock.

As long as you tested this properly,

Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
