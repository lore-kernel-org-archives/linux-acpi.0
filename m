From: Sascha Heid <saschaheid@gmail.com>
Subject: Re: CoreDuo Bus-Master-Activity on Core1 ffffffff when idle, no C3
Date: Fri, 09 Feb 2007 19:35:51 +0100
Message-ID: <1171046151.11522.1.camel@localhost>
References: <1170989226.4546.17.camel@localhost>
	 <200702090154.02351.lenb@kernel.org>
	 <20070209142925.GE26414@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.175]:6584 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1946620AbXBIRgC (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 9 Feb 2007 12:36:02 -0500
Received: by ug-out-1314.google.com with SMTP id 44so2938uga
        for <linux-acpi@vger.kernel.org>; Fri, 09 Feb 2007 09:36:01 -0800 (PST)
In-Reply-To: <20070209142925.GE26414@khazad-dum.debian.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: linux-acpi@vger.kernel.org

Am Freitag, den 09.02.2007, 12:29 -0200 schrieb Henrique de Moraes
Holschuh:
> On Fri, 09 Feb 2007, Len Brown wrote:
> > Try disconnecting usb devices until lsusb shows nothing.
> 
> On some ThinkPads, this means removing uhci_hcd and ehci_hcd, because they
> have internal USB devices (bluetooth, fingerprint reader, etc).
> 

Thats it, added 1h Battery-Life immediately.

Thank you very much!

