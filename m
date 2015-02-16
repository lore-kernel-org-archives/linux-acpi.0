From: Chris Rorvick <chris@rorvick.com>
Subject: [BUG] b893e80e3147 breaks touchpad on Dell XPS13
Date: Mon, 16 Feb 2015 01:14:12 -0600
Message-ID: <CAEUsAPagb+cO8muTgTCRVg9wN-7rEgYbdSOm4bBOwDre8E-ARA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-qg0-f46.google.com ([209.85.192.46]:44334 "EHLO
	mail-qg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751254AbbBPHON (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 16 Feb 2015 02:14:13 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>

Hi,

Commit b893e80e3147 ("ACPI / LPSS: Remove non-existing clock control
from Intel Lynxpoint I2C") is causing my touchpad to not load on my
Dell XPS13.  I do not see any errors in the Xorg log, just 20 or so
lines missing where it would normally be loading the synaptics driver.
Reverting this commit against Linus's tree (i.e., commit a9724125ad01)
makes it happy again.

Let me know if you need any further info.

Regards,

Chris
