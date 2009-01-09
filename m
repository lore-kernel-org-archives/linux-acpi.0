From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] : ACPI : Use RSDT instead of XSDT by adding boot option of
 "acpi=rsdt"
Date: Fri, 09 Jan 2009 05:59:28 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0901090556360.4091@localhost.localdomain>
References: <20081031184233.8588.42241.stgit@thinkpad>
 <1229504118.3991.63.camel@yakui_zhao.sh.intel.com>
 <alpine.LFD.2.00.0901090135300.4091@localhost.localdomain>
 <200901091154.43606.trenn@suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms046pub.verizon.net ([206.46.252.46]:46672 "EHLO
	vms046pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752479AbZAIK7c (ORCPT
	<rfc822;Linux-acpi@vger.kernel.org>); Fri, 9 Jan 2009 05:59:32 -0500
Received: from localhost.localdomain ([96.237.168.40])
 by vms046.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01 (built Apr
 3 2006)) with ESMTPA id <0KD7000YCAJ6Q6ID@vms046.mailsrvcs.net> for
 Linux-acpi@vger.kernel.org; Fri, 09 Jan 2009 04:59:31 -0600 (CST)
In-reply-to: <200901091154.43606.trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: Zhao Yakui <yakui.zhao@intel.com>, "Linux-acpi@vger.kernel.org" <Linux-acpi@vger.kernel.org>, me@markdoughty.co.uk, ibm-acpi-devel@lists.sourceforge.net



> > >    In such case the boot option of "acpi=rsdt" is provided so that
> > > RSDT is tried instead of XSDT table when the system can't work well.
> 
> Great, now we still need a dmi blacklist with machines which are known
> broken. Then we are at the patchset I posted about a year ago -> scnr.
> 
> I am going to post the missing two patches to make R40e and R50e work.

please do not.

this option is just for manual debugging.
as i wrote when i nacked your original series,
the object should be to figure out which path to take w/o using dmi.

thanks,
-Len

