From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: Do not return true to all kind of Windows OSI calls
Date: Sun, 3 Aug 2008 07:33:11 +0100
Message-ID: <20080803063311.GA8755@srcf.ucam.org>
References: <1217632817.4610.6.camel@hidalgo> <200808021848.16457.trenn@suse.de> <20080802173146.GA31166@srcf.ucam.org> <200808021930.05643.trenn@suse.de> <20080802194843.GA1168@srcf.ucam.org> <20080803044353.GE6053@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:52676 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751628AbYHCGda (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 3 Aug 2008 02:33:30 -0400
Content-Disposition: inline
In-Reply-To: <20080803044353.GE6053@khazad-dum.debian.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: Thomas Renninger <trenn@suse.de>, corsac@debian.org, ak@linux.intel.com, rui.zhang@intel.com, nokos@gmx.net, linux-acpi@vger.kernel.org

On Sun, Aug 03, 2008 at 01:43:53AM -0300, Henrique de Moraes Holschuh wrote:
> On Sat, 02 Aug 2008, Matthew Garrett wrote:
> I'd be careful with that "all versions".  The text only says XP onwards. We
> claim OSI strings older than XP along with XP's and newer ones.

As far as I can tell, XP was the first to return OSI. Older versions of 
Windows only implemented _OS.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
