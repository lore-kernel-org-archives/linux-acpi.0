From: Bruno Ducrot <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: Re: Smart Battery System driver
Date: Mon, 17 Jan 2005 12:41:09 +0100
Message-ID: <20050117114109.GS19199@poupinou.org>
References: <41E81C2C.8010809@bartol.udel.edu> <1105747983.7368.3.camel@tyrosine> <47e0449d05011419037877f931@mail.gmail.com> <m2fz13x8mw.fsf@phoenix.squirrel.nl> <41EA2C1D.3030909@bartol.udel.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <41EA2C1D.3030909-OBnUx95tOyn10jlvfTC4gA@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Rich Townsend <rhdt-OBnUx95tOyn10jlvfTC4gA@public.gmane.org>
Cc: Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Sun, Jan 16, 2005 at 03:55:57AM -0500, Rich Townsend wrote:
> Johan Vromans wrote:
...

> >Johannes Kuhlmann <jkuhlmann-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> writes:
...

> *) The code to update the Smart Battery System state from the SMBus is 
> terribly slow, presumably because SMBus itself is a slow protocol. 
> Unfortunately, this has the effect of freezing the system (including 
> loss of keystrokes and/or mouse movements) whenever an update occurs. 
> Typically, these freezes will arise every few seconds, as monitoring 
> tools (e.g., gkrellm, wmacpi) poll the /proc/acpi interfaces. The 
> jerkiness that results is unacceptable to many, including myself. How 
> might I go about fixing this? I've tried putting a schedule() call after 
> every individual SMBus access, but that appears to have little effect on 
> the system responsiveness.

Look http://marc.theaimsgroup.com/?l=acpi4linux&m=109760298204539&w=2
More, the acpi-i2c-ec need to be event driven, which is not the case
yet.

> 
> *) I'm not sure how to go about implmeneting Alarm functionality, not 
> only to deal with low-power scenarios, but also to detect asynchronous 
> events such as AC on-line/off-line and battery change, without the need 
> for polling. Certainly, interrupts *are* being generated somewhere, as 
> evidenced by the incrementing value of the acpi field in 
> /proc/interrupts. Furthermore, with ACPI debugging enabled, I can see 
> the embedded controller handling the events; for instance, an AC 
> off-line event produces the following debug output:
> 
> Execute Method: [\_SB_.PCI0.LPC0.EC0_._Q20] (Node dded7de8)
>  acpi_ec-0180 [5125] acpi_ec_read          : Read [c0] from address [19]
>  acpi_ec-0180 [5125] acpi_ec_read          : Read [14] from address [3d]
>  acpi_ec-0180 [5125] acpi_ec_read          : Read [c0] from address [19]
>  acpi_ec-0232 [5126] acpi_ec_write         : Wrote [80] to address [19]
> 
> The corresponding DSL code for function _Q20 of my DSDT is:
> 
>                    Method (_Q20, 0, NotSerialized)
>                     {
>                         If (And (SMST, 0x40))
>                         {
>                             Store (SMAA, Local0)
>                             If (LEqual (Local0, 0x14))
>                             {
>                                 And (SMST, 0xBF, SMST)
>                             }
>                         }
>                     }
> 
> ...which unfortunately doesn't mean a whole lot to me. How can I install 
> some form of a handler, so that when the EC detects a Smart Battery 
> event (and -- as per the ACPI spec -- sets the EC Alarm Address and Data 
> registers), and then fires off a General Purpose Event, a chunk of *my* 
> code gets run?

This have to be done in i2c-acpi-ec which will overwrite that one and
must not be run if we do it correctly.
I guess this method is for OS which do not implement that one, as its
the case for now..

Remember, we have that:
                    Device (SMBC)
                    {
                        Name (_HID, "ACPI0001")
                        Name (_EC, 0x1820)
                                       ^^
				   which will correspond to
				   this _Q20 that we have to
				   overwrite.



                        Device (SBS0)
                        {
                            Name (_HID, "ACPI0002")
                            Name (_SBS, 0x02)
                        }
                    }

Many thanks again for your work,

-- 
Bruno Ducrot

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
