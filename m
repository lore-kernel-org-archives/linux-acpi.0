From: Dominik Brodowski <linux-X3ehHDuj6sIIGcDfoQAp7BvVK+yQ3ZXh@public.gmane.org>
Subject: Re: Re: Centrino speedstep
Date: Sun, 2 Jan 2005 12:08:26 +0100
Message-ID: <20050102110826.GA14862@dominikbrodowski.de>
References: <m2zmzyw4e7.fsf@phoenix.squirrel.nl> <20041228212653.GA8436@dominikbrodowski.de> <20041229181834.GA19199@poupinou.org> <41D42E88.5080800@mega.ist.utl.pt> <m2llbfk931.fsf@phoenix.squirrel.nl> <41D43A9F.5050507@mega.ist.utl.pt> <16852.15668.315630.700537@phoenix.squirrel.nl> <41D4AA9F.7080200@mega.ist.utl.pt> <20041231082524.GA8312@dominikbrodowski.de> <m2652hh17w.fsf@phoenix.squirrel.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <m2652hh17w.fsf-KjnUIgV0B0bak1Ioo/c9IoRWq/SkRNHw@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Johan Vromans <jvromans-2pNSKKP3PSKEVqv0pETR8A@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Sat, Jan 01, 2005 at 11:50:59AM +0100, Johan Vromans wrote:
> Dominik Brodowski <linux-X3ehHDuj6sIIGcDfoQAp7BvVK+yQ3ZXh@public.gmane.org> writes:
> 
> > On Fri, Dec 31, 2004 at 01:25:51AM +0000, Pedro Venda wrote:
> >> also, how exactly can I use ACPI throttling? because with the speestep 
> >> driver, I can't go below 600MHz, but 12% of maximum frequency is 180MHz 
> >> which I can reach using ACPI throttling.
> >
> > but throttling doesn't save you anything.
> 
> Do you have any idea of the actual power savings in relation to
> frequency scaling and sleep states? E.g., stepping down from 1.6Ghz to
> 800Mhz will save a lot (50%?), but how much is saved by using C3
> state. More interesting, how much savings are lost by not being able
> to use C3 state?
                                                        C0              C1          C2      C3
----------------------------------------------------------------------------------------------------------------
Intel Pentium(R) M Processor, 1400 MHz & 1.484V[19]     22 W            7.3 W       7.3 W   7.0 W/5.1 W/0.55W[**][20]

Intel Pentium(R) M Processor, 1400 MHz & 1.484V,
        scaled down to 600 MHz                          6 W             1.8 W       1.8 W   1.7 W/1.1 W/0.55W[**]


[**] first value: Sleep State; second value: Deep Sleep State; third value: Deeper Sleep State.

[19] Intel(R) Pentium(R) M Processor Datasheet, Order Nr. 252612,
rev. 02, June 2003, p. 72.

[20] The extremely lower power consumption in Deeper Sleep and the fact that Deeper Sleep most
commonly is only made available by the _CST method expresses the urgency needed in
implementing it in the Linux kernel, and it has been merged into the latest
2.6.-sources for 2.6.11-rc1.

	Dominik


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
