From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH] ACPI / video: Add HP EliteBook Revolve 810 to the
 blacklist
Date: Fri, 7 Feb 2014 12:25:23 +0200
Message-ID: <20140207102523.GO18029@intel.com>
References: <1391425156-27821-1-git-send-email-mika.westerberg@linux.intel.com>
 <52F43716.7020008@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:42298 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751823AbaBGKST (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 7 Feb 2014 05:18:19 -0500
Content-Disposition: inline
In-Reply-To: <52F43716.7020008@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Aaron Lu <aaron.lu@intel.com>
Cc: linux-acpi@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org

On Fri, Feb 07, 2014 at 09:29:58AM +0800, Aaron Lu wrote:
> On 02/03/2014 06:59 PM, Mika Westerberg wrote:
> > On HP EliteBook Revolve 810 the ACPI backlight device doesn't work as
> > expected. For example when resuming from system sleep, it seems to lose
> > backlight settings.
> > 
> > Forcing Intel driver fixes the problem so add this machine the ACPI
> > video detect blacklist.
> 
> For reference's purpose, can you please file a bug to kernel bugzilla
> under the ACPI/Power-Video category and attach the acpidump and dmesg
> there? Thanks.

Done, the bug is here:

https://bugzilla.kernel.org/show_bug.cgi?id=70231

I noticed that using only the acpi_video0 for tuning backlight works but if
I use intel_backlight directly, on resume I get values from acpi_video0
instead. I'm not really familiar how this is supposed to work, though so
please let me know if I'm missing something.

Thanks.
