From: "Brown, Len" <len.brown@intel.com>
Subject: RE: Extra ACPI objects from an acpi PNP device?
Date: Wed, 10 May 2006 15:54:29 -0400
Message-ID: <CFF307C98FEABE47A452B27C06B85BB669C15D@hdsmsx411.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:20511 "EHLO
	azsmga101-1.ch.intel.com") by vger.kernel.org with ESMTP
	id S1751247AbWEJTyd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 10 May 2006 15:54:33 -0400
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Corey Minyard <minyard@acm.org>, linux-acpi@vger.kernel.org, ambx1@neo.rr.com
Cc: Matt Domsch <Matt_Domsch@dell.com>

>I have a situation where I need to get an ACPI device.  The PNP system
>seems like the way to go for this, but I need some extra objects from
>the ACPI namespace for this device (_IFT and _SRV to be specific,
>supposidly added in ACPI 3.0).  There doesn't seem to be a clean way to
>do this right now.  What would be the best way to get these?

If your code knows about specific AML methods, then it is by-definition,
ACPI-aware, and can't be hidden (completely) behind PNP.

Either that, or some ACPI-aware code needs to exist to intervene to
allow your code to know know anything about ACPI.

So you could make it ACPI aware like 8250_acpi.c was, before it was
deleted...

-Len
