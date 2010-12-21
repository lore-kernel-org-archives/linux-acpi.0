From: Len Brown <lenb@kernel.org>
Subject: acpidump updated in pmtools
Date: Tue, 21 Dec 2010 17:39:10 -0500 (EST)
Message-ID: <alpine.LFD.2.00.1012211734280.2583@x980>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173003pub.verizon.net ([206.46.173.3]:42168 "EHLO
	vms173003pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753522Ab0LUWjO (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 21 Dec 2010 17:39:14 -0500
Received: from localhost.localdomain ([unknown] [108.7.186.163])
 by vms173003.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0LDS007UQUXC8XP1@vms173003.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Tue, 21 Dec 2010 16:39:13 -0600 (CST)
Received: from localhost.localdomain (x980 [127.0.0.1])
	by localhost.localdomain (8.14.4/8.14.4) with ESMTP id oBLMdBVm002010	for
 <linux-acpi@vger.kernel.org>; Tue, 21 Dec 2010 17:39:12 -0500
Received: from localhost (lenb@localhost)
	by localhost.localdomain (8.14.4/8.14.4/Submit) with ESMTP id oBLMdAU4001999
	for <linux-acpi@vger.kernel.org>; Tue, 21 Dec 2010 17:39:11 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

The latest version of acpidump in the pmtools package
grabs the dynamic tables, as advertised in
/sys/firmare/acpi/tables/dynamic/*

It was possible to get these before by invoking
acpidump with address and length params, but
now the common case is covered automatically,
as the tables that were loaded as of when
acpidump was run are captured.

http://userweb.kernel.org/~lenb/acpi/utils/
pmtools-20101221.tar.gz or later

Thanks to Yakui Zhao for this update.

cheers,
Len Brown, Intel Open Source Technology Center
