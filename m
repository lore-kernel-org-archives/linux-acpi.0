From: Arjan van de Ven <arjan@infradead.org>
Subject: Re: 20000+ wake-ups/second in 2.6.24.   Bug?
Date: Mon, 4 Feb 2008 09:50:59 -0800
Message-ID: <20080204095059.6f92d875@laptopd505.fenrus.org>
References: <200711302153.lAULrZ7n026255@imap1.linux-foundation.org>
	<20071201154646.5a288c9e@laptopd505.fenrus.org>
	<4751F484.6040204@rtr.ca>
	<200712020120.36439.rjw@sisk.pl>
	<47A74B5F.7020202@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753447AbYBDRw1@vger.kernel.org>
In-Reply-To: <47A74B5F.7020202@rtr.ca>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Lord <lkml@rtr.ca>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>, Andrew Morton <akpm@linux-foundation.org>, abelay@novell.com, lenb@kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Mon, 04 Feb 2008 12:29:03 -0500
Mark Lord <lkml@rtr.ca> wrote:

> re:  http://bugzilla.kernel.org/show_bug.cgi?id=9489
> 
> This just happened here again.  Or at least I finally noticed that
> the fan on my notebook seemed to be running hard for much longer
> than usual.  :)
> 
> Powertop showed 2.6.24-final running with 10000-36000 wakeups/sec,
> with *nothing* significant running:  top showed 97+% idle on both
> cores.
> 
> -               Device: Errors: Correctable- Non-Fatal- Fatal+
> Unsupported-
> +               Device: Errors: Correctable+ Non-Fatal+ Fatal+
> Unsupported+ Device: RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
>                 Device: MaxPayload 128 bytes, MaxReadReq 128 bytes
>                 Link: Supported Speed 2.5Gb/s, Width x1, ASPM L0s L1,
> Port 1 @@ -101,12 +101,12 @@
>         Latency: 0, Cache Line Size: 64 bytes
>         Bus: primary=00, secondary=0c, subordinate=0c, sec-latency=0
>         Memory behind bridge: efc00000-efcfffff
> -       Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast
> >TAbort- <TAbort- <MAbort- <SERR- <PERR-
> +       Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast
> >TAbort- <TAbort- <MAbort+ <SERR- <PERR- BridgeCtl: Parity- SERR+
> >NoISA- VGA- MAbort- >Reset- FastB2B-

this shows you're having various types of really bad things going on, like PCI
master aborts and the like. Those would certainly be a factor in waking the cpu up;
they're basically hardware exceptions, and I can totally believe (would need to find out
from hw guys how this works in practice) that this sort of serious error would keep the
cpu out of deep C states until resolved.
