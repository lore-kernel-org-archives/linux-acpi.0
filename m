From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 07/21] ACPI EC: Fix regression due to use of uninitialized
 variable
Date: Fri, 07 Nov 2008 14:45:50 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0811071445140.8189@localhost.localdomain>
References: <2830c9fb8e66cee70b8bffdfb0de01c144c7e643.1226032677.git.len.brown@intel.com>
 <29086e19e9149aadd17ece7112d7d2cf3a8b82f3.1226032677.git.len.brown@intel.com>
 <1226038422.3989.244.camel@yakui_zhao.sh.intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173005pub.verizon.net ([206.46.173.5]:33965 "EHLO
	vms173005pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751400AbYKGTpy (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 7 Nov 2008 14:45:54 -0500
Received: from localhost.localdomain ([96.237.168.40])
 by vms173005.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0K9Z00EVCAWFW651@vms173005.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 07 Nov 2008 13:45:52 -0600 (CST)
In-reply-to: <1226038422.3989.244.camel@yakui_zhao.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhao Yakui <yakui.zhao@intel.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Alexey Starikovskiy <astarikovskiy@suse.de>



> > From: Alexey Starikovskiy <astarikovskiy@suse.de>
> > 
> > breakage introduced by following patch
> > commit 27663c5855b10af9ec67bc7dfba001426ba21222
> > Author: Matthew Wilcox <willy@linux.intel.com>
> > Date:   Fri Oct 10 02:22:59 2008 -0400
> > 
> > acpi_evaluate_integer() does not clear passed variable if
> > there is an error at evaluation.
> > So if we ignore error, we must supply initialized variable.
> > 
> > References: http://bugzilla.kernel.org/show_bug.cgi?id=11917
> > 	    http://bugzilla.kernel.org/show_bug.cgi?id=11896
> The bug references for 11896 should be deleted.
>     The bug for 11896 can't be resolved by this patch.
> Thanks.

amended.

thanks,
-Len

