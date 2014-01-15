From: Aaron Lu <aaron.lu@intel.com>
Subject: Re: [Aspire V5-431] Brightness control visible but does nothing
Date: Wed, 15 Jan 2014 11:28:23 +0800
Message-ID: <52D60057.2050505@intel.com>
References: <CADNMoF1A2iExRav_O8GYm8P9jbaf2GqPRsi+eymNtcddyfnUfA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:50418 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750928AbaAOD2G (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 14 Jan 2014 22:28:06 -0500
In-Reply-To: <CADNMoF1A2iExRav_O8GYm8P9jbaf2GqPRsi+eymNtcddyfnUfA@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Christensen <christensenthomas@gmail.com>, linux-acpi@vger.kernel.org

On 01/14/2014 06:02 PM, Thomas Christensen wrote:
> This laptop gets a /sys/class/backlight/acpi_video0 entry for
> backlight that is not working.
> 
> $ ls /sys/class/backlight
> acpi_video0  intel_backlight
> 
> and I see the following entry in the kernel log:
> 
> [   19.515016] acer_wmi: Brightness must be controlled by acpi video driver
> 
> By using 'acpi_backlight=vendor' my desktop starts to work.

Please file a bug to kernel bugzilla:
https://bugzilla.kernel.org/
Choose ACPI/Power-Video, and attach your acpidump there.

Thanks,
Aaron
