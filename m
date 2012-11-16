From: Lekensteyn <lekensteyn@gmail.com>
Subject: ACPI Error: [_T_1] Namespace lookup failure, AE_ALREADY_EXISTS
Date: Fri, 16 Nov 2012 17:32:14 +0100
Message-ID: <1471550.uqjjeh6DEC@al>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:44323 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752354Ab2KPQcT (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 16 Nov 2012 11:32:19 -0500
Received: by mail-bk0-f46.google.com with SMTP id q16so1285908bkw.19
        for <linux-acpi@vger.kernel.org>; Fri, 16 Nov 2012 08:32:17 -0800 (PST)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hi,

I have written a WMI module for my Clevo laptop [1] that can accept WMI
notifications. This module usually works without issues, but I have rare times
where I get weird ACPI warnings *during* suspend (not on resume):

[21546.880745] ACPI Error: [_T_1] Namespace lookup failure, AE_ALREADY_EXISTS (20120913/dswload2-330)
[21546.880748] ACPI Exception: AE_ALREADY_EXISTS, During name lookup/catalog (20120913/psloop-231)
[21546.880753] ACPI Error: Method parse/execution failed [\_SB_.WMI_.WMBB] (Node ffff880232456988), AE_ALREADY_EXISTS (20120913/psparse-536)
[21546.880756] clevo_wmi: Failed to execute function 0x1: AE_ALREADY_EXISTS
[21546.880757] clevo_wmi: Could not get WMI event number.
[21546.900438] PM: suspend of devices complete after 459.769 msecs
[21546.900558] PM: late suspend of devices complete after 0.118 msecs
[21546.916355] ACPI: Marking method WMBB as Serialized because of AE_ALREADY_EXISTS error

The module installs a WMI notifier when loaded. When the notifier callback is
called, it calls a WMI method (WMBB) to retrieve the last event number. This
last thing is failing as can be seen above. The WMBB method is defined in
DSDT which can be found on [2] along with an acpidump and an analysis of
WMI events/methods.

To me, it seems a locking issue as this issue rarely occurs (3 times in like 2
months). I wonder if I did something wrong?

Regards,
Peter

 [1]: https://github.com/Lekensteyn/acpi-stuff/tree/master/clevo-wmi
 [2]: https://github.com/Lekensteyn/acpi-stuff/tree/master/dsl/Clevo_B7130
