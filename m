From: Yuri DElia <wavexx@users.sf.net>
Subject: Keyboard/case power button events
Date: Tue, 6 Sep 2011 21:18:32 +0000 (UTC)
Message-ID: <loom.20110906T230440-127@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:55699 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754405Ab1IFVZI (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 6 Sep 2011 17:25:08 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glad-acpi-devel@m.gmane.org>)
	id 1R138l-0004cL-L9
	for linux-acpi@vger.kernel.org; Tue, 06 Sep 2011 23:25:07 +0200
Received: from 93-89-57-184.ip.bkom.it ([93-89-57-184.ip.bkom.it])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-acpi@vger.kernel.org>; Tue, 06 Sep 2011 23:25:07 +0200
Received: from wavexx by 93-89-57-184.ip.bkom.it with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-acpi@vger.kernel.org>; Tue, 06 Sep 2011 23:25:07 +0200
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hi everyone,

I have a small but stupid issue on how the "power" (poweroff) event is
generated. Both the real power button (as in acpi/button.c) and the power
button in the keyboard (those with "media" keys) generate the same
indistinguishable event.

This is the event I get with both:

button/power PBTN 00000080 00000000

As a result, I cannot remap the keyboard event without also disabling the
handler for the real power button. I obviously want both.

Can I assign a different code, or string, or whatever (as long as I can match
it in userland) to either the real or keyboard button to distinguish the two?

Any help would be greatly appreciated.


