From: "Brown, Len" <len.brown@intel.com>
Subject: RE: [patch 16/16] acpi: suppress power button event on S3 resume
Date: Sun, 14 May 2006 00:32:58 -0400
Message-ID: <CFF307C98FEABE47A452B27C06B85BB670F33F@hdsmsx411.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:10102 "EHLO
	orsmga101-1.jf.intel.com") by vger.kernel.org with ESMTP
	id S1750706AbWENEdE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 14 May 2006 00:33:04 -0400
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: sergio@sergiomb.no-ip.org, akpm@osdl.org
Cc: linux-acpi@vger.kernel.org, apatard@mandriva.com, "Yu, Luming" <luming.yu@intel.com>

>ok here it goes the state of applying this 16 patches against
2.6.17-rc4

heh, want a job?:-)

Although Andrew publishes the patches as they apply cleanly in the -mm
series,
I actually do exactly what you tried -- I generally apply the patches to
branches
based directly on Linus' tree rather than on top of sometimes unrelated
patches
that are also in my tree.  Then I pick what branches are ready to go and
merge them into a "test" branch for Andrew, and into a "release" branch
for Linus.

For patches with no dependencies, this allows them to "pass" each other
depending on urgency, test soak time etc.  For patches that have
conflicts,
this burns a lot of my time merging to pull the patches into "test" for
-mm
and then I repeat the same merge again to pull into "release" (no, Linus
doesn't want the test history in his "clean" history)  As ACPI didn't
go into 2.6.17, we are (what I consider) an uncomfortable distance away
from Linus' tree right now, and I'm looking forward to 2.6.18 opening
when we should be able to fix that.

thanks,
-Len
