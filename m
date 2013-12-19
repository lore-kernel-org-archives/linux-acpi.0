From: Fabian Wehning <fabian.wehning@googlemail.com>
Subject: [Medion P8610] 13.10: Kernel panic - not syncing (on system start)
Date: Thu, 19 Dec 2013 22:52:39 +0100
Message-ID: <52B36AA7.2050705@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ea0-f176.google.com ([209.85.215.176]:58086 "EHLO
	mail-ea0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754228Ab3LSVxh (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 19 Dec 2013 16:53:37 -0500
Received: by mail-ea0-f176.google.com with SMTP id h14so699523eaj.35
        for <linux-acpi@vger.kernel.org>; Thu, 19 Dec 2013 13:53:36 -0800 (PST)
Received: from [192.168.170.22] (ip-109-90-197-190.unitymediagroup.de. [109.90.197.190])
        by mx.google.com with ESMTPSA id 44sm12993246eek.5.2013.12.19.13.53.33
        for <linux-acpi@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 19 Dec 2013 13:53:34 -0800 (PST)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

[1.] One line summary of the problem:
[Medion P8610] 13.10: Kernel panic - not syncing (on system start)

[2.] Full description of the problem/report:
While booting linux crashes with the message "Kernel panic - not
syncing: Attempt to kill init! exitcode=0x00000009". In a bisect (done
by Joseph Salisbury [joseph.salisbury@canonical.com]) it was tested and
this bug seems to be introduced either by

commit 76a6225bf0b64572251a8c27d33e84afac6af713
Author: Bob Moore <robert.moore@intel.com>
Date: Fri Mar 8 09:23:16 2013 +0000

    ACPICA: Split object conversion functions to a new file

or

commit d5a36100f62fa6db5541344e08b361b34e9114c5
Author: Bob Moore <robert.moore@intel.com>
Date: Fri Mar 8 09:23:03 2013 +0000

    ACPICA: Add mechanism for early object repairs on a per-name basis


[3.] Keywords (i.e., modules, networking, kernel):
kernel, Ubuntu, ACPICA

[4.] Kernel version (from /proc/version):
--> unable to boot therefore impossible to get

[5.] No Oops.. message

[6.] Beyond skill level

[7.] Environment
--> unable to boot therefore impossible to execute the command

[7.1.] Software:
--> unable to boot therefore impossible to get

[7.2.] Processor information (from /proc/cpuinfo):
--> unable to boot therefore impossible to get anything useful

[7.3.] Module information (from /proc/modules):
--> unable to boot therefore impossible to get anything useful

[7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)
--> unable to boot therefore impossible to get anything useful

[7.5.] PCI information ('lspci -vvv' as root)
--> unable to boot therefore impossible to get anything useful

[7.6.] SCSI information (from /proc/scsi/scsi)
--> unable to boot therefore impossible to get anything useful

[7.7.] Other information that might be relevant to the problem (please
look in /proc and include all information that you think to be relevant):
--> unable to boot therefore impossible to get anything useful

[X.] Other notes, patches, fixes, workarounds:
https://bugs.launchpad.net/bugs/1242938
