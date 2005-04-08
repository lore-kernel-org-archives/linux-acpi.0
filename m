From: Jan Frey <janfrey-S0/GAf8tV78@public.gmane.org>
Subject: Re: ACPI throttling to death?
Date: Fri, 8 Apr 2005 11:53:30 +0200
Message-ID: <200504081153.30624.janfrey@web.de>
References: <200504042214.15648.jfrey@gmx.de> <200504052223.17547.jfrey@gmx.de> <20050406141923.GZ2298@poupinou.org>
Reply-To: janfrey-S0/GAf8tV78@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20050406141923.GZ2298-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Content-Disposition: inline
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: Bruno Ducrot <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi,

this notebook seems to use C2 nearly all the time:

active state:            C2
default state:           C1
bus master activity:     00000000
states:
    C1:                  promotion[C2] demotion[--] latency[000] 
usage[00007950]
   *C2:                  promotion[--] demotion[C1] latency[020] 
usage[00742673]
    C3:                  <not supported>

Hey, yet another fascinating finding:
cat /proc/acpi/processor/CPU0/throttling
state count:  16
active state:  T0
states:
   *T0:   00%
    T1:   06%
    T2:     12%
    T3:    18%
    T4:    24%
    T5:     31%
    T6:     37%
    T7:     43%
    T8:     49%
    T9:     55%
    T10:        62%
    T11:        68%
    T12:        74%
    T13:        80%
    T14:        86%
    T15:        93%

Now I did: echo 14 >/proc/acpi/processor/CPU0/throttling 
what resulted in sever slow down of the machine. And then:
echo 15 >/proc/acpi/processor/CPU0/throttling 
really caused the machine to hang!! So it seems to be T15 state that 
"kills" the machine!?

Two questions:
a) why does it get so hot that even throttling does not help? (It does not 
do so running Win2k)
b) why does it die in T15?

Br 
Jan

On Wednesday 06 April 2005 16:19, Bruno Ducrot wrote:
> On Tue, Apr 05, 2005 at 10:23:17PM +0200, Jan Frey wrote:
> > > BTW, are you sure throttling work OK?
> >
> > At least you can notice remarkable slowdown and loss of responsiveness
> > when throttling is supposed to be active. This effect is also
> > dependent on the throttling level, the higher it is the more
> > noticeable those delays are... So at least on the "slow-down" side of
> > things it seems to be working, but unfortunately it does not decrease
> > CPU temp...
>
> Well...  BTW, throttling is only a way to force somehow a certain amount
> of idle time to be done, somehow.  If you have some trouble even if the
> system is mostly idle, throttling wont help.
>
> > > Then mail me the acpidmp.out.bz2
> >
> > I will do so as soon as possible.
>
> OK, got it.  Will look.
>
> > > I'm still wondering if I'm right to think that its not an intel
> > > chipset.  If its an Intel one, then something is wrong.  Intel
> > > chipset support 8 throttling levels, not 16.  Could you please do a
> > > lspci -v?
> >
> > Oh yes, I totally forgot. If I remember correctly it is some VIA
> > chipset. lspci output will also follow.
>
> I remember that some southbridge are broken, though I'm only aware
> problem with some PIIX4 (it is in an errata, I don't remember exactly
> which version).  Maybe its the case here?
> Does your laptop hang if forcing throttling level at 12%?

-- 
+------------------------------------------------+
! Jan Frey          email: janfrey-S0/GAf8tV78@public.gmane.org        !
! Taubenstr. 1      phone: 0234-3694671          !
! D-44789 Bochum    cell : 0175-1241106          !
! Germany                                        !
+------------------------------------------------+


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
