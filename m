From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: Run-time PM idea (was: Re: [linux-pm] [RFC][PATCH 0/2] PM:
	Rearrange core suspend code)
Date: Mon, 8 Jun 2009 14:11:59 +0100
Message-ID: <20090608131159.GA15100@srcf.ucam.org>
References: <Pine.LNX.4.44L0.0906071651060.25203-100000@netrider.rowland.org> <200906072347.00580.rjw@sisk.pl> <20090608065419.GA13568@elte.hu> <200906081330.50045.rjw@sisk.pl> <20090608130509.GA3272@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:52494 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753419AbZFHNMZ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 8 Jun 2009 09:12:25 -0400
Content-Disposition: inline
In-Reply-To: <20090608130509.GA3272@elte.hu>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Alan Stern <stern@rowland.harvard.edu>, pm list <linux-pm@lists.linux-foundation.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Magnus Damm <magnus.damm@gmail.com>

On Mon, Jun 08, 2009 at 03:05:09PM +0200, Ingo Molnar wrote:
> 
> * Rafael J. Wysocki <rjw@sisk.pl> wrote:
> > Well, we've been discussing it for quite a while and since more 
> > and more people are interested, I'm giving it a high priority.
> 
> Cool. I think that if within a few years we could achieve that every 
> default distro (both on desktops and on servers) triggers PM 
> functionality runtime on common hardware, we'd both have lower power 
> consumption in general, and we'd have more robust suspend-resume 
> code as well.

The difficulty is in determining when it's viable to autosuspend a given 
device. There's a limit to how much we can determine purely from kernel 
state (for instance, we could suspend ahci when there's no pending disk 
access, but we'd lose hotplug notifications) so there's going to have to 
be some level of userspace policy determination. Having the 
infrastructure in the kernel is an important part of this, but there'll 
be some distance to go after that.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
