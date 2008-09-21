From: Chris Rankin <rankincj@yahoo.com>
Subject: Re: Thinkpad T60p does not recover from Suspend when docked.
Date: Sun, 21 Sep 2008 07:16:30 -0700 (PDT)
Message-ID: <888845.45804.qm@web52903.mail.re2.yahoo.com>
Reply-To: rankincj@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from web52903.mail.re2.yahoo.com ([206.190.49.13]:47372 "HELO
	web52903.mail.re2.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751565AbYIUOQb convert rfc822-to-8bit
	(ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 21 Sep 2008 10:16:31 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Hi,

I have now migrated my laptop to the 2.6.26.5 kernel, and it is still failing to resume from "suspend to RAM" if the SATA drive is in the docking bay. I did notice the following in the dmesg log, which might be relevant:

ACPI: \_SB_.PCI0.IDE0.PRIM.MSTR: found ejectable bay
ACPI: \_SB_.PCI0.IDE0.PRIM.MSTR: Adding notify handler
ACPI: Error installing bay notify handler

I have raised this as bug #11604 at bugzilla.kernel.org.

Cheers,
Chris


      
