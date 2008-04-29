From: Len Brown <lenb@kernel.org>
Subject: Re: [GIT PATCH] thinkpad-acpi queue for the 2.6.26 merge window (v2)
Date: Tue, 29 Apr 2008 05:08:01 -0400
Message-ID: <200804290508.01452.lenb@kernel.org>
References: <1209182550-32725-1-git-send-email-hmh@hmh.eng.br>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:43101 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757563AbYD2OVV (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 29 Apr 2008 10:21:21 -0400
In-Reply-To: <1209182550-32725-1-git-send-email-hmh@hmh.eng.br>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: ibm-acpi-devel@lists.sourceforge.net, linux-acpi@vger.kernel.org

Wups,
looks like I still have v1 in my tree -- will fix.

-Len

On Saturday 26 April 2008, Henrique de Moraes Holschuh wrote:
> Len,
> 
> This patchset has my current thinkpad-acpi queue.  The target is 2.6.26's
> merge window.
> 
> Some of the thinkpad-acpi patches require patches from Richard Purdie's LED
> tree that have been recently merged in mainline.
> 
> As usual, the patch set is available at:
> git://repo.or.cz/linux-2.6/linux-acpi-2.6/ibm-acpi-2.6.git for-upstream/acpi-test
> 
> Shortlog:
> 
> Henrique de Moraes Holschuh (14):
>       ACPI: thinkpad-acpi: BIOS backlight mode helper (v2.1)
>       ACPI: thinkpad-acpi: warn once about weird hotkey masks
>       ACPI: thinkpad-acpi: enhance box identification output (v2)
>       ACPI: thinkpad-acpi: rate-limit CMOS/EC unsynced error messages
>       ACPI: thinkpad-acpi: fix brightness dimming control bug
>       ACPI: thinkpad-acpi: claim tpacpi as an official short handle (v1.1)
>       ACPI: thinkpad-acpi: prepare light and LED for sysfs support
>       ACPI: thinkpad-acpi: add sysfs led class support for thinklight (v3.1)
>       ACPI: thinkpad-acpi: add sysfs led class support to thinkpad leds (v3.2)
>       ACPI: thinkpad-acpi: use uppercase for "LED" on user documentation
>       ACPI: thinkpad-acpi: fluff really minor fix
>       ACPI: thinkpad-acpi: use a private workqueue
>       ACPI: thinkpad-acpi: fix selects in Kconfig
>       ACPI: thinkpad-acpi: bump up version to 0.20
> 
> Please merge the thinkpad-acpi changesets for acpi-test, for submission in
> the currently open mainline merge window.
> 


