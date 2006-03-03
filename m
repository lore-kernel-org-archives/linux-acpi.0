From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: ACPI resume and legacy-free IA32 EFI machines
Date: Fri, 3 Mar 2006 19:12:04 +0000
Message-ID: <20060303191204.GA31032@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([217.147.92.49]:53390 "EHLO
	vavatch.codon.org.uk") by vger.kernel.org with ESMTP
	id S1750724AbWCCTMJ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 3 Mar 2006 14:12:09 -0500
Received: from mjg59 by vavatch.codon.org.uk with local (Exim 4.52)
	id 1FFFh6-00084q-Ga
	for linux-acpi@vger.kernel.org; Fri, 03 Mar 2006 19:12:04 +0000
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

I haven't been able to find any mention of this in the ACPI spec. I have 
a legacy-free EFI machine which I've successfully suspended, but resume 
fails (I have no way of getting debug information out of it right now). 
Do EFI machines resume in the same way as traditional IA32 machines (ie, 
coming up in real mode), or is there a need for different resume code?

-- 
Matthew Garrett | mjg59@srcf.ucam.org
