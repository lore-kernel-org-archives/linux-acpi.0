From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] ACPI/hpet: prevent boot hang when hpet=force used on ICH-4M
Date: Fri, 24 Apr 2009 10:49:20 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0904241048450.10096@localhost.localdomain>
References: <alpine.LFD.2.00.0904222223200.21119@localhost.localdomain>
 <alpine.LFD.2.00.0904231917030.15843@localhost.localdomain>
 <20090424063734.GA21739@elte.hu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173005pub.verizon.net ([206.46.173.5]:39511 "EHLO
	vms173005pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752793AbZDXOtg (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 24 Apr 2009 10:49:36 -0400
In-reply-to: <20090424063734.GA21739@elte.hu>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>
Cc: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org, x86@kernel.org

> > http://bugzilla.kernel.org/show_bug.cgi?id=13087
> 
> Nice fix! This moots the other half-quirk patch you wrote for hpet, 
> right?

Right.

thanks,
Len Brown, Intel Open Source Technology Center

