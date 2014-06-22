From: Martin Kepplinger <martink@posteo.de>
Subject: [BUG] rc1 and rc2: Laptop unusable: on boot,screen black instead
 of native resolution
Date: Sun, 22 Jun 2014 16:24:42 +0200
Message-ID: <53A6E72A.9090000@posteo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx02.posteo.de ([89.146.194.165]:55152 "EHLO posteo.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750993AbaFVOZO (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 22 Jun 2014 10:25:14 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: rui.zhang@intel.com
Cc: rjw@rjwysocki.net, lenb@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

Since 3.16-rc1 my laptop's just goes black while booting, instead of
switching to native screen resolution and showing me the starting
system there. It's an Acer TravelMate B113 with i915 driver and
acer_wmi. It stays black and is unusable.

Do you have other people complain about that? Bisecting didn't lead to a
good result. I could be wrong but I somehow suspect the mistake to be
somewhere in commit 99678ed73a50d2df8b5f3c801e29e9b7a3e5aa85

There is nothing unusual in the kernel log.

This is quite unusual for an -rc2. Hence my question. I'm happy to test
changes.

                                     martin
-- 
Martin Kepplinger
e-mail        martink AT posteo DOT at
chat (XMPP)   martink AT jabber DOT at
