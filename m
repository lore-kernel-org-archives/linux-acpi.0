From: Ingo Molnar <mingo@elte.hu>
Subject: Re: Run-time PM idea (was: Re: [linux-pm] [RFC][PATCH 0/2] PM:
	Rearrange core suspend code)
Date: Mon, 8 Jun 2009 17:06:03 +0200
Message-ID: <20090608150603.GB20905@elte.hu>
References: <Pine.LNX.4.44L0.0906071651060.25203-100000@netrider.rowland.org> <20090608131159.GA15100@srcf.ucam.org> <20090608132235.GC13214@elte.hu> <200906081539.20459.oliver@neukum.org> <20090608142154.GD14234@elte.hu> <20090608143023.GA16752@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx3.mail.elte.hu ([157.181.1.138]:38317 "EHLO mx3.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752063AbZFHPG0 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 8 Jun 2009 11:06:26 -0400
Content-Disposition: inline
In-Reply-To: <20090608143023.GA16752@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Oliver Neukum <oliver@neukum.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, Alan Stern <stern@rowland.harvard.edu>, pm list <linux-pm@lists.linux-foundation.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Magnus Damm <magnus.damm@gmail.com>


* Matthew Garrett <mjg59@srcf.ucam.org> wrote:

> On Mon, Jun 08, 2009 at 04:21:54PM +0200, Ingo Molnar wrote:
> 
> > The kernel _needs_ to have precise information about whether a piece 
> > of hardware is in use or not.
> 
> The kernel can only have that information if userspace tells it. 
> What we're quibbling over is whether the kernel should be 
> explicitly told about the requirement (ie, every time an app makes 
> a key grab in X the kernel gets told about it) or whether it 
> should be implicit (userspace knows that a key grab has been made 
> and so requests that the keyboard not be suspended).
> 
> We *can* put all of that complexity in the kernel. The question is 
> whether it buys us anything. We'd have to modify huge chunks of 
> userspace and in the process we'd end up limited to whatever 
> policy happens to exist in the version of the kernel the user is 
> running.
> 
> I'd like the kernel to expose this functionality but leave the 
> policy decisions to userland.

The thing is, suspending something that is being used and relied on 
by an app is a _bug_. This is rather fundamental: hardware state and 
usage tracking is _NOT POLICY_.

Having a global override of "dont ever suspend anything here, 
because i say so" _is_ policy.

Providing _essential_ functionality to not suspend a keyboard while 
an app relies on it is _NOT_ policy.

I will even buy the argument that most current hardware cannot be 
auto-suspended safely.

But if you think that tracking the usage state of the hardware is 
'complexity', then you very much dont know what you are talking 
about. The main task of the kernel is to track hardware usage and to 
abstract away the fact that the same hardware is used by multiple 
tasks, and to do it safely. It's what the kernel does all day.

	Ingo
