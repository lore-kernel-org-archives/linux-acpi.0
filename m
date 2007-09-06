From: Alan Hourihane <alanh@fairlite.demon.co.uk>
Subject: obtaining acpi details outside of drivers/acpi
Date: Thu, 06 Sep 2007 11:16:09 +0100
Message-ID: <1189073769.7969.32.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fairlite.demon.co.uk ([80.176.228.186]:54652 "EHLO
	fairlite.demon.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752603AbXIFKtc (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 6 Sep 2007 06:49:32 -0400
Received: from localhost (unknown [127.0.0.1])
	by fairlite.demon.co.uk (Postfix) with ESMTP id B45182A8C296
	for <linux-acpi@vger.kernel.org>; Thu,  6 Sep 2007 09:46:25 +0000 (UTC)
Received: from fairlite.demon.co.uk ([127.0.0.1])
	by localhost (server.demon.co.uk [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KyqGtcUAkkgO for <linux-acpi@vger.kernel.org>;
	Thu,  6 Sep 2007 10:46:25 +0100 (BST)
Received: from [192.168.0.50] (jetpack.demon.co.uk [192.168.0.50])
	by fairlite.demon.co.uk (Postfix) with ESMTP id 2ED612A8C2FF
	for <linux-acpi@vger.kernel.org>; Thu,  6 Sep 2007 10:46:25 +0100 (BST)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

I'm looking at the currently exported function calls to other kernel
modules to obtain ACPI data.

For example, if I want to access _DOD for graphics, the pathname would
be something like...

\\_SB_.PCI0.GFX0._DOD

And I'm currently doing this...

	status = acpi_evaluate_object(NULL, PATHNAME, NULL, &buffer);

where PATHNAME is the path above.

But there's no guarantees that it's called PCI0, or even GFX0.

What's the best way to search the namespace and get this data ??

Alan.

