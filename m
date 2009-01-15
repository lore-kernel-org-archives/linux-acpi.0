From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [2.6.28] Kernel panic after closing lid on HP 2510p
Date: Wed, 14 Jan 2009 18:15:42 -0800
Message-ID: <20090114181542.34614acf.akpm@linux-foundation.org>
References: <200901121356.46236.elendil@planet.nl>
	<20090113123056.GA2464@deprecation.cyrius.com>
	<20090114162603.c632d82e.akpm@linux-foundation.org>
	<20090115020311.GA18740@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:56895 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752485AbZAOCQH (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Wed, 14 Jan 2009 21:16:07 -0500
In-Reply-To: <20090115020311.GA18740@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Martin Michlmayr <tbm@cyrius.com>, elendil@planet.nl, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

On Thu, 15 Jan 2009 02:03:11 +0000 Matthew Garrett <mjg59@srcf.ucam.org> wrote:

> On Wed, Jan 14, 2009 at 04:26:03PM -0800, Andrew Morton wrote:
> 
> > It'd be a very special BIOS bug if it can reach out and make the kernel
> > oops.
> 
> Lid actions typically trigger SMI code, so it's entirely capable of 
> destroying CPU state in such a way that the kernel falls over (and 
> probably even in ways that cause the kernel to turn green, emit pleasing 
> warbling noises or invade neighbouring pieces of hardware). In this case 
> it seems to be SMP specific - the system's entirely stable in UP mode. 
> It's greatly vexing.

Does it always crash in the same way?

If so, we can put crash-avoidance code at the offending callsite and
back out gracefully?

