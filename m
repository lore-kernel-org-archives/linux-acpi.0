From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: Do not return true to all kind of Windows OSI calls
Date: Sun, 3 Aug 2008 01:43:53 -0300
Message-ID: <20080803044353.GE6053@khazad-dum.debian.net>
References: <1217632817.4610.6.camel@hidalgo> <200808021848.16457.trenn@suse.de> <20080802173146.GA31166@srcf.ucam.org> <200808021930.05643.trenn@suse.de> <20080802194843.GA1168@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:51433 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751241AbYHCEoC (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 3 Aug 2008 00:44:02 -0400
Content-Disposition: inline
In-Reply-To: <20080802194843.GA1168@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Thomas Renninger <trenn@suse.de>, corsac@debian.org, ak@linux.intel.com, rui.zhang@intel.com, nokos@gmx.net, linux-acpi@vger.kernel.org

On Sat, 02 Aug 2008, Matthew Garrett wrote:
> http://www.microsoft.com/whdc/archive/_OSI-method.mspx :
> 
> "Any follow-on operating system from Microsoft that can support the 
> Windows XP feature set will also return TRUE for Windows 2001. For 
> example, if Microsoft released a follow-on operating system in 2003, it 
> will probably be assigned a string of Windows 2003. This operating 
> system would then return TRUE for the strings Windows 2001 and Windows 
> 2003, and it would return FALSE for all other strings."
> 
> So, no, it is not a test for Linux. Windows reports all versions, not 
> just the current one.

I'd be careful with that "all versions".  The text only says XP onwards. We
claim OSI strings older than XP along with XP's and newer ones.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
