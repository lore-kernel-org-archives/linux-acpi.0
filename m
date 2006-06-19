From: k.healy@student.ucc.ie
Subject: Power management support for the Nvidia Nforce2 AGP controller
Date: Mon, 19 Jun 2006 18:56:46 GMT
Message-ID: <4496f36e.bb.57e9.471125523@student.ucc.ie>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail4.ucc.ie ([143.239.1.34]:45525 "EHLO mail4.ucc.ie")
	by vger.kernel.org with ESMTP id S964850AbWFSS61 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Mon, 19 Jun 2006 14:58:27 -0400
Received: from student.ucc.ie (stu2.ucc.ie [143.239.1.40])
	by mail4.ucc.ie (8.13.6/8.13.6) with ESMTP id k5JIwLoT004368
	for <linux-acpi@vger.kernel.org>; Mon, 19 Jun 2006 19:58:26 +0100
Received: from student.ucc.ie (unverified [127.0.0.1])
	by student.ucc.ie (SurgeMail 3.7c) with ESMTP id 182347
	for <linux-acpi@vger.kernel.org>; Mon, 19 Jun 2006 19:56:46 +0100
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hello,

Hopefully this is the right place to post this (if not, let
me know)

While troubleshooting a suspend/resume problem, I found
(courtesy of some of the Nvidia support people), that the
kernel's nforce agpgart driver (see
http://www.kernelhq.cc/browse.py?css=taichi&version=600)
does not include any power management support.

Could anyone advise on what would be necessary to add this
support, and possibly suggest a starting point - e.g. is
there an implementation for another chipset that would be a
good reference?

Best regards,
Ken

