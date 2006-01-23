From: Matthew William Solloway Bell <m.w.s.bell@durham.ac.uk>
Subject: Buttons not present in /proc/bus/acpi/wakeup
Date: Mon, 23 Jan 2006 15:44:13 +0000
Message-ID: <1138031053.21023.5.camel@cheerly.dur.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hermes.dur.ac.uk ([129.234.4.9]:31388 "EHLO hermes.dur.ac.uk")
	by vger.kernel.org with ESMTP id S1751478AbWAWPpV (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Mon, 23 Jan 2006 10:45:21 -0500
Received: from smtphost2.dur.ac.uk (smtphost2.dur.ac.uk [129.234.4.209])
	by hermes.dur.ac.uk (8.11.7p1+Sun/8.11.7) with ESMTP id k0NFiR311847
	for <linux-acpi@vger.kernel.org>; Mon, 23 Jan 2006 15:44:28 GMT
Received: from cheerly.dur.ac.uk (cheerly.dur.ac.uk [129.234.6.79])
	by smtphost2.dur.ac.uk (8.12.10+Sun/8.11.7) with ESMTP id k0NFiDIO005016
	for <linux-acpi@vger.kernel.org>; Mon, 23 Jan 2006 15:44:14 GMT
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hi,
I have a FSC AMILO-A 1667G laptop. I've been trying to get it to go into
S3. This has worked to the point where the BIOS recognises that it is in
sleep mode and the BIOS sleep status light flashes. However, pressing
the power button will not wake up the laptop; there is no response, not
even a brief flashing of status lights to indicate a response.
The problem seem to be related to the fact that the buttons discovered
by the ACPI button driver are not present in /proc/bus/acpi/wakeup.
Looking through the code, this would seem to be only caused by Linux
ahving some trouble handling power for the buttons (_PRW, _PSW methods,
and enabling appropriate devices).
I am using 2.6.14, and I don't really know where to go from here.

Matthew W. S. Bell

