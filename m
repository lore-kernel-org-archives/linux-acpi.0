From: Dominik Brodowski <linux-X3ehHDuj6sIIGcDfoQAp7OTW4wlIGRCZ@public.gmane.org>
Subject: Re: battery life with cpufreq
Date: Mon, 19 Sep 2005 11:46:54 +0200
Message-ID: <20050919094654.GA26933@isilmar.linta.de>
References: <9cfa150205091902116057595e@mail.gmail.com> <20050919092448.GA9023@isilmar.linta.de> <9cfa150205091902354d5b4c43@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <9cfa150205091902354d5b4c43-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Fred Blaise <chapeaurouge-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi,

On Mon, Sep 19, 2005 at 11:35:24AM +0200, Fred Blaise wrote:
> On 9/19/05, Dominik Brodowski <linux-X3ehHDuj6sIIGcDfoQAp7OTW4wlIGRCZ@public.gmane.org> wrote:
> > Hi,
> > 
> > On Mon, Sep 19, 2005 at 11:11:01AM +0200, Fred Blaise wrote:
> > > I have an dell inspiron 5150, 3Ghz. I have loaded p4_clockmod, and my
> > > CPU frequency now changes with powernowd. It seems to work well.
> > >
> > > However, I am not seeing any battery life improvement.
> > >
> > > Any ideas?
> > 
> > Yes. In general, throttling doesn't improve battery life, only CPU frequency
> > scaling does:
> ok.. So the fact that my CPU goes down to 383Mghz instead of the
> normal 3Ghz is not frequency scaling? (pardon the noob that I am if
> this question doesn't make sense)

Exactly. In fact, the frequency rate is not changed, it is only stopped for
short periods of time.



3 Ghz	  	  :	x x x x x x x x x x x x x x x x
scaling to 1.5 GHz:	x   x   x   x   x   x   x   x 
throttling to 1.5 :	x x x x       x x x x         x
			-------------------------------> t
			[x] denotes an instruction is executed by the CPU

If either the acpi-cpufreq or one of the speedstep-* modules works, you
should use that instead of p4-clockmod -- these offer (under normal
circumstances) CPU frequency scaling, while p4-clockmod only offers
throttling.

	Dominik


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
