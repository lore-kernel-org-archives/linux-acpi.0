From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH] acpi: video: no automatic brightness changes by
 firmware
Date: Mon, 17 Jun 2013 23:40:40 +0100
Message-ID: <20130617224040.GB14793@srcf.ucam.org>
References: <51B98CFD.7090409@intel.com>
 <51BE5FD6.6070405@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:37764 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751050Ab3FQWkx (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 17 Jun 2013 18:40:53 -0400
Content-Disposition: inline
In-Reply-To: <51BE5FD6.6070405@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Aaron Lu <aaron.lu@intel.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Len Brown <lenb@kernel.org>, ACPI Devel Mailing List <linux-acpi@vger.kernel.org>, Zhang Rui <rui.zhang@intel.com>, Micael Dias <kam1kaz3@gmail.com>, Dan Garton <dan.garton@gmail.com>, Bob Ziuchkovski <bob.ziuchkovski@gmail.com>

On Mon, Jun 17, 2013 at 09:01:10AM +0800, Aaron Lu wrote:
> Starting from win8, MS backlight control driver will set bit 2 of the
> parameter of control method _DOS, to inform firmware it should not
> perform any automatic brightness changes. This mostly affects hotkey
> notification deliver - if we do not set this bit, on hotkey press,
> firmware may choose to adjust brightness level instead of sending out
> notification and doing nothing.

It's worth noting that this is a change in behaviour, and there's at 
least one VIA-based netbook where making this change breaks backlight 
control.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
