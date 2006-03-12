From: zicada@stoneinnovation.no
Subject: external monitor issue with acpi on whitebook.
Date: Sun, 12 Mar 2006 12:57:52 +0100 (CET)
Message-ID: <56646.83.249.129.209.1142164672.squirrel@83.249.129.209>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from [193.69.188.101] ([193.69.188.101]:36993 "EHLO
	stoneinnovation.no") by vger.kernel.org with ESMTP id S932220AbWCLMJc
	(ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 12 Mar 2006 07:09:32 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hello all,

I recently started trying to get ACPI working on a Quanta KN1 based
whitebook. These laptops come with a variety of names, but are all built
around the KN1 base. It has a 915gm/pm chipset and an nvidia geforce 6600
vga card.

As long as no external monitor is connected, every acpi feature works
perfectly,- but as soon as i connect my external monitor, pretty much
everything freezes until i disconnect it again. dmesg is filled up with
"unknown event" after a monitor has been connected.

I have tried rewriting the DSDT, but i fear my AML skills are pretty
lacking :)

I've searched the web but been unable to find anyone else with this exact
problem.
Is this is a bug in linux-acpi, a bug in DSDT or a combination ?

I can provide my original DSDT aswell as any logs needed.

Thanks in advance for any help or info on this matter.

-- Thomas W. Larsen
