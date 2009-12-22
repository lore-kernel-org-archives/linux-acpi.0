From: Len Brown <lenb@kernel.org>
Subject: Re: [patch 1/9] arch/x86/kernel/cpu/cpufreq/acpi-cpufreq.c: avoid
 cross-CPU interrupts by using smp_call_function_any()
Date: Tue, 22 Dec 2009 15:14:11 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0912221514080.5153@localhost.localdomain>
References: <200912220019.nBM0Jwbq004738@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173007pub.verizon.net ([206.46.173.7]:60221 "EHLO
	vms173007pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751894AbZLVUOd (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 22 Dec 2009 15:14:33 -0500
Received: from localhost.localdomain ([74.104.151.18])
 by vms173007.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KV200HVXLJQIK12@vms173007.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Tue, 22 Dec 2009 14:14:20 -0600 (CST)
In-reply-to: <200912220019.nBM0Jwbq004738@imap1.linux-foundation.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: akpm@linux-foundation.org
Cc: linux-acpi@vger.kernel.org, davej@redhat.com, efault@gmx.de, jaswinder@kernel.org, len.brown@intel.com, mingo@elte.hu, rusty@rustcorp.com.au, tglx@linutronix.de, venkatesh.pallipadi@intel.com, yakui.zhao@intel.com, yanmin_zhang@linux.intel.com

applied

thanks,
Len Brown, Intel Open Source Technology Center

