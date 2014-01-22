From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: Why we put FAN to full speed in its suspend callback
Date: Wed, 22 Jan 2014 22:11:19 +0100
Message-ID: <3635936.Umz7ZeDeIX@vostro.rjw.lan>
References: <52DF89B6.1080400@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:49273 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752711AbaAVU5J (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 22 Jan 2014 15:57:09 -0500
In-Reply-To: <52DF89B6.1080400@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Aaron Lu <aaron.lu@intel.com>
Cc: Pavel Machek <pavel@suse.cz>, Konstantin Karasyov <konstantin.a.karasyov@intel.com>, Len Brown <lenb@kernel.org>, Zhang Rui <rui.zhang@intel.com>, Lan Tianyu <tianyu.lan@intel.com>, ACPI Devel Mailing List <linux-acpi@vger.kernel.org>

On Wednesday, January 22, 2014 05:04:54 PM Aaron Lu wrote:
> Hi,

Hi,

> I was trying to minimize system suspend time and it turned out there are
> firmwares that would do crazy things like delaying 10ms in FAN's power on
> control method. So I wonder why do we want to put the FAN into ACPI D0
> state when we are going to enter a sleep state? The code seems to be
> written according to Pavel's comment here:
> https://bugzilla.kernel.org/show_bug.cgi?id=5000#c6
> It would be great to understand why and remove that operation if
> possible, thanks for reading and taking your time bringing back your
> ancient memory :-)

Yes, this is for image creation code during hibernation and the same set of
callbacks was used for hibernation and suspend at that time.  I think we can
remove that thing for system suspend and leave it for hibernation only.

Thanks!

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
