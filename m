From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: [PATCH/RFC] ACPICA: disable ACPI 2.0 _GTS/_BFS support
Date: Fri, 19 Dec 2008 09:39:04 -0700
Message-ID: <200812190939.05160.bjorn.helgaas@hp.com>
References: <alpine.LFD.2.00.0812190421140.1988@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g4t0015.houston.hp.com ([15.201.24.18]:2566 "EHLO
	g4t0015.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750946AbYLSQjI (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 19 Dec 2008 11:39:08 -0500
In-Reply-To: <alpine.LFD.2.00.0812190421140.1988@localhost.localdomain>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org

On Friday 19 December 2008 02:23:49 am Len Brown wrote:
> ACPI 2.0 defined two new methods in the suspend/resume sequence,
> _GTS (Going to Sleep) and _BFS (Back from Sleep)
> 
> They are optional methods, but if the BIOS supplies them,
> the OS is supposed to evaluate them immediately before
> writing the register to sleep, and immediately after waking up --
> a time when interrupts are disabled.
> 
> ...
> Now, several years after ACPI 2.0 was released,
> we have yet to observe a single implementation of
> _GTS/_BFS in the field -- suggesting that they will
> never actually be deployed.

There are actually some HP ia64 systems that have _GTS.  All
the rx7600-, rx8600-, and Superdome-class systems I looked at
have it.  But in each case, the method is empty, so I don't
know why they even bothered to implement it.

> So lets keep Linux simple by removing this
> theoretical support for _GTS/_BFS, the only
> AML methods that mandated being evaluated
> with interrupts disabled.

Do you want to print a note that _GTS/_BFS exists, but
we're ignoring it?  If some platform comes along that
uses them, a dmesg note might help debug problems.

Bjorn
