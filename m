From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: Bank screen after resume on Dell XPS M1330
Date: Sun, 3 May 2009 12:56:03 +0100
Message-ID: <20090503115603.GA18880@srcf.ucam.org>
References: <200905031111.50789.arvidjaar@mail.ru> <20090503105932.GA18170@srcf.ucam.org> <200905031543.28977.arvidjaar@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:48965 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755515AbZECL4G (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 3 May 2009 07:56:06 -0400
Content-Disposition: inline
In-Reply-To: <200905031543.28977.arvidjaar@mail.ru>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrey Borzenkov <arvidjaar@mail.ru>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On Sun, May 03, 2009 at 03:43:28PM +0400, Andrey Borzenkov wrote:
> On Sunday 03 of May 2009 14:59:32 Matthew Garrett wrote:
> > On Sun, May 03, 2009 at 11:11:47AM +0400, Andrey Borzenkov wrote:
> > > 01:00.0 VGA compatible controller: nVidia Corporation GeForce 8400M
> > > GS (rev a1)
> >
> > We don't know how to reinitialise nvidia graphics hardware.
> 
> Just in case - same issue also after resume from hibernation. I was 
> under impression, that hibernation does not have these issues as card 
> goes via normal POST routine.

Hm. That sounds a bit weirder.

> Hmm ... this implies users of nVidia are locked to proprietary driver if 
> suspend is required?

Right now, yeah.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
