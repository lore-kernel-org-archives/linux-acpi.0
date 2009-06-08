From: Ray Lee <ray-lk@madrabbit.org>
Subject: Re: Run-time PM idea (was: Re: [linux-pm] [RFC][PATCH 0/2] PM:
	Rearrange core suspend code)
Date: Mon, 8 Jun 2009 09:29:34 -0700
Message-ID: <2c0942db0906080929r31e39fe5w673ed877bb5f4966@mail.gmail.com>
References: <Pine.LNX.4.44L0.0906071651060.25203-100000@netrider.rowland.org>
	<20090608131159.GA15100@srcf.ucam.org> <20090608132235.GC13214@elte.hu>
	<200906081539.20459.oliver@neukum.org> <20090608142154.GD14234@elte.hu>
	<20090608143023.GA16752@srcf.ucam.org> <20090608150603.GB20905@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from qw-out-2122.google.com ([74.125.92.24]:47784 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757331AbZFHQ3w (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 8 Jun 2009 12:29:52 -0400
In-Reply-To: <20090608150603.GB20905@elte.hu>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Oliver Neukum <oliver@neukum.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, Alan Stern <stern@rowland.harvard.edu>, pm list <linux-pm@lists.linux-foundation.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Magnus Damm <magnus.damm@gmail.com>

On Mon, Jun 8, 2009 at 8:06 AM, Ingo Molnar<mingo@elte.hu> wrote:
>
> * Matthew Garrett <mjg59@srcf.ucam.org> wrote:

>> I'd like the kernel to expose this functionality but leave the
>> policy decisions to userland.
>
> The thing is, suspending something that is being used and relied on
> by an app is a _bug_. This is rather fundamental: hardware state and
> usage tracking is _NOT POLICY_.

Yes. But, actual example time: what about the case where completely
turning off a laptop's DVD drive saves extra power, but then also
turns off kernel and userspace notification of a disc being inserted?

One of the Other OS's handles this by having a popup when the battery
gets low, asking if it's okay to turn the drive off. This is part of
what Matthew is talking about here.
