From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: Fwd: Re: 2.6.27-rc1 oops on boot -- cs423x? (Corrected subject)
Date: Wed, 30 Jul 2008 10:46:59 -0600
Message-ID: <200807301046.59434.bjorn.helgaas@hp.com>
References: <200807300839.18425.bjorn.helgaas@hp.com> <20080730164044.GM23938@one.firstfloor.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g4t0017.houston.hp.com ([15.201.24.20]:44808 "EHLO
	g4t0017.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752003AbYG3QrQ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 30 Jul 2008 12:47:16 -0400
In-Reply-To: <20080730164044.GM23938@one.firstfloor.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andi Kleen <andi@firstfloor.org>
Cc: linux-acpi@vger.kernel.org

On Wednesday 30 July 2008 10:40:44 am Andi Kleen wrote:
> On Wed, Jul 30, 2008 at 08:39:18AM -0600, Bjorn Helgaas wrote:
> > Hi Andi,
> > 
> > Can you put the patch below in your acpi tree?  It fixes an issue
> > in 2.6.27-rc1 (URL below).  Thanks.
> 
> Does that actually fix an oops or is it just a cosmetic problem?

We hit the WARN_ON here:

  WARNING: at lib/vsprintf.c:609 vsnprintf+0x6c7/0x6d0()

which causes an alarming backtrace.  The patch keeps us from hitting
the WARN_ON, but let me look into it a bit more.  I don't understand
how we hit it in the first place -- looks like we'd have to pass
in a negative size, and I haven't figured out how even the unpatched
code would do that.

Bjorn
