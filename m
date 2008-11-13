From: Len Brown <lenb@kernel.org>
Subject: Re: ACPICA Release 20081031 linuxized patch set
Date: Thu, 13 Nov 2008 02:31:43 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0811130230060.21141@localhost.localdomain>
References: <1226555956.30025.150.camel@minggr.sh.intel.com>
 <1226556783.30025.154.camel@minggr.sh.intel.com>
 <alpine.LFD.2.00.0811130147180.21141@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms046pub.verizon.net ([206.46.252.46]:36927 "EHLO
	vms046pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751235AbYKMHbq (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 13 Nov 2008 02:31:46 -0500
Received: from localhost.localdomain ([96.237.168.40])
 by vms046.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01 (built Apr
 3 2006)) with ESMTPA id <0KA9003DCGWXOHJ4@vms046.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Thu, 13 Nov 2008 01:31:46 -0600 (CST)
In-reply-to: <alpine.LFD.2.00.0811130147180.21141@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lin Ming <ming.m.lin@intel.com>
Cc: "Moore, Robert" <robert.moore@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, acpi <acpi@linux.intel.com>



$ git bisect bad
7a55a3d54bd8d9e712e70cf9491f649e7e472a22 is first bad commit
commit 7a55a3d54bd8d9e712e70cf9491f649e7e472a22
Author: Bob Moore <robert.moore@intel.com>
Date:   Thu Nov 13 11:08:59 2008 +0800

    ACPICA: Add Buffer->String conversion for predefined methods
    
    For predefined methods (such as _BIF), add automatic conversion for
    objects that are required to be a String, but a Buffer was found
    instead. This can happen when reading string battery data from
    an operation region, because it used to be difficult to convert
    the data from buffer to string from within the ASL. Linux BZ 11822.
    
    http://bugzilla.kernel.org/show_bug.cgi?id=11822

