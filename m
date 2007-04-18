From: "Gene Lapointe" <gene@thelapointefamily.com>
Subject: Re: ACPI Question
Date: Tue, 17 Apr 2007 22:36:17 -0400 (EDT)
Message-ID: <54681.192.168.1.1.1176863777.squirrel@thelapointefamily.com>
References: <60670.192.168.1.1.1176858643.squirrel@thelapointefamily.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cpe-static-aglapointe-unk.cmts.sha.ptd.net ([24.229.60.172]:57892
	"EHLO mail.thelapointefamily.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1031317AbXDRCcJ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 17 Apr 2007 22:32:09 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.thelapointefamily.com (Postfix) with ESMTP id 4235114000A7
	for <linux-acpi@vger.kernel.org>; Tue, 17 Apr 2007 22:36:18 -0400 (EDT)
Received: from mail.thelapointefamily.com ([127.0.0.1])
	by localhost (mail.thelapointefamily.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LIrsuubSHAPq for <linux-acpi@vger.kernel.org>;
	Tue, 17 Apr 2007 22:36:17 -0400 (EDT)
In-Reply-To: <60670.192.168.1.1.1176858643.squirrel@thelapointefamily.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

As an addition (I think it's related), here is a message that I get at
Startup

[17179570.368000] PCI: Cannot allocate resource region 7 of bridge
0000:00:1c.0
[17179570.368000] PCI: Cannot allocate resource region 8 of bridge
0000:00:1c.0
[17179570.368000] PCI: Cannot allocate resource region 9 of bridge
0000:00:1c.0
[17179570.368000] PCI: Cannot allocate resource region 7 of bridge
0000:00:1c.1
[17179570.368000] PCI: Cannot allocate resource region 8 of bridge
0000:00:1c.1
[17179570.368000] PCI: Cannot allocate resource region 9 of bridge
0000:00:1c.1
[17179570.368000] PCI: Cannot allocate resource region 7 of bridge
0000:00:1c.2
[17179570.368000] PCI: Cannot allocate resource region 8 of bridge
0000:00:1c.2
[17179570.368000] PCI: Cannot allocate resource region 9 of bridge
0000:00:1c.2
[17179578.808000] Cannot allocate resource for EISA slot 1
[17179578.808000] Cannot allocate resource for EISA slot 2

> hey, weird question, ever since i changed my dsdt to get my sound working,
> my battery status doesn't show in the notification bar, but acpi is
> working from a command prompt.  I'm running Gnome on Ubuntu, any ideas?
>
> --
> Gene Lapointe
> gene@thelapointefamily.com
> -
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>


-- 
Gene Lapointe
gene@thelapointefamily.com
