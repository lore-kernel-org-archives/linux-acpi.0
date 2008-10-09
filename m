From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: Buggy BIOS on the HP TX2500-series
Date: Thu, 09 Oct 2008 08:59:15 +0800
Message-ID: <1223513955.2735.28.camel@rzhang-dt>
References: <331496.52627.qm@web23007.mail.ird.yahoo.com>
	 <20081008192641.GA1932@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:57974 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753519AbYJIBBC (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 8 Oct 2008 21:01:02 -0400
In-Reply-To: <20081008192641.GA1932@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Gandalf Kristensen <gandkri@yahoo.no>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, "Lin, Ming M" <ming.m.lin@intel.com>

On Wed, 2008-10-08 at 12:26 -0700, Matthew Garrett wrote:
> A patch went into the kernel earlier this year to ignore critical trip
> points that were below 0.
well, I think this patch is wrong.
a critical trip point below 0 Celsius doesn't mean it's invalid.
windows can work well on this laptop.
please look at:
http://bugzilla.kernel.org/show_bug.cgi?id=10686#c13
IMO, we need to fix the ACPICA code first of all.

Ming, what do you think of the patch in comment #15 and #16?

thanks,
rui

>  Does that not deal with the issue?
> 
> --
> Matthew Garrett | mjg59@srcf.ucam.org
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

