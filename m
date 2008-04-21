From: Michel Lespinasse <walken@zoy.org>
Subject: Suspend issue on ancient asus A7V system
Date: Mon, 21 Apr 2008 02:36:41 -0700
Message-ID: <20080421093641.GD20322@zoy.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from server.lespinasse.org ([64.142.28.226]:39592 "EHLO
	server.lespinasse.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754977AbYDUKFO (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 21 Apr 2008 06:05:14 -0400
Received: from michel.lespinasse.org (michel.home.lespinasse.org [10.1.0.1])
	by server.lespinasse.org (Postfix) with ESMTP id 5F1A62FC4B
	for <linux-acpi@vger.kernel.org>; Mon, 21 Apr 2008 02:36:41 -0700 (PDT)
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi <linux-acpi@vger.kernel.org>

Hi,

I'm having a minor issue getting suspend to ram to work on an old
asus A7V based system: the system does suspend (I can hear the fans
go off etc...) but it immediately resumes.

I do have a workaround though: After booting, this system shows in
/proc/acpi/wakeup:
Device  S-state   Status   Sysfs node
PWRB      S5    *enabled   
PCI0      S4     disabled  no-bus:pci0000:00
USB0      S4     disabled  pci:0000:00:04.2
USB1      S4     disabled  pci:0000:00:04.3

If I run echo PWRB > /proc/acpi/wakeup,

1- the kernel complains that "ACPI: 'PCI0' and 'PWRB' have the same GPE,
   can't disable/enable one seperately"

2- /proc/acpi/wakeup now shows:
Device  S-state   Status   Sysfs node
PWRB      S5    *disabled  
PCI0      S4     disabled  no-bus:pci0000:00
USB0      S4     disabled  pci:0000:00:04.2
USB1      S4     disabled  pci:0000:00:04.3

3- The system can now be suspended, and it will
   resume normally when I press the power button.

This is not a recent regression, that system has been like that since
I first got suspend working.

Hope this helps. I can collect additional information if you tell me how.

Cheers,

-- 
Michel Lespinasse
