From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH] ACPICA: Revert "ACPICA: Remove obsolete acpi_os_validate_address interface"
Date: Thu, 2 Jul 2009 12:22:14 +0200
Message-ID: <200907021222.15597.trenn@suse.de>
References: <1246415391.24831.30.camel@minggr.sh.intel.com> <alpine.LFD.2.00.0907012202580.19077@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:56980 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751736AbZGBKWN (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 2 Jul 2009 06:22:13 -0400
In-Reply-To: <alpine.LFD.2.00.0907012202580.19077@localhost.localdomain>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Lin Ming <ming.m.lin@intel.com>, "Moore, Robert" <robert.moore@intel.com>, Zhao Yakui <yakui.zhao@intel.com>, linux-acpi <linux-acpi@vger.kernel.org>

On Thursday 02 July 2009 04:03:55 Len Brown wrote:
> I can't apply a patch that adds a known memory leak,
> even if it removes a conflict between drivers.
Can you revert it with Lin's added on top (after discussing it), please.
It's always a good idea (or a must) to have a stable patch in mainline first.
I doubt we find a proper solution for 2.6.31.

> The reason is that there is a workaround for the driver conflict,
> but no workaround for the memory leak.
There is one now.

Thanks,

   Thomas
