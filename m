From: Maxim Levitsky <maximlevitsky@gmail.com>
Subject: commit 'ACPICA: Minimize the differences between linux GPE code
 and ACPICA code base' breaks EC GPE on my system
Date: Fri, 11 Jun 2010 14:47:19 +0300
Message-ID: <1276256839.4251.7.camel@maxim-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.158]:8357 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758878Ab0FKLrY (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 11 Jun 2010 07:47:24 -0400
Received: by fg-out-1718.google.com with SMTP id l26so169424fgb.1
        for <linux-acpi@vger.kernel.org>; Fri, 11 Jun 2010 04:47:22 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Cc: mjg59 <mjg59@srcf.ucam.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, len.brown@intel.com

Just bisected it.

I also tried linux-acpi-next/test, and no change.

The sympthoms are that EC does't sent any GPEs, and therefore battery
insert/removal events don't show up.

It can be see by doing 'grep  . /sys/firmware/acpi/interrupts/*'
With regression the line is shown like this:


/sys/firmware/acpi/interrupts/gpe1C:   1	enabled

Without regression it is

/sys/firmware/acpi/interrupts/gpe1C:   22889	enabled

and steadily increasing.

After suspend/resume, regression disappears.

Best regards,
	Maxim Levitsky

