From: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Subject: Re: why do drivers evaluate _INI?
Date: Tue, 23 Jun 2009 09:29:26 +0930 (CST)
Message-ID: <200906222359.n5MNxQsN006456@turbo.physics.adelaide.edu.au>
References: <200906221732.35993.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from adelphi.physics.adelaide.edu.au ([129.127.102.1]:53954 "EHLO
	adelphi.physics.adelaide.edu.au" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751587AbZFWAY7 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Mon, 22 Jun 2009 20:24:59 -0400
In-Reply-To: <200906221732.35993.bjorn.helgaas@hp.com> from "Bjorn Helgaas" at Jun 22, 2009 05:32:35 PM
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Len Brown <lenb@kernel.org>, Eric Piel <eric.piel@tremplin-utc.net>, Pavel Machek <pavel@suse.cz>, Jonathan Woithe <jwoithe@physics.adelaide.edu.au>, Mattia Dongili <malattia@linux.it>, linux-acpi@vger.kernel.org, nokos@gmx.net

Hi

> Why do we have ACPI device drivers evaluating _INI?  That seems
> like something that should be done by Linux/ACPI, not by the driver.
> 
> I see the following drivers using _INI:
>   drivers/hwmon/hp_accel.c
>   drivers/platform/x86/fujitsu-laptop.c
>   drivers/platform/x86/sony-laptop.c
> 
> I looked at the git logs where the _INI usage was introduced in
> these drivers, but none gives enough information for me to understand
> why.

I can't shed a lot of light on this from the point of view of
fujitsu-laptop.

It appears that the evaluation of _INI was added to fujitsu-laptop as part
of the patch which added support for hotkeys present on some Fujitsu
laptops.  This patch was contributed by Peter Gruber - I've added him to the
CC.  Perhaps he might explain why he added _INI evaluation as part of this
patch (that is, what problem was encountered which required evaluation of
_INI).

Regards
  jonathan
