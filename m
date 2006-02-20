From: Andrew Morton <akpm@osdl.org>
Subject: Fw: [Bugme-new] [Bug 6111] New: Acpi defunct -- buttons, battery
Date: Mon, 20 Feb 2006 13:41:38 -0800
Message-ID: <20060220134138.69f6ecaf.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.4]:15830 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932674AbWBTVnQ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Mon, 20 Feb 2006 16:43:16 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k1KLhDDZ010109
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO)
	for <linux-acpi@vger.kernel.org>; Mon, 20 Feb 2006 13:43:13 -0800
Received: from bix (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with SMTP id k1KLhC01017323
	for <linux-acpi@vger.kernel.org>; Mon, 20 Feb 2006 13:43:12 -0800
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org


The ec-burst thing seems to be causing quite a lot of problems out there.
Is there something we can do for 2.6.16?

Begin forwarded message:

Date: Mon, 20 Feb 2006 12:58:09 -0800
From: bugme-daemon@bugzilla.kernel.org
To: bugme-new@lists.osdl.org
Subject: [Bugme-new] [Bug 6111] New: Acpi defunct -- buttons, battery


http://bugzilla.kernel.org/show_bug.cgi?id=6111

           Summary: Acpi defunct -- buttons, battery
    Kernel Version: 2.6.16-rc4
            Status: NEW
          Severity: normal
             Owner: acpi_config-other@kernel-bugs.osdl.org
         Submitter: xslaby@fi.muni.cz


Most recent kernel where this bug did not occur: 2.6.12?
Distribution: FC5 test2

Hardware Environment:
asus m6r laptop

Software Environment:
asus acpi specifics enabled in kernel

Problem Description:
Acpi says no matter what is enabled/disabled from ec_intr and noapic:
ACPI: write EC, IB not empty
ACPI: write EC, IB not empty
ACPI: write EC, IB not empty
ACPI Exception (evregion-0409): AE_TIME, Returned by Handler for
[EmbeddedControl] [20060127]
ACPI Error (psparse-0517): Method parse/execution failed
[\_SB_.PCI0.SBRG.EC0_.RDC3] (Node ddf13fa8), AE_TIME
ACPI Error (psparse-0517): Method parse/execution failed [\ECIO] (Node
ddf13628), AE_TIME
ACPI Error (psparse-0517): Method parse/execution failed
[\_SB_.PCI0.SBRG.EC0_.ACPS] (Node ddf11228), AE_TIME
ACPI Error (psparse-0517): Method parse/execution failed [\ACPS] (Node
ddf0b368), AE_TIME
ACPI Error (psparse-0517): Method parse/execution failed [\_SB_.PCI0.AC0_._PSR]
(Node ddf10228), AE_TIME
 acpi_ac-0095 [10] ac_get_state          : Error reading AC Adapter state

Steps to reproduce:
simply boot

Problems were solved by using ec_burst and patch from bug 4980 before -rc2.

------- You are receiving this mail because: -------
You are on the CC list for the bug, or are watching someone who is.
