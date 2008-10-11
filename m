From: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
Subject: acpi-test tree on eeepc: EC error message on second resume
Date: Sat, 11 Oct 2008 17:57:48 +0100
Message-ID: <48F0DB0C.7060201@tuffmail.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.27]:2245 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753457AbYJKQ5x (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 11 Oct 2008 12:57:53 -0400
Received: by ey-out-2122.google.com with SMTP id 6so389759eyi.37
        for <linux-acpi@vger.kernel.org>; Sat, 11 Oct 2008 09:57:51 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <astarikovskiy@suse.de>
Cc: linux acpi <linux-acpi@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>

I've just run an acpi-test kernel on my EeePC and noticed a new issue. 
It seems to be caused (or revealed) by the EC interrupt transaction patch.

On the second suspend/resume cycle, I see a kernel error message.

[   78.747707] ACPI: Waking up from system sleep state S3
[   79.330001] ACPI: EC: input buffer not empty, aborting transaction
[   79.423327] ACPI: EC: non-query interrupt received, switching to
interrupt mode

I still don't see any issues in the code.  I'll try getting a DEBUG
trace to see the EC interrupts.  Any other suggestions?

Thanks
Alan
