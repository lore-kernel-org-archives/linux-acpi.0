From: Bruno Ducrot <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: Re: Centrino speedstep
Date: Thu, 30 Dec 2004 11:57:16 +0100
Message-ID: <20041230105716.GC19199@poupinou.org>
References: <m2zmzyw4e7.fsf@phoenix.squirrel.nl> <20041228212653.GA8436@dominikbrodowski.de> <20041229181834.GA19199@poupinou.org> <m21xd83m6b.fsf@phoenix.squirrel.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <m21xd83m6b.fsf-KjnUIgV0B0bak1Ioo/c9IoRWq/SkRNHw@public.gmane.org>
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

On Wed, Dec 29, 2004 at 09:05:16PM +0100, Johan Vromans wrote:
> Bruno Ducrot <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org> writes:
> 
> > After looking the DSDT, this laptop do not support the _PDC switch, so
> > the cpufreq-centrino driver will not work.  But it should work with the
> > acpi io driver though.
> 
> This seems to be the case.
> 
> > Interresting portion:
> > [...]
> >
> > This also mean there is no way to get the ondemand governor (or any
> > DVS requiring low latency driver) to work with this one
> 
> What exactly does that mean?

The latency in-between each P-state transitions is too high in order to
use a dynamic voltage scaling algorithme to be practical.  BTW, I am
maybe wrong as stated by Dominik.

> > (unless hardcoding a table in the cpufreq-centrino).
> 
> Would that be difficult to accomplish?

No.

> > There is no _CST also, this means there is no C4 support :(
> 
> Nope. I'll have to do with C3...
> 
> BTW: To be able to compile my DSDT I needed some fixes, mostly
> trivial, except one: the final return value of Method(_STA) from
> Device(BAY1), around line 3222. Do you have any idea?
> 

Yes, though I'm not sure how to fix this correctly I'm afraid.

   4901                         Method (_STA, 0, NotSerialized)
   4902                         {
   4903                             If (\_SB.PCI0.IDE0.ESID)
   4904                             {
   4905                                 \_SB.PCI0.IDE0.SECN.CBAY ()
   4906                                 Store (^^BFLG, Local0)
   4907                                 If (LEqual (^^BNUM, 0x01))
   4908                                 {
   4909                                     If (And (Local0, 0x01))
   4910                                     {
   4911                                         If (\_SB.PCI0.LPC0.LV37)
   4912                                         {
   4913                                             Return (0x08)
   4914                                         }
   4915                                         Else
   4916                                         {
   4917                                             Return (0x0F)
   4918                                         }
   4919                                     }
                                           // this is the problem.  If
                                           // 'And (Local0, 0x01)' is
                                           // false.

                                           // Maybe adding this:
                                           Else
                                           {
                                               Return(8)
                                           }
                                           // will be ok.



   4920                                 }
   4921                                 Else
   4922                                 {
   4923                                     If (LEqual (^^BNUM, 0x02))
   4924                                     {
   4925                                         If (\_SB.PCI0.LPC0.LV37)
   4926                                         {
   4927                                             Return (0x08)
   4928                                         }
   4929                                         Else
   4930                                         {
   4931                                             Return (0x0F)
   4932                                         }
   4933                                     }
   4934                                     Else
   4935                                     {
   4936                                         Return (0x08)
   4937                                     }
   4938                                 }
   4939                             }
   4940                             Else
   4941                             {
   4942                                 Return (0x08)
   4943                             }
   4944                         }



The trouble is that I'm not sure for the value of the return value, but
I think this path is not taken anyway (BFLG will be equal to 1 if BNUM
is 1 due to the CBAY() call).

-- 
Bruno Ducrot

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
