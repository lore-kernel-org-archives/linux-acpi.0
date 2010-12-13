From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH 1/5] resources: add arch hook for preventing allocation
 in reserved areas
Date: Mon, 13 Dec 2010 14:47:39 +0100
Message-ID: <20101213134739.GA27941@elte.hu>
References: <20101208213606.13026.47657.stgit@bob.kio>
 <AANLkTi=b5pq+RhA1DpyyRaLEQxQFOrf4aEXHrG-Qjqbt@mail.gmail.com>
 <20101211201615.79186de7@jbarnes-desktop>
 <201012121420.57217.rjw@sisk.pl>
 <20101213054334.GA15856@helgaas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx3.mail.elte.hu ([157.181.1.138]:40684 "EHLO mx3.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757617Ab0LMNs2 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 13 Dec 2010 08:48:28 -0500
Content-Disposition: inline
In-Reply-To: <20101213054334.GA15856@helgaas.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Jesse Barnes <jbarnes@virtuousgeek.org>, Linus Torvalds <torvalds@linux-foundation.org>, Len Brown <lenb@kernel.org>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Adam Belay <abelay@mit.edu>, Matthew Garrett <mjg@redhat.com>, Dan Williams <dcbw@redhat.com>


* Bjorn Helgaas <bjorn.helgaas@hp.com> wrote:

> > OK, so I guess the best thing we can do for 2.6.37 is to revert 1af3c2e (x86: 
> > allocate space within a region top-down), right?
> 
> That's a possibility, but I'm not sure it's the best.  It would avoid the nx6325 
> landmine, but we could easily step on a different one on other machines.
> 
> If Windows uses the end of available space first, that's the best-tested 
> territory, and I think it's better to try to stay in it rather revert 1af3c2e and 
> start mapping different territory that really isn't tested by Windows at all.
> 
> On the nx6325, we stray out of that tested territory because Linux opens windows 
> on subtractive-decode bridges and allocates more space to CardBus bridges.
> 
> I think it'd be fairly simple to leave subtractive-decode bridges alone, and that 
> might make the nx6325 work well enough for .37, even without the quirk.  This 
> feels like a change that might be the right thing to do in general.  Using 
> subtractive rather than positive decode would give up a little performance, but I 
> doubt it's important

Is there a patch for that that people could try?

The regression needs to be addressed one way or another: either by improving the 
"compatible with Windows" approach to actually work (without quirks), or by 
reverting to the tested-for-years Linux solution.

( What we always try to avoid is trading in a set of regressions for another set of 
  regressions. That way lies madness, it can not result in reliable, provable 
  progress. )

Thanks,

	Ingo
