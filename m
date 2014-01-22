From: Aaron Lu <aaron.lu@intel.com>
Subject: Why we put FAN to full speed in its suspend callback
Date: Wed, 22 Jan 2014 17:04:54 +0800
Message-ID: <52DF89B6.1080400@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:44206 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751217AbaAVJEs (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 22 Jan 2014 04:04:48 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Pavel Machek <pavel@suse.cz>, Konstantin Karasyov <konstantin.a.karasyov@intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Zhang Rui <rui.zhang@intel.com>, Lan Tianyu <tianyu.lan@intel.com>, ACPI Devel Mailing List <linux-acpi@vger.kernel.org>

Hi,

I was trying to minimize system suspend time and it turned out there are
firmwares that would do crazy things like delaying 10ms in FAN's power on
control method. So I wonder why do we want to put the FAN into ACPI D0
state when we are going to enter a sleep state? The code seems to be
written according to Pavel's comment here:
https://bugzilla.kernel.org/show_bug.cgi?id=5000#c6
It would be great to understand why and remove that operation if
possible, thanks for reading and taking your time bringing back your
ancient memory :-)
