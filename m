From: Len Brown <lenb@kernel.org>
Subject: RFC - ACPI source code re-org
Date: Wed, 31 Dec 2008 05:51:50 -0500
Message-ID: <1230720725-9376-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173001pub.verizon.net ([206.46.173.1]:40372 "EHLO
	vms173001pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751452AbYLaKwI (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 31 Dec 2008 05:52:08 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

This re-org splits the kernel built-in part of ACPI
from the ACPI drivers drivers.  Within built-in, it splits
the regular GPL Linux/ACPI files from the dual-licensed
ACPICA files.  Further, the private ACPICA headers
are moved in with the ACPICA files to prevent future
temptation to go behind the public ACPICA interfaces.
 
This series sits on top of the latest ACPICA code,
and is included on the 2.6.28-based acpica branch here:

git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux-acpi-2.6.git acpica

cheers,
-Len Brown, Intel Open Source Technology Center

