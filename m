From: Aaron Lu <aaron.lu@intel.com>
Subject: Re: [PATCH] acpi: video: no automatic brightness changes by firmware
Date: Tue, 18 Jun 2013 08:13:28 +0800
Message-ID: <51BFA628.8000804@intel.com>
References: <51B98CFD.7090409@intel.com> <51BE5FD6.6070405@intel.com> <20130617224040.GB14793@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:20158 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751856Ab3FRANS (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 17 Jun 2013 20:13:18 -0400
In-Reply-To: <20130617224040.GB14793@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Len Brown <lenb@kernel.org>, ACPI Devel Mailing List <linux-acpi@vger.kernel.org>, Zhang Rui <rui.zhang@intel.com>, Micael Dias <kam1kaz3@gmail.com>, Dan Garton <dan.garton@gmail.com>, Bob Ziuchkovski <bob.ziuchkovski@gmail.com>

On 06/18/2013 06:40 AM, Matthew Garrett wrote:
> On Mon, Jun 17, 2013 at 09:01:10AM +0800, Aaron Lu wrote:
>> Starting from win8, MS backlight control driver will set bit 2 of the
>> parameter of control method _DOS, to inform firmware it should not
>> perform any automatic brightness changes. This mostly affects hotkey
>> notification deliver - if we do not set this bit, on hotkey press,
>> firmware may choose to adjust brightness level instead of sending out
>> notification and doing nothing.
> 
> It's worth noting that this is a change in behaviour, and there's at 
> least one VIA-based netbook where making this change breaks backlight 
> control.

Thanks for pointing this out.
Do you have any more information about this system, like its ACPI dump?

BTW, perhaps we should make this behavior change only for win8 systems?

Thanks,
Aaron
