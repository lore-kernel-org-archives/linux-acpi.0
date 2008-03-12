From: Thomas Renninger <trenn@suse.de>
Subject: [PATCH 0/3] [2.6.25-rc5] Handle a common BIOS bug on recent ASUS
	BIOS updates gracefully
Date: Wed, 12 Mar 2008 01:06:02 +0100
Message-ID: <1205280362.8194.42.camel@linux-2bdv.site>
Reply-To: trenn@suse.de
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ns2.suse.de ([195.135.220.15]:44781 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751327AbYCLAFt (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 11 Mar 2008 20:05:49 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi <linux-acpi@vger.kernel.org>, "Zhang, Rui" <rui.zhang@intel.com>

Hi Len,

the first patch fixes a memory corruption in ACPICA.
Memory corruption should legitimate this as 2.6.25-rc5 material (also
because this looks rather safe to do and seem to pop up on a lot recent
BIOS updates).
The second patch catches the NULL pointer which is passed on
evaluate_reference now, instead of a corrupted pointer.
The third patch tells the user that his BIOS has an invalid reference as
a passive cooling device (the invalid reference is the NULL handle now).

I have checked this working (ran into the corrupted memory and NULL
pointer) by invalidating a passive trip point and simulate the broken
ASUS BIOSes by overriding a DSDT on another system.

The first report which verifies the patches working with a 2.6.24 kernel
patched on a real broken ASUS Bios can be found here:
https://bugzilla.novell.com/show_bug.cgi?id=350017

Comment #40:
"Works on the Asus M2N-E and M2A VM HDMI."

Thanks,

  Thomas

