From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 0/4]  Disable Mwait for CPU C-states and add the boot
 option of "idle=nomwait" ,"idle=halt"
Date: Fri, 20 Jun 2008 03:28:51 -0400 (EDT)
Message-ID: <alpine.LFD.1.10.0806200327170.22284@localhost.localdomain>
References: <1213684734.19901.8.camel@yakui_zhao.sh.intel.com>
 <alpine.LFD.1.10.0806200225590.22284@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms042pub.verizon.net ([206.46.252.42]:36212 "EHLO
	vms042pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751470AbYFTH3Y (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 20 Jun 2008 03:29:24 -0400
Received: from localhost.localdomain ([72.93.254.151])
 by vms042.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01 (built Apr
 3 2006)) with ESMTPA id <0K2R00FF83G4KTT2@vms042.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 20 Jun 2008 02:28:53 -0500 (CDT)
In-reply-to: <alpine.LFD.1.10.0806200225590.22284@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhao Yakui <yakui.zhao@intel.com>
Cc: linux-acpi@vger.kernel.org


I don't like the idle=halt implementation
It causes cpuidle to not hook, and thus 
/sys/devices/system/cpu/cpu*/cpuidle/state*/* vanish

I think it should work more like processor.max_cstate=1 --
ie. everything is the same, except the upper level software
simply is limited to -- in this case -- HALT.

thanks,
-Len

