From: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
Subject: WMI module autoloading (for hp-wmi, dell-wmi, tc1100-wmi)
Date: Mon, 03 Aug 2009 11:53:44 +0100
Message-ID: <4A76C1B8.6080000@tuffmail.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ew0-f214.google.com ([209.85.219.214]:37605 "EHLO
	mail-ew0-f214.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752318AbZHCKxv (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 3 Aug 2009 06:53:51 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Carlos Corbacho <carlos@strangeworlds.co.uk>
Cc: linux acpi <linux-acpi@vger.kernel.org>, linux-kernel@vger.kernel.org

Hi

I believe you had a patch to add support for auto-loading of wmi
modules.  But it stalled because it also added a userspace interface to
WMI in sysfs, which didn't fit very well.

So at the moment, only acer-wmi is autoloaded, because it has a DMI
autoload hack.  hp-wmi, dell-wmi, and tc1100-wmi are out of luck, even
though a second DMI hack was proposed for dell-wmi.

Would it be possible to add the auto-load support on it's own?  Is it
just a matter of someone taking the time to cherry-pick the auto-loading
bits from the original patch, and test the result?

Thanks
Alan
