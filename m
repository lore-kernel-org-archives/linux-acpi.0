From: James Sparenberg <james-q+VOwRQyn90NJZHkBl2fuw@public.gmane.org>
Subject: Re: acer aspire 3000 after a week.  ACPI report.
Date: Sun, 05 Jun 2005 01:30:58 -0700
Message-ID: <1117960258.19210.0.camel@localhost.localdomain>
References: <1117244104.21648.1.camel@localhost.localdomain>
	 <20050528101450.GA19354@fingerbrecher>
	 <1117397912.24721.5.camel@localhost.localdomain>
	 <1117956090.18789.16.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1117956090.18789.16.camel-bi+AKbBUZKY6gyzm1THtWbp2dZbC/Bob@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: ACPI <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Sun, 2005-06-05 at 00:21 -0700, James Sparenberg wrote:
> To jump back in on my original thread (with a new title.) After a week
> on the new DSDT all seemed to go well (running it as an addition to my
> initrd without any problem at all)  I moved on to the next level.
> Adding RAM.  This turned out to be a big mistake.  
> 
> ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
> ACPI: Embedded Controller [EC0] (gpe 25)
>     ACPI-0405: *** Error: Handler for [SystemMemory] returned
> AE_NO_MEMORY
>     ACPI-1138: *** Error: Method execution failed
> [\_SB_.PCI0.LPCB.EC0_._REG] (Node c13f6e00), AE_NO_MEMORY
> 
> Is the related dmesg error.    With the new ram and DSDT ... nothing
> works right that is associated with ACPI .... sound network therm fan
> and bat are all messed up.  However the box does run better *grin* and
> the ram is correctly detected.  (and matches the type the box requires
> pc2700 200pin) 
> 
> If I drop the new DSDT table and boot .... I get a box with no battery
> detection, Everything else works.  
> 
> I then tried just applying the patch I got from Bruno ... not related to
> the over strict nature of the new compiler, and also applying the
> compiler patch.  
> 
> This compiled and runs in exactly the same manor as the full on version.
> So no change there.    In the dsdt there are 3 lines related to system
> memory. But only one connected with \_SB as in the dmesg error.
> 
> Scope (\_SB)
>         {
>             Name (OSTB, Ones)
>             OperationRegion (OSTY, SystemMemory, 0x0BEFADE4, 0x00000001)
>             Field (OSTY, AnyAcc, NoLock, Preserve)
>             {
>                 TPOS,   8
>             }
> 
> So my question is should  0x0BEFADE4  be changed to 0x0BF395E4  or
> should I go all the way (My max ram is 2G on this box) 0x7754D7E4  so
> that in the future I don't have to adjust, or is it likely that I would
> be best off adjusting it to match ram.  
> 
> The other chance... is that I'm so totally off base I'm lost *grin*
> 
> James

Forget what I said above.... testing shows I'm wtfo....  back to the
drawing board.

James




-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
