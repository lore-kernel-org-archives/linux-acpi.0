From: Mr Dash Four <mr.dash.four@googlemail.com>
Subject: Re: ACPI conflicts
Date: Tue, 11 Sep 2012 00:20:41 +0100
Message-ID: <504E75C9.9020706@googlemail.com>
References: <504D2D39.5090709@googlemail.com>	 <1347238787.1682.1045.camel@rui.sh.intel.com>	 <504D3CFC.2080805@googlemail.com> <1347239756.1682.1046.camel@rui.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:42752 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751460Ab2IJXUo (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 10 Sep 2012 19:20:44 -0400
Received: by wgbdr13 with SMTP id dr13so2414495wgb.1
        for <linux-acpi@vger.kernel.org>; Mon, 10 Sep 2012 16:20:43 -0700 (PDT)
In-Reply-To: <1347239756.1682.1046.camel@rui.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

> then how about clearing CONFIG_LPC_ICH?
That did the trick, thank you - you are a star!

Now, if I knew how to tell ACPI *not* to claim (or try to) the last two regions, I'll be more than happy. In other words, the last two warnings I have:

ACPI Warning: 0x00000290-0x00000297 SystemIO conflicts with Region \_TZ_.IP__ 1 (20120320/utaddress-251)
ACPI Warning: 0x00000290-0x00000297 SystemIO conflicts with Region \_SB_.PCI0.LPCB.SIO1.RNTR 2 (20120320/utaddress-251)

are caused by the fact that I simply need to load a separate module (f71882fg) to manage my fan speeds. ACPI is incapable of doing that, but still some of its components/code is trying to claim these regions. If I know how to tell ACPI not to touch these and let the f71882fg driver do its work, I'll be a happy man...
