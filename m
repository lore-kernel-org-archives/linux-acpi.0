From: Dominik Brodowski <linux-X3ehHDuj6sIIGcDfoQAp7OTW4wlIGRCZ@public.gmane.org>
Subject: Re: battery life with cpufreq
Date: Mon, 19 Sep 2005 11:24:48 +0200
Message-ID: <20050919092448.GA9023@isilmar.linta.de>
References: <9cfa150205091902116057595e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <9cfa150205091902116057595e-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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

On Mon, Sep 19, 2005 at 11:11:01AM +0200, Fred Blaise wrote:
> I have an dell inspiron 5150, 3Ghz. I have loaded p4_clockmod, and my
> CPU frequency now changes with powernowd. It seems to work well.
>
> However, I am not seeing any battery life improvement.
> 
> Any ideas?

Yes. In general, throttling doesn't improve battery life, only CPU frequency
scaling does:

"In contrast to CPU frequency scaling, where the operating frequency is
constantly modulated, throttling means the CPU is forced to a halt for short
periods of time. If throttled, the CPU [enters] into a physical and
electrical state comparable to the idling states mentioned above, so it can
be described as an enforced idling of the CPU.

As certain CPU power state typically utilize similar hardware
implementations, and as throttling does not have a positive effect on the
energy consumption during CPU power states, throttling the CPU by a given
rate is only useful if the CPU is less idle than the throttling rate."

	Dominik


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
