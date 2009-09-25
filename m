From: Thomas Backlund <tmb@mandriva.org>
Subject: Re: [git pull request] ACPI & driver patches for Linux-2.6.32-rc0
Date: Fri, 25 Sep 2009 15:08:42 +0300
Message-ID: <4ABCB2CA.4020709@mandriva.org>
References: <alpine.LFD.2.00.0909190237560.22030@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-7; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mbox2.netikka.net ([213.250.81.203]:35432 "EHLO
	mbox2.netikka.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752374AbZIYMhp (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 25 Sep 2009 08:37:45 -0400
In-Reply-To: <alpine.LFD.2.00.0909190237560.22030@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org

Len Brown wrote:
> Hi Linus,
> 
> please pull from: 
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux-acpi-2.6.git release
> 
> Two new drivers, bring the ACPICA core up to date with ACPI 4.0,
> and a bunch of other stuff...
> 
> This will update the files shown below.
> 
> thanks!
> 
> --
> Len Brown
> Intel Open Source Technology Center
> 
> 
> ps. individual patches are available on linux-acpi@vger.kernel.org
> and a consolidated plain patch is available here:
> http://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/patches/2.6.31/acpi-release-20090903-2.6.31.diff.gz
> 

This gets my laptop flooding logs with:

> ACPI Exception: AE_TIME, Returned by Handler for [EmbeddedControl] (20090903/evregion-424)
> ACPI Error (psparse-0537): Method parse/execution failed [\_SB_.PCI0.LPCB.EC0_.GBST] (Node ffff88013f81c5e0), AE_TIME
> ACPI Error (psparse-0537): Method parse/execution failed [\_SB_.PCI0.LPCB.EC0_.BAT0._BST] (Node ffff88013f81c720), AE_TIME
> ACPI Exception: AE_TIME, Evaluating _BST (20090903/battery-393)
> ACPI Exception: AE_TIME, Returned by Handler for [EmbeddedControl] (20090903/evregion-424)
> ACPI Error (psparse-0537): Method parse/execution failed [\_SB_.PCI0.LPCB.EC0_.GBST] (Node ffff88013f81c5e0), AE_TIME
> ACPI Error (psparse-0537): Method parse/execution failed [\_SB_.PCI0.LPCB.EC0_.BAT0._BST] (Node ffff88013f81c720), AE_TIME
> ACPI Exception: AE_TIME, Evaluating _BST (20090903/battery-393)
> ACPI Exception: AE_TIME, Returned by Handler for [EmbeddedControl] (20090903/evregion-424)
> ACPI Error (psparse-0537): Method parse/execution failed [\_SB_.PCI0.LPCB.EC0_.GBST] (Node ffff88013f81c5e0), AE_TIME
> ACPI Error (psparse-0537): Method parse/execution failed [\_SB_.PCI0.LPCB.EC0_.BAT0._BST] (Node ffff88013f81c720), AE_TIME
> ACPI Exception: AE_TIME, Evaluating _BST (20090903/battery-393)
> ACPI Exception: AE_TIME, Returned by Handler for [EmbeddedControl] (20090903/evregion-424)
> ACPI Error (psparse-0537): Method parse/execution failed [\_SB_.PCI0.LPCB.EC0_.GBST] (Node ffff88013f81c5e0), AE_TIME
> ACPI Error (psparse-0537): Method parse/execution failed [\_SB_.PCI0.LPCB.EC0_.BAT0._BST] (Node ffff88013f81c720), AE_TIME
> ACPI Exception: AE_TIME, Evaluating _BST (20090903/battery-393)
> ACPI Exception: AE_TIME, Returned by Handler for [EmbeddedControl] (20090903/evregion-424)
> ACPI Error (psparse-0537): Method parse/execution failed [\_SB_.PCI0.LPCB.EC0_.GBST] (Node ffff88013f81c5e0), AE_TIME
> ACPI Error (psparse-0537): Method parse/execution failed [\_SB_.PCI0.LPCB.EC0_.BAT0._BST] (Node ffff88013f81c720), AE_TIME
> ACPI Exception: AE_TIME, Evaluating _BST (20090903/battery-393)
> ACPI Exception: AE_TIME, Returned by Handler for [EmbeddedControl] (20090903/evregion-424)
> ACPI Error (psparse-0537): Method parse/execution failed [\_SB_.PCI0.LPCB.EC0_.GBST] (Node ffff88013f81c5e0), AE_TIME
> ACPI Error (psparse-0537): Method parse/execution failed [\_SB_.PCI0.LPCB.EC0_.BAT0._BST] (Node ffff88013f81c720), AE_TIME
> ACPI Exception: AE_TIME, Evaluating _BST (20090903/battery-393)
> ACPI Exception: AE_TIME, Returned by Handler for [EmbeddedControl] (20090903/evregion-424)
> ACPI Error (psparse-0537): Method parse/execution failed [\_SB_.PCI0.LPCB.EC0_.GBST] (Node ffff88013f81c5e0), AE_TIME
> ACPI Error (psparse-0537): Method parse/execution failed [\_SB_.PCI0.LPCB.EC0_.BAT0._BST] (Node ffff88013f81c720), AE_TIME
> ACPI Exception: AE_TIME, Evaluating _BST (20090903/battery-393)

--
Thomas
