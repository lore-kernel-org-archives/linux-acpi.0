From: Manish <manishmj1111@gmail.com>
Subject: Re: WHEA Support in Linux
Date: Wed, 27 Feb 2013 19:00:53 +0000 (UTC)
Message-ID: <loom.20130227T195852-926@post.gmane.org>
References: <loom.20130226T053540-195@post.gmane.org> <20130227023235.GB29624@gchen.bj.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:57456 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760723Ab3B0TEw (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 27 Feb 2013 14:04:52 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glad-acpi-devel@m.gmane.org>)
	id 1UAmJM-0003Fe-M8
	for linux-acpi@vger.kernel.org; Wed, 27 Feb 2013 20:05:04 +0100
Received: from 180.215.38.193 ([180.215.38.193])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-acpi@vger.kernel.org>; Wed, 27 Feb 2013 20:05:04 +0100
Received: from manishmj1111 by 180.215.38.193 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-acpi@vger.kernel.org>; Wed, 27 Feb 2013 20:05:04 +0100
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org




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


