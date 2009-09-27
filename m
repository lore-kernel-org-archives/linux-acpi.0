From: Lin Ming <ming.m.lin@intel.com>
Subject: Re: [git pull request] ACPI & driver patches for Linux-2.6.32-rc0
Date: Sun, 27 Sep 2009 09:55:03 +0800
Message-ID: <1254016503.17697.21.camel@minggr.sh.intel.com>
References: <alpine.LFD.2.00.0909190237560.22030@localhost.localdomain>
	 <4ABCB2CA.4020709@mandriva.org>
	 <d3f22a0909261902o5e48c2a0lab56fca21edf8c5b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:59916 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753151AbZI0CEh (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 26 Sep 2009 22:04:37 -0400
In-Reply-To: <d3f22a0909261902o5e48c2a0lab56fca21edf8c5b@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Backlund <tmb@mandriva.org>
Cc: Len Brown <lenb@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org


> 
> This gets my laptop flooding logs with:

Hi, 

Could you do a bisect?

Thanks
Lin Ming

> 
> > ACPI Exception: AE_TIME, Returned by Handler for [EmbeddedControl] (20090903/evregion-424)
> > ACPI Error (psparse-0537): Method parse/execution failed [\_SB_.PCI0.LPCB.EC0_.GBST] (Node ffff88013f81c5e0), AE_TIME
> > ACPI Error (psparse-0537): Method parse/execution failed [\_SB_.PCI0.LPCB.EC0_.BAT0._BST] (Node ffff88013f81c720), AE_TIME
> > ACPI Exception: AE_TIME, Evaluating _BST (20090903/battery-393)
> > ACPI Exception: AE_TIME, Returned by Handler for [EmbeddedControl] (20090903/evregion-424)
> > ACPI Error (psparse-0537): Method parse/execution failed [\_SB_.PCI0.LPCB.EC0_.GBST] (Node ffff88013f81c5e0), AE_TIME
> > ACPI Error (psparse-0537): Method parse/execution failed [\_SB_.PCI0.LPCB.EC0_.BAT0._BST] (Node ffff88013f81c720), AE_TIME
> > ACPI Exception: AE_TIME, Evaluating _BST (20090903/battery-393)
> > ACPI Exception: AE_TIME, Returned by Handler for [EmbeddedControl] (20090903/evregion-424)
> > ACPI Error (psparse-0537): Method parse/execution failed [\_SB_.PCI0.LPCB.EC0_.GBST] (Node ffff88013f81c5e0), AE_TIME
> > ACPI Error (psparse-0537): Method parse/execution failed [\_SB_.PCI0.LPCB.EC0_.BAT0._BST] (Node ffff88013f81c720), AE_TIME
> > ACPI Exception: AE_TIME, Evaluating _BST (20090903/battery-393)
> > ACPI Exception: AE_TIME, Returned by Handler for [EmbeddedControl] (20090903/evregion-424)
> > ACPI Error (psparse-0537): Method parse/execution failed [\_SB_.PCI0.LPCB.EC0_.GBST] (Node ffff88013f81c5e0), AE_TIME
> > ACPI Error (psparse-0537): Method parse/execution failed [\_SB_.PCI0.LPCB.EC0_.BAT0._BST] (Node ffff88013f81c720), AE_TIME
> > ACPI Exception: AE_TIME, Evaluating _BST (20090903/battery-393)
> > ACPI Exception: AE_TIME, Returned by Handler for [EmbeddedControl] (20090903/evregion-424)
> > ACPI Error (psparse-0537): Method parse/execution failed [\_SB_.PCI0.LPCB.EC0_.GBST] (Node ffff88013f81c5e0), AE_TIME
> > ACPI Error (psparse-0537): Method parse/execution failed [\_SB_.PCI0.LPCB.EC0_.BAT0._BST] (Node ffff88013f81c720), AE_TIME
> > ACPI Exception: AE_TIME, Evaluating _BST (20090903/battery-393)
> > ACPI Exception: AE_TIME, Returned by Handler for [EmbeddedControl] (20090903/evregion-424)
> > ACPI Error (psparse-0537): Method parse/execution failed [\_SB_.PCI0.LPCB.EC0_.GBST] (Node ffff88013f81c5e0), AE_TIME
> > ACPI Error (psparse-0537): Method parse/execution failed [\_SB_.PCI0.LPCB.EC0_.BAT0._BST] (Node ffff88013f81c720), AE_TIME
> > ACPI Exception: AE_TIME, Evaluating _BST (20090903/battery-393)
> > ACPI Exception: AE_TIME, Returned by Handler for [EmbeddedControl] (20090903/evregion-424)
> > ACPI Error (psparse-0537): Method parse/execution failed [\_SB_.PCI0.LPCB.EC0_.GBST] (Node ffff88013f81c5e0), AE_TIME
> > ACPI Error (psparse-0537): Method parse/execution failed [\_SB_.PCI0.LPCB.EC0_.BAT0._BST] (Node ffff88013f81c720), AE_TIME
> > ACPI Exception: AE_TIME, Evaluating _BST (20090903/battery-393)
> 
> --
> Thomas
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

