From: Bruno Ducrot <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: ACPI throttling to death?
Date: Fri, 8 Apr 2005 12:10:28 +0200
Message-ID: <20050408101028.GH2298@poupinou.org>
References: <200504042214.15648.jfrey@gmx.de> <200504052223.17547.jfrey@gmx.de> <20050406141923.GZ2298@poupinou.org> <200504081153.30624.janfrey@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <200504081153.30624.janfrey-S0/GAf8tV78@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Jan Frey <janfrey-S0/GAf8tV78@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Fri, Apr 08, 2005 at 11:53:30AM +0200, Jan Frey wrote:
> Hi,
> 
> this notebook seems to use C2 nearly all the time:
> 
> active state:            C2
> default state:           C1
> bus master activity:     00000000
> states:
>     C1:                  promotion[C2] demotion[--] latency[000] 
> usage[00007950]
>    *C2:                  promotion[--] demotion[C1] latency[020] 
> usage[00742673]
>     C3:                  <not supported>
> 
> Hey, yet another fascinating finding:
> cat /proc/acpi/processor/CPU0/throttling
> state count:  16
> active state:  T0
> states:
>    *T0:   00%
>     T1:   06%
>     T2:     12%
>     T3:    18%
>     T4:    24%
>     T5:     31%
>     T6:     37%
>     T7:     43%
>     T8:     49%
>     T9:     55%
>     T10:        62%
>     T11:        68%
>     T12:        74%
>     T13:        80%
>     T14:        86%
>     T15:        93%
> 
> Now I did: echo 14 >/proc/acpi/processor/CPU0/throttling 
> what resulted in sever slow down of the machine. And then:
> echo 15 >/proc/acpi/processor/CPU0/throttling 
> really caused the machine to hang!! So it seems to be T15 state that 
> "kills" the machine!?
> 
> Two questions:
> a) why does it get so hot that even throttling does not help? (It does not 
> do so running Win2k)

My only guess is that C2 is broken in the sense that the northbridge
and/or the southbridge are not configured properly.

Unfortunately, I don't have access to VIA datasheets (I've tryed two
times in the past.  Never got even a single answer).

> b) why does it die in T15?

single copy and past of one of an early email:

> > I remember that some southbridge are broken, though I'm only aware
> > problem with some PIIX4 (it is in an errata, I don't remember exactly
> > which version).  Maybe its the case here?
> > Does your laptop hang if forcing throttling level at 12%?

So I guess we have to implement a little quirk in order to not allow
T15 for that ALi southbridge...

Cheers,

-- 
Bruno Ducrot

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
