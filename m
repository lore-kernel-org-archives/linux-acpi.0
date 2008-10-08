From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] WDRT based watchdog timer
Date: Wed, 08 Oct 2008 16:25:48 -0400 (EDT)
Message-ID: <alpine.LFD.1.10.0810081552220.3041@localhost.localdomain>
References: <20080926232752.GA6061@cosmic.amd.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173001pub.verizon.net ([206.46.173.1]:64816 "EHLO
	vms173001pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751782AbYJHU0L (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 8 Oct 2008 16:26:11 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms173001.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0K8F00JRSSR2BOF5@vms173001.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 08 Oct 2008 15:25:51 -0500 (CDT)
In-reply-to: <20080926232752.GA6061@cosmic.amd.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jordan Crouse <jordan.crouse@amd.com>
Cc: linux-acpi@vger.kernel.org, Marc Brooker <mbrooker@rrsg.ee.uct.ac.za>, Wim Van Sebroeck <wim@iguana.be>



On Fri, 26 Sep 2008, Jordan Crouse wrote:

> Attached is a patch to support watchdog timers as described
> by the WDRT (Watch Dog Resource Table).  This has been tested on
> the AMD SB600 chipset, but it should work for any chipset / BIOS
> that implements the WDRT table.
> 
> I'm not in love with the name - but I couldn't think of anything
> better, so I'm open to suggestions.  I have a limited number of
> systems that implement this interface, so I would be very happy
> to hear from other users, especially ones not using AMD chipsets.

While this driver depends on ACPI, it actually isn't part of ACPI.

Indeed, here is 100% of the ACPI spec support for this watchdog timer:

"WDRT" Watchdog Resource Table Watchdog Timer Hardware Requirements for
                               Windows Server 2003
                               http://www.microsoft.com/whdc/system/CEC/
                               watchdog.mspx

so while the driver uses ACPI to enumerate the device,
the device doesn't use any run-time ACPI support,
and the Windows spec above actually defines the hardware.

> drivers/watchdog/acpiwdt.c

I'm not wild about having the string "acpi" be part of the driver name,
config option, variable names etc.   Maybe the spec above which actually
defines the timer would suggest a better name; or maybe simply
name it after its configuration table, wrdt.c?

The spec URL should be in the driver comments or commit log, BTW.

I don't know who maintains /drivers/watchdog/,
but Wim Van Sebroeck has scribbled there the most recently,
and can probably weigh in on this.

I searched my logs for WRDT and found only one,
and it does happen to be one with an Intel processor --
though an nvidia chipset:

http://bugzilla.kernel.org/show_bug.cgi?id=8950

so maybe Marc will be able to test the new driver?

thanks,
-Len





