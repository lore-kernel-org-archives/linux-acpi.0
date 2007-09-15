From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: [RFC] Notification on method execution
Date: Sat, 15 Sep 2007 21:49:23 +0100
Message-ID: <20070915204923.GA27604@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([78.32.9.130]:54444 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752493AbXIOUt3 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 15 Sep 2007 16:49:29 -0400
Received: from mjg59 by vavatch.codon.org.uk with local (Exim 4.62)
	(envelope-from <mjg59@codon.org.uk>)
	id 1IWeZv-0007BM-GI
	for linux-acpi@vger.kernel.org; Sat, 15 Sep 2007 21:49:26 +0100
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

For certain drivers (such as the Thinkpad ACPI driver[1]), it would be 
helpful to be able to get notifications when a method is executed. I'd 
propose adding a call like acpi_method_notify, extending the method 
field to contain an extra flag for notifications and a callback, having 
acpi_aml_execute check this before executing the methods and perhaps 
checking the return code to decide whether to continue executing the 
method or not (would potentially allow overriding methods, though I'm 
not convinced it's a good idea). Does this sound basically sane? If so, 
I'll do a patch.

[1] Various Thinkpads make predictable method calls when hotkeys are 
pressed, but make no notifications. Hooking into those methods would 
allow those keys to be caught without the requirement to repeatedly poll 
the hardware to see if there's been an update.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
