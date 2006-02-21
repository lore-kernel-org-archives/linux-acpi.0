From: "Yu, Luming" <luming.yu@intel.com>
Subject: RE: [Bugme-new] [Bug 6111] New: Acpi defunct -- buttons, battery
Date: Tue, 21 Feb 2006 09:01:45 +0800
Message-ID: <3ACA40606221794F80A5670F0AF15F840AFD4718@pdsmsx403>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fmr17.intel.com ([134.134.136.16]:7625 "EHLO
	orsfmr002.jf.intel.com") by vger.kernel.org with ESMTP
	id S1161232AbWBUBB4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 20 Feb 2006 20:01:56 -0500
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>
Cc: linux-acpi@vger.kernel.org

	
I'm not sure this is EC caused trouble, because
the user report "Acpi says no matter what is
enabled/disabled from ec_intr and noapic: "

It looks like a regression since 2.6.12.

thanks,
luming

>The ec-burst thing seems to be causing quite a lot of problems 
>out there.
>Is there something we can do for 2.6.16?
>
>Begin forwarded message:
>
>Date: Mon, 20 Feb 2006 12:58:09 -0800
>From: bugme-daemon@bugzilla.kernel.org
>To: bugme-new@lists.osdl.org
>Subject: [Bugme-new] [Bug 6111] New: Acpi defunct -- buttons, battery
>
>
>http://bugzilla.kernel.org/show_bug.cgi?id=6111
>
>           Summary: Acpi defunct -- buttons, battery
>    Kernel Version: 2.6.16-rc4
>            Status: NEW
>          Severity: normal
>             Owner: acpi_config-other@kernel-bugs.osdl.org
>         Submitter: xslaby@fi.muni.cz
>
>
>Most recent kernel where this bug did not occur: 2.6.12?
>Distribution: FC5 test2
>
>Hardware Environment:
>asus m6r laptop
>
>Software Environment:
>asus acpi specifics enabled in kernel
>
>Problem Description:
>Acpi says no matter what is enabled/disabled from ec_intr and noapic:
>ACPI: write EC, IB not empty
>ACPI: write EC, IB not empty
>ACPI: write EC, IB not empty
>ACPI Exception (evregion-0409): AE_TIME, Returned by Handler for
>[EmbeddedControl] [20060127]
>ACPI Error (psparse-0517): Method parse/execution failed
>[\_SB_.PCI0.SBRG.EC0_.RDC3] (Node ddf13fa8), AE_TIME
>ACPI Error (psparse-0517): Method parse/execution failed [\ECIO] (Node
>ddf13628), AE_TIME
>ACPI Error (psparse-0517): Method parse/execution failed
>[\_SB_.PCI0.SBRG.EC0_.ACPS] (Node ddf11228), AE_TIME
>ACPI Error (psparse-0517): Method parse/execution failed [\ACPS] (Node
>ddf0b368), AE_TIME
>ACPI Error (psparse-0517): Method parse/execution failed 
>[\_SB_.PCI0.AC0_._PSR]
>(Node ddf10228), AE_TIME
> acpi_ac-0095 [10] ac_get_state          : Error reading AC 
>Adapter state
>
>Steps to reproduce:
>simply boot
>
>Problems were solved by using ec_burst and patch from bug 4980 
>before -rc2.
>
>------- You are receiving this mail because: -------
>You are on the CC list for the bug, or are watching someone who is.
>-
>To unsubscribe from this list: send the line "unsubscribe 
>linux-acpi" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
