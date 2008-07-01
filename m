From: Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Subject: Re: [RFT] x86 acpi: normalize segment descriptor register on resume
Date: Tue, 1 Jul 2008 00:28:56 -0700
Message-ID: <20080701002856.2457a75d.akpm@linux-foundation.org>
References: <200807010148.02135.rjw@sisk.pl>
	<20080701072024.GB26601@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <kernel-testers-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20080701072024.GB26601-X9Un+BFzKDI@public.gmane.org>
Sender: kernel-testers-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ingo Molnar <mingo-X9Un+BFzKDI@public.gmane.org>
Cc: "Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org>, kernel-testers-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ACPI Devel Maling List <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Andi Kleen <andi-Vw/NltI1exuRpAAqCnN02g@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, pm list <linux-pm-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "H. Peter Anvin" <hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org>, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, stable-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Tue, 1 Jul 2008 09:20:24 +0200 Ingo Molnar <mingo-X9Un+BFzKDI@public.gmane.org> wrote:

> * Rafael J. Wysocki <rjw-KKrjLPT3xs0@public.gmane.org> wrote:
> 
> > Hi,
> > 
> > The appended patch fixes a regression and is considered as 2.6.26 
> > material. Everyone having a box with working suspend to RAM is gently 
> > requested to test it and verify if it doesn't break things.
> > 
> > The patch applies to the current -git.
> 
> The fix is _really_ tempting, but i think it's 2.6.26.1 material at the 
> earliest. I just counted about 8 red flag items in that commit:
> 
>   - "assembly code"
>   - "fresh change"
>   - "suspend/resume"
>   - "real-mode code"
>   - "ACPI"
>   - "SMM"
>   - "CPU erratas"
>   - "boot code"
> 
> I'd say it's probably 90% fine, but it's just too much risk at this 
> stage i think. The regression was only found 2 weeks ago, and the commit 
> that broke it was upstream for 2 months (and was under testing for about 
> 4 months).

Merge it into 2.6.27-rc1 and add Cc: <stable-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> to the changelog with
a note "needed in 2.6.26.x after a couple of weeks testing in mainline" or
something like that.

I expect 2.6.25.x will be maintained for a while yet too...
