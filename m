From: Manish <manishmj1111@gmail.com>
Subject: WHEA Support in Linux
Date: Wed, 27 Feb 2013 18:57:41 +0000 (UTC)
Message-ID: <loom.20130227T195552-853@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:46953 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756742Ab3B0S55 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 27 Feb 2013 13:57:57 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glad-acpi-devel@m.gmane.org>)
	id 1UAmCm-00082p-L5
	for linux-acpi@vger.kernel.org; Wed, 27 Feb 2013 19:58:16 +0100
Received: from 180.215.38.193 ([180.215.38.193])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-acpi@vger.kernel.org>; Wed, 27 Feb 2013 19:58:16 +0100
Received: from manishmj1111 by 180.215.38.193 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-acpi@vger.kernel.org>; Wed, 27 Feb 2013 19:58:16 +0100
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org






On Wed, Feb 27, 2013 at 8:02 AM, Chen Gong <gong.chen@linux.intel.com> wrote:

    On Tue, Feb 26, 2013 at 04:40:37AM +0000, Manish wrote:
    > Date: Tue, 26 Feb 2013 04:40:37 +0000 (UTC)
    > From: Manish <manishmj1111@gmail.com>
    > To: linux-acpi@vger.kernel.org
    > Subject: WHEA Support in Linux
    > User-Agent: Loom/3.14 (http://gmane.org/)
    >
    > Can anyone please help me with details regarding the support for WHEA (Windows
    > Hardware Error Architecture) in Linux.
    > WHEA is supported in ACPI 5.0 specification.
    Linux since 3.1(in fact, earlier than it in different style) has supported
    WHEA.
    >
    > I'm getting the following message in dmesg log from RHEL:
    > "ERST: Could not register with persistent Store"
    >
    You don't compile pstore support/not loaded it as a module/no NVRAM, UEFI
    runtime space etc. to support pstore.

    > Can anyone please let me know the scenarios in which this message comes.
    >
    > Thanks,
    > Manish.
    >
    >
    >
    > --
    > To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
    > the body of a message to majordomo@vger.kernel.org
    > More majordomo info at  http://vger.kernel.org/majordomo-info.html 


Thanks a lot for your quick response.

How can we verify that a particular version of Linux supports WHEA or not?
In Windows, OSC method returns supported for the Whea Guid. Is it applicable
also for Linux?
Also, In Windows, Error Injection is verifed using WHEA HCT tool and the Errors
are logged in Windows Event Viewer.
Is there any such facility/tool available to verify Error Injection (EINJ) stack
in Linux?
Also, Is there any thing similar to Event Viewer of Windows in Linux where the
WHEA errors are logged?

(I'm getting the following message in dmesg log from RHEL:
"ERST: Could not register with persistent Store"

You don't compile pstore support/not loaded it as a module/no NVRAM, UEFI
runtime space etc. to support pstore.)

As far as the above ERST dmesg is concerned, We are allocating a Flash Block for
ERST persistent store.
The persistent store will be used for Writing/Reading an Error Record by the OS
in case of NMI when fatal error is generated.
In case of fatal error from Windows, it is getting written as well as Read
correctly from the persistent store and error is avialable in Event Viewer.
Can you please help us to narrow down this issue or in what could be reason for
this error in dmesg log.

Regards,
Manish.

