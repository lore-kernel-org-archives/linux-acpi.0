From: limp <johnkyr83@hotmail.com>
Subject: Necessity of SMM/SMI use on ACPI x86 systems
Date: Sun, 3 Apr 2011 12:40:47 +0100
Message-ID: <SNT111-DS81E1BD67986CA3A41C144A7A00@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from snt0-omc1-s23.snt0.hotmail.com ([65.55.90.34]:11289 "EHLO
	snt0-omc1-s23.snt0.hotmail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751251Ab1DCLrA (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 3 Apr 2011 07:47:00 -0400
Content-Language: en-gb
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Dear all,

I am doing some research regarding ACPI and SMM PM interfaces for the x86
architecture.

What I've found so far is that ACPI is the new trend for x86 PM and tends to
eliminate the use of SMM/SMI.
However, I am not quite sure if SMM/SMI mechanism can be completely
ignored/not used in current systems.
AFAIK, some ACPI AML BIOS code can trigger an SMI for handling specific
events.

Can anyone advise me if it's possible to write ACPI AML BIOS code that does
whatever it was intended to be executed in SMM? In general, is there any
*strong* argument saying that (at least) current systems cannot completely
eliminate the use of SMIs?

Thank you all in advance,

Best wishes.

