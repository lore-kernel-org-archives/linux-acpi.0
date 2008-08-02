From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: Do not return true to all kind of Windows OSI calls
Date: Sat, 2 Aug 2008 20:48:43 +0100
Message-ID: <20080802194843.GA1168@srcf.ucam.org>
References: <1217632817.4610.6.camel@hidalgo> <200808021848.16457.trenn@suse.de> <20080802173146.GA31166@srcf.ucam.org> <200808021930.05643.trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:48429 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754286AbYHBTst (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 2 Aug 2008 15:48:49 -0400
Content-Disposition: inline
In-Reply-To: <200808021930.05643.trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: corsac@debian.org, ak@linux.intel.com, rui.zhang@intel.com, nokos@gmx.net, linux-acpi@vger.kernel.org, hmh@debian.org

http://www.microsoft.com/whdc/archive/_OSI-method.mspx :

"Any follow-on operating system from Microsoft that can support the 
Windows XP feature set will also return TRUE for Windows 2001. For 
example, if Microsoft released a follow-on operating system in 2003, it 
will probably be assigned a string of Windows 2003. This operating 
system would then return TRUE for the strings Windows 2001 and Windows 
2003, and it would return FALSE for all other strings."

So, no, it is not a test for Linux. Windows reports all versions, not 
just the current one.
-- 
Matthew Garrett | mjg59@srcf.ucam.org
