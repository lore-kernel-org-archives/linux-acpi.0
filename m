From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] ACPI / video: only register backlight for LCD device
Date: Fri, 06 Nov 2015 00:43:22 +0100
Message-ID: <1749695.t53mDrm8mf@vostro.rjw.lan>
References: <563074A3.8090807@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:52987 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1756873AbbKEXOK (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 5 Nov 2015 18:14:10 -0500
In-Reply-To: <563074A3.8090807@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Aaron Lu <aaron.lu@intel.com>
Cc: ACPI Devel Mailing List <linux-acpi@vger.kernel.org>, Hans de Goede <hdegoede@redhat.com>, Christian Scharl <zahlsum-kernelbugs@yahoo.de>

On Wednesday, October 28, 2015 03:09:23 PM Aaron Lu wrote:
> The firmware of ESPRIMO Mobile M9410 has two video output devices that
> have _BCM control method, one is the type of "External Digital Monitor"
> while the other is the type of "Internal/Integrated Digital Flat Panel".
> Only the 2nd video output device's _BCM control method works, but
> since we have created two and the 1st one got picked up by user space,
> the backlight functionality is broken. To solve this problem, only
> register backlight interface for "Internal/Integrated Digital Flat Panel"
> type video output device on this laptop.
> 
> Another problem of this laptop is that the IDs listed by the _DOD method
> doesn't have bit 31 set, which means it doesn't follow the format
> specified by ACPI spec. But the value indicates that it actually follows
> that format so I've added a DMI quirk and a module level parameter to
> force use the device_id_scheme so that we can get the video output
> device's type to do the decision if we should register backlight
> interface.
> 
> Buglink: https://bugzilla.kernel.org/show_bug.cgi?id=104121
> Suggested-by: Hans de Goede <hdegoede@redhat.com>
> Reported-and-tested-by: Christian Scharl <zahlsum-kernelbugs@yahoo.de>
> Signed-off-by: Aaron Lu <aaron.lu@intel.com>

Applied, thanks!

Rafael

