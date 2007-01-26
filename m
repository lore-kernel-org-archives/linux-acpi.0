From: Johannes Engel <j-engel@gmx.de>
Subject: Re: [Acpi4asus-user] [patch 7/7] asus-laptop: add light sensor	support
Date: Fri, 26 Jan 2007 23:53:18 +0100
Message-ID: <45BA865E.4040706@gmx.de>
References: <200701251254.59337.corentincj@iksaif.net> <200701261404.58597.corentincj@iksaif.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:55694 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751687AbXAZWxe (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 26 Jan 2007 17:53:34 -0500
In-Reply-To: <200701261404.58597.corentincj@iksaif.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: corentincj@iksaif.net
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, acpi4asus-user@lists.sourceforge.net

Hi, Corentin!

Some remarks on your patch which upto now works great for me!

1.) configuration seems to have a "circle": Warning! Found recursive
dependency: ACPI_ASUS ASUS_LAPTOP ACPI_ASUS

2.) The dependency X86 makes it necessary to enable generic
X86-optimizations. Is that intended?

3.) With recent BIOS versions the implementation of the value for the
Touchpad LED has switched. So an "echo 0 > .../led" results in the led
to light. Maybe there is a way to deal with that in kernel space. But I
think we already had that discussion some months ago.

Greetings, Johannes
