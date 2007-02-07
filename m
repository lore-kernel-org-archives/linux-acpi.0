From: Andrew Morton <akpm@linux-foundation.org>
Subject: Fw: [Bugme-new] [Bug 7958] New: AE_AML_PACKAGE_LIMIT is beyond end
 of object
Date: Wed, 7 Feb 2007 09:10:34 -0800
Message-ID: <20070207091034.76b76139.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.24]:55471 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161384AbXBGRKg (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 7 Feb 2007 12:10:36 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l17HAZmA010139
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO)
	for <linux-acpi@vger.kernel.org>; Wed, 7 Feb 2007 09:10:35 -0800
Received: from box (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with SMTP id l17HAYrx020017
	for <linux-acpi@vger.kernel.org>; Wed, 7 Feb 2007 09:10:34 -0800
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org


This looks like something which needs attention prior to merging the new ACPI
code?

Begin forwarded message:

Date: Wed, 7 Feb 2007 04:57:01 -0800
From: bugme-daemon@bugzilla.kernel.org
To: bugme-new@lists.osdl.org
Subject: [Bugme-new] [Bug 7958] New: AE_AML_PACKAGE_LIMIT is beyond end of object


http://bugzilla.kernel.org/show_bug.cgi?id=7958

           Summary: AE_AML_PACKAGE_LIMIT is beyond end of object
    Kernel Version: 2.6.20-rc6-mm3
            Status: NEW
          Severity: normal
             Owner: acpi_acpica-core@kernel-bugs.osdl.org
         Submitter: jirislaby@gmail.com


This occured in dmesg after hw suspend and resume:
Suspending device 0.0
ACPI Exception (exoparg2-0442): AE_AML_PACKAGE_LIMIT, Index (000000007) is beyon
d end of object [20070126]
ACPI Error (psparse-0537): Method parse/execution failed [\_SB_.PCI0.IDE0.GTM_]
(Node dfe64fcc), AE_AML_PACKAGE_LIMIT
ACPI Error (psparse-0537): Method parse/execution failed [\_SB_.PCI0.IDE0.CHN0._
GTM] (Node dfe649f0), AE_AML_PACKAGE_LIMIT
...
RESUME
...
hda: selected mode 0x45
ACPI Error (dsopcode-0481): Attempt to CreateField of length zero [20070126]
ACPI Error (psparse-0537): Method parse/execution failed [\_SB_.PCI0.IDE0.RATA]
(Node dfe64ec8), AE_AML_OPERAND_VALUE
ACPI Error (psparse-0537): Method parse/execution failed [\_SB_.PCI0.IDE0.CHN0.D
RV1._GTF] (Node dfe64964), AE_AML_OPERAND_VALUE
do_drive_get_GTF: Run _GTF error: status = 0x3006

------- You are receiving this mail because: -------
You are on the CC list for the bug, or are watching someone who is.
