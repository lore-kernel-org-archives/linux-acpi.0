From: Aaron Lu <aaron.lu@intel.com>
Subject: Re: Why we put FAN to full speed in its suspend callback
Date: Thu, 23 Jan 2014 09:08:42 +0800
Message-ID: <52E06B9A.5080905@intel.com>
References: <52DF89B6.1080400@intel.com> <3635936.Umz7ZeDeIX@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:3285 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752944AbaAWBIX (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 22 Jan 2014 20:08:23 -0500
In-Reply-To: <3635936.Umz7ZeDeIX@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Pavel Machek <pavel@suse.cz>, Len Brown <lenb@kernel.org>, Zhang Rui <rui.zhang@intel.com>, Lan Tianyu <tianyu.lan@intel.com>, ACPI Devel Mailing List <linux-acpi@vger.kernel.org>

Removed Konstantin since his email address is undeliverable.

On 01/23/2014 05:11 AM, Rafael J. Wysocki wrote:
> On Wednesday, January 22, 2014 05:04:54 PM Aaron Lu wrote:
>> Hi,
> 
> Hi,
> 
>> I was trying to minimize system suspend time and it turned out there are
>> firmwares that would do crazy things like delaying 10ms in FAN's power on
>> control method. So I wonder why do we want to put the FAN into ACPI D0
>> state when we are going to enter a sleep state? The code seems to be
>> written according to Pavel's comment here:
>> https://bugzilla.kernel.org/show_bug.cgi?id=5000#c6
>> It would be great to understand why and remove that operation if
>> possible, thanks for reading and taking your time bringing back your
>> ancient memory :-)
> 
> Yes, this is for image creation code during hibernation and the same set of
> callbacks was used for hibernation and suspend at that time.  I think we can
> remove that thing for system suspend and leave it for hibernation only.

OK, thanks a lot for the clarification, I'll prepare a patch to do that.
