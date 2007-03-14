From: Andrew Morton <akpm@linux-foundation.org>
Subject: Fw: [Bugme-new] [Bug 8193] New: Asus Notebooks only have full power
 off the dc
Date: Tue, 13 Mar 2007 17:19:00 -0800
Message-ID: <20070313171900.a660dc64.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.24]:46621 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752665AbXCNATE (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 13 Mar 2007 20:19:04 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l2E0J2Ob011531
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO)
	for <linux-acpi@vger.kernel.org>; Tue, 13 Mar 2007 17:19:02 -0700
Received: from sony (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with SMTP id l2E0J1kg013613
	for <linux-acpi@vger.kernel.org>; Tue, 13 Mar 2007 16:19:02 -0800
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org


Guys, is this an acpi thing?

Begin forwarded message:

Date: Tue, 13 Mar 2007 11:01:12 -0700
From: bugme-daemon@bugzilla.kernel.org
To: bugme-new@lists.osdl.org
Subject: [Bugme-new] [Bug 8193] New: Asus Notebooks only have full power off the dc


http://bugzilla.kernel.org/show_bug.cgi?id=8193

           Summary: Asus Notebooks only have full power off the dc
    Kernel Version: 2.6.20-2 (but in all kernel releases)
            Status: NEW
          Severity: high
             Owner: power-management_other@kernel-bugs.osdl.org
         Submitter: mustermaxi@gmail.com


Most recent kernel where this bug did *NOT* occur: there's no kernel without 
this bug
Distribution: openSUSE 10.2, mandriva 2007
Hardware Environment: Asus Z9252Va, but this affects most Asus Notebooks (and 
some others (sony vaio)
Software Environment:
Problem Description: The notebooks are really slow when they are plugged in. 
When they're running on battery there's no problem with performance... but when 
you plug them in again the performance decreases rapidly... we've found a 
solution on the linux-club forum: 
http://www.linux-club.de/viewtopic.php?p=456891#456891  
the failure is because of the smp kernel which is integrated into the kernel, 
and so the notebooks choose a false mode for it.. when you deactivate smp in 
the kernel and compile it new the problem is solved.. so maybe there's a 
possibility to detect whether it's an asus notebook and therefore deactivate 
smp.
Steps to reproduce: everytime (during boot, work, simply everytime)

------- You are receiving this mail because: -------
You are on the CC list for the bug, or are watching someone who is.
