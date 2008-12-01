From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 1/2] drivers/misc/Makefile, Kconfig: cleanup
Date: Mon, 01 Dec 2008 14:23:11 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0812011421140.3197@localhost.localdomain>
References: <4930307C.30106@oracle.com>
 <20081129083550.3c23af37.sfr@canb.auug.org.au>
 <alpine.LFD.2.00.0811281649001.24773@localhost.localdomain>
 <alpine.LFD.2.00.0811281702570.24773@localhost.localdomain>
 <alpine.LFD.2.00.0811281706540.24773@localhost.localdomain>
 <20081128223533.GA5175@uranus.ravnborg.org>
 <alpine.LFD.2.00.0811281801520.24773@localhost.localdomain>
 <20081129073816.GB8351@uranus.ravnborg.org>
 <alpine.LFD.2.00.0812010053100.3314@localhost.localdomain>
 <alpine.LFD.2.00.0812010102340.3314@localhost.localdomain>
 <20081201074148.GA22463@uranus.ravnborg.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms044pub.verizon.net ([206.46.252.44]:35677 "EHLO
	vms044pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752234AbYLATXQ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 1 Dec 2008 14:23:16 -0500
In-reply-to: <20081201074148.GA22463@uranus.ravnborg.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Len Brown <len.brown@intel.com>, linux-next@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Randy Dunlap <randy.dunlap@oracle.com>, x86@kernel.org, linux-acpi@vger.kernel.org


> >  #
> > -obj- := misc.o	# Dummy rule to force built-in.o to be made
> > -
> > -obj-$(CONFIG_IBM_ASM)		+= ibmasm/
>  ^^

thanks for spotting that typo.
Looks like I lost the fight with vim's stupid feature
of adding a '#' to a blank line and deleted a line of code, sigh...
--
-Len Brown
Intel Open Source Technology Center

