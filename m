From: Cyril Wattebled <neurowork-GANU6spQydw@public.gmane.org>
Subject: Re: Centrino question
Date: Fri, 21 May 2004 12:56:37 +0000
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040521125637.33f69fc6.neurowork@free.fr>
References: <3ACA40606221794F80A5670F0AF15F8404622C57@PDSMSX403.ccr.corp.intel.com>
	<20040520015748.776d5b84.neurowork@free.fr>
	<1085111429.12352.563.camel@dhcppc4>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1085111429.12352.563.camel-D2Zvc0uNKG8@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Luming Yu <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, cpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-acpi <linux-acpi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Thanks for your answer,

However, I don't understand, I was told that the centrino processor and chipset
supports C3 and even C4.
Why would they intend C3 to be disabled ?
By the way, I tried to change the value of ACPI_PROCESSOR_MAX_C3_LATENCY to
1002 so that C3 is enabled. However, it doesn't change anything, C3 state
is never called.
Actually, I'm looking for a way to make my laptop last longer
unplugged because I think and I also have been told that 2h30 of battery life
is really disappointing for the centrino. Some guys last 3h30 with a P4
3.06ghz, with almost the same battery capacity. I thought that C3 would help a
bit on that but since it's disabled, I don't know what to do. I already enabled
Speedstep, tweaked hdparm spin down value, disabled devices like Bluetooth and
pcmcia.
I so frustrated because I can last up to 6h unplugged on the windows platform
but only 2h30 on linux. There must be something wrong.
Do you guys have any ideas?
Thanks anyway.

--
Cyril Wattebled
neurowork-GANU6spQydw@public.gmane.org


On 20 May 2004 23:50:29 -0400
Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> wrote:

> On Wed, 2004-05-19 at 21:57, Cyril Wattebled wrote:
> > Thanks for your answer.
> > 
> > I have checked why exactly the C3 state is disabled thanks to the
> > information you provided.
> > It seems that it's because the C3 latency is too large. The value is 1001.
> > As the max value is 1000, my question is:
> > Is it safe to change ACPI_PROCESSOR_MAX_C3_LATENCY ?
> > I don't have the knowledge to understand what this latency is about, so I
> > don't really know if 1 microsecond really changes something.
> > So is it the FADT table value that is wrong, if not, what should I do ?
> > Could you give me a hint on that if you have time.
> > Thank you.
> 
> 1000 is from the ACPI spec.  If the BIOS put 1001 there, then they
> intended for C3 to be disabled.  You don't want to touch this.
> 
> Indeed, if you were just under 1000, you'd have trouble on 2.6,
> since clock ticks are 1ms apart...
> 
> -Len
> 
> 
> 


-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
