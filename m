From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 4/4] gma500: opregion and ACPI
Date: Thu, 3 May 2012 09:56:59 +0100
Message-ID: <20120503095659.7f167155@pyramind.ukuu.org.uk>
References: <20120501133037.1682.58297.stgit@bluebook>
	<20120501133223.1682.73707.stgit@bluebook>
	<CAPM=9tw3+tz1Bd7kimQcyehhQ6UjJ=hH0M5_JGSOX5kVDncn6g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:57105 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753784Ab2ECIyP (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 3 May 2012 04:54:15 -0400
In-Reply-To: <CAPM=9tw3+tz1Bd7kimQcyehhQ6UjJ=hH0M5_JGSOX5kVDncn6g@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dave Airlie <airlied@gmail.com>
Cc: airlied@linux.ie, dri-devel@lists.freedesktop.org, linux-acpi@vger.kernel.org

On Thu, 3 May 2012 09:15:23 +0100
Dave Airlie <airlied@gmail.com> wrote:

> On Tue, May 1, 2012 at 2:33 PM, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> > From: Alan Cox <alan@linux.intel.com>
> >
> > Add the opregion support and bring us in line with the opregion functionality in the
> > reference driver code. We can't share this with i915 currently because there are
> > hardcoded assumptions about dev_priv etc in both versions.
> 
> This isn't applying to my -next tree cleanly, do I need some previous patches?
> 
> I saw some acpi video ones going by but I wasn't sure what tree they
> were to be merged via.

I'd assumed the ACPI tree. I'll pull your current tree and see what needs
to be sorted out where.

Alan

