From: Richard Witt <witt-IGkKxAqZmp0@public.gmane.org>
Subject: Re: AC adaptor state change lockup on HP Pavilion zt1290
Date: Tue, 04 Jan 2005 10:46:47 -0500
Message-ID: <41DABA67.5070702@bnl.gov>
References: <41D96598.3040102@bnl.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <41D96598.3040102-IGkKxAqZmp0@public.gmane.org>
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
List-Id: linux-acpi@vger.kernel.org

Richard Witt wrote:
> Hi All,
> 
>   I have a terribly annoying problem that I have so far been unable to 
> fix.  I'm running SuSE 9.2 Pro on a HP zt1290.  The kernel is their most 
> up-to-date (2.6.8-24.10-default).  Whenever I need to connect/disconnect 
> my AC adaptor the laptop locks-up hard.  I have to cold boot to recover 
> it.  I thought this was related to a buggy DSDT and so I attempted to 
> fix the DSDT according to the info at 
> (http://www.cpqlinux.com/acpi-howto.html#fix_broken_dsdt).  The DSDT now 
> compiles without errors or warnings. 

Hi All,

   Sorry to reply to my own post but I thought I better give a few more
details to hopefully get the ball rolling and get a response.  In my
original DSDT the AC adapter is device ACAD.  The relevent section of
code is here:

                 Device (ACAD)
                 {
                     Name (_HID, "ACPI0003")
                     Name (_PCL, Package (0x01)
                     {
                         \_SB
                     })
                     Method (_PSR, 0, NotSerialized)
                     {
                         Return (\_SB.PCI0.LPCB.ACPW)
                     }
                 }

Now, the ACPW member is in the GPIO Op region (under device LPCB) here:

                 OperationRegion (GPIO, SystemIO, 0x1180, 0x3B)
                 Field (GPIO, WordAcc, Lock, Preserve)
                 {
                     AccessAs (DWordAcc, 0x00),
                     Offset (0x0F),
                         ,   4,
                     LV28,   1,
                     Offset (0x2D),
                         ,   5,
                     LPOL,   1,
                     Offset (0x38),
                         ,   1,
                     SRST,   1,
                     Offset (0x39),
                         ,   2,
                     ACPW,   1
                 }

The compilation error from iasl that results from the above bits is:

DSDT.dsl.orig  1101:                     SRST,   1,
Error    1051 -                             ^ Access width of Field Unit
extends beyond region limit

DSDT.dsl.orig  1104:                     ACPW,   1
Error    1051 -                             ^ Access width of Field Unit
extends beyond region limit

and the change suggested by the webpage I mentioned in my first post is
to increase the size of the Op region by 1 (0x3B -> 0x3C).  Indeed after
doing so the compilation error is gone but even after loading the fixed
DSDT the problem remains, my laptop still locks-up whenever I try to
plugin or remove the AC adapter.
   I can post whatever files people would like to see.  I don't find any
other place in the DSDT that should affect the AC power but if someone
else can take a look or make a suggestion of what to try next I'd be
really grateful.  Hope to hear from someone.

Cheers,
   Richard

-- 
"We build too many walls and not enough bridges."
-- Sir Isaac Newton

---***---***---***---***---***---***---***---***---***---***---***----
             Richard Witt                 Phone (Yale): (203) 432-5834
LHEP, University of Bern, Switzerland    Email:  witt-IGkKxAqZmp0@public.gmane.org
---***---***---***---***---***---***---***---***---***---***---***----




-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
