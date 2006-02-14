From: "Yu, Luming" <luming.yu@intel.com>
Subject: RE: Compaq X1050 multiple suspend problems (ACPI, PS2)
Date: Tue, 14 Feb 2006 13:47:26 +0800
Message-ID: <3ACA40606221794F80A5670F0AF15F840AEE20B9@pdsmsx403>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fmr20.intel.com ([134.134.136.19]:35475 "EHLO
	orsfmr005.jf.intel.com") by vger.kernel.org with ESMTP
	id S1030296AbWBNFr5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 14 Feb 2006 00:47:57 -0500
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Robert Hancock <hancockr@shaw.ca>
Cc: Andrew Morton <akpm@osdl.org>, linux-acpi@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>

>
>I have not seen any ACPI errors other than during suspend/resume.
>
>Tried ec_intr=0 option on the command line, same problem.
>
>ACPI_EC_DELAY=100 patch did not help either, same or at least similar 
>problem. Output attached.
>

Please try boot with lapic. I'm NOT sure if it is irq related resume
issue.
After resume, please try cat /proc/acpi/embedded_controller/*/info.
Please test if it do the trick.

If still not, please file a bug in ACPI category on bugzilla.kernel.org.


Thanks,
Luming
