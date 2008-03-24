From: Adam Turk <bofh1234@hotmail.com>
Subject: acpid, sysfs, and hal
Date: Mon, 24 Mar 2008 14:53:56 -0400
Message-ID: <BAY101-W3296CA9C10DD76BF962248C8FD0@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from bay0-omc3-s22.bay0.hotmail.com ([65.54.246.222]:8737 "EHLO
	bay0-omc3-s22.bay0.hotmail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759013AbYCXSzB convert rfc822-to-8bit
	(ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 24 Mar 2008 14:55:01 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org


Hello,

I compiled 2.6.25-rc6 without support for deprecated items and not surprising acpid doesn't startup now.  acpid can't find /proc/acpi/events.  I read in the archives that hal was supposed to take over for the acpid daemon.  So what version of hal and hal-info and any other items will I need so pressing the power button with turn off my pc like it did with acpid?

Thanks,


_________________________________________________________________
Test your Star IQ
http://club.live.com/red_carpet_reveal.aspx?icid=redcarpet_HMTAGMAR