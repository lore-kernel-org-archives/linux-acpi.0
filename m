From: Rich Townsend <rhdt-OBnUx95tOyn10jlvfTC4gA@public.gmane.org>
Subject: Re: Re: Smart Battery System driver
Date: Sun, 16 Jan 2005 03:55:57 -0500
Message-ID: <41EA2C1D.3030909@bartol.udel.edu>
References: <41E81C2C.8010809@bartol.udel.edu>	<1105747983.7368.3.camel@tyrosine>	<47e0449d05011419037877f931@mail.gmail.com> <m2fz13x8mw.fsf@phoenix.squirrel.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <m2fz13x8mw.fsf-KjnUIgV0B0bak1Ioo/c9IoRWq/SkRNHw@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Johan Vromans wrote:
> Johannes Kuhlmann <jkuhlmann-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> writes:
> 
> 
>>I had to put
>>EXPORT_SYMBOL(acpi_ec_write); and EXPORT_SYMBOL(acpi_ec_read); after
>>the functions in drivers/acpi/ec.c.
> 
> 
> This is one of the issues Bruno's patch addressed...
> 

Yeah, I'd completely forgotten about the patch, until I went back and 
checked the instructions in Bruno's smartbatt package. D'oh!

I've modified the README file accordingly, and placed a copy of the 
patch in my acpi-sbs package. This is on top of a number of changes & 
additions to the code, which include:

*) Fixed scaling bug when capacity is reported in mWh
*) Added a new module parameter, capacity_info, to alter whether 
capacities are reported in mAh (charge) or mWh (power)
*) Fixed a number of bugs in the formatting of info/state output
*) Added support for Smart Battery System Manager (SBSM), Smart Battery 
Selector (SBSEL) and Smart Battery Charge (SBC) subsystems. With the 
code for these in place, the module correctly (I think) enumerates how 
many batteries the system can support, which ones are present, etc.
*) Added a new legacy interface for the AC adapter, in 
/proc/acpi/ac_adapter/*/state (where * is typically SBS0).
*) Put in semaphores, so the code *might* now be SMP safe. Of course, 
this may be a purely academic excercise; I've never met the lucky **** 
who has an SMP laptop :)

The latest copy of the code can be obtained from:

http://shayol.bartol.udel.edu/~rhdt/download/acpi_sbs-20050116.tar.gz

To move forward from here, I'd appreciate some advice from others on
this list. In particular

*) I'd like some feedback on the directory structure I've chosen. At the 
moment, the root directory of the Smart Battery System is 'sbs', but 
would something more verbose like 'smart_battery_system' be appropriate? 
Also, should various subdirectories, representing subsystems, have more 
descriptive names -- e.g., 'battery_A' instead of 'SB0' (the SBS spec. 
refers to the batteries as 'A', 'B' etc), 'selector' instead of 'SBSL', 
and so on?

*) I'd appreciate feedback from people with systems *other* than Acer 
TravelMater 4x00 laptops, to help check parts of the code that are not 
accessed on these machines (e.g., the Smart Battery System Manager code; 
my TM4502 laptop has an older Smart Battery Selector)

*) The code to update the Smart Battery System state from the SMBus is 
terribly slow, presumably because SMBus itself is a slow protocol. 
Unfortunately, this has the effect of freezing the system (including 
loss of keystrokes and/or mouse movements) whenever an update occurs. 
Typically, these freezes will arise every few seconds, as monitoring 
tools (e.g., gkrellm, wmacpi) poll the /proc/acpi interfaces. The 
jerkiness that results is unacceptable to many, including myself. How 
might I go about fixing this? I've tried putting a schedule() call after 
every individual SMBus access, but that appears to have little effect on 
the system responsiveness.

*) I'm not sure how to go about implmeneting Alarm functionality, not 
only to deal with low-power scenarios, but also to detect asynchronous 
events such as AC on-line/off-line and battery change, without the need 
for polling. Certainly, interrupts *are* being generated somewhere, as 
evidenced by the incrementing value of the acpi field in 
/proc/interrupts. Furthermore, with ACPI debugging enabled, I can see 
the embedded controller handling the events; for instance, an AC 
off-line event produces the following debug output:

Execute Method: [\_SB_.PCI0.LPC0.EC0_._Q20] (Node dded7de8)
  acpi_ec-0180 [5125] acpi_ec_read          : Read [c0] from address [19]
  acpi_ec-0180 [5125] acpi_ec_read          : Read [14] from address [3d]
  acpi_ec-0180 [5125] acpi_ec_read          : Read [c0] from address [19]
  acpi_ec-0232 [5126] acpi_ec_write         : Wrote [80] to address [19]

The corresponding DSL code for function _Q20 of my DSDT is:

                    Method (_Q20, 0, NotSerialized)
                     {
                         If (And (SMST, 0x40))
                         {
                             Store (SMAA, Local0)
                             If (LEqual (Local0, 0x14))
                             {
                                 And (SMST, 0xBF, SMST)
                             }
                         }
                     }

...which unfortunately doesn't mean a whole lot to me. How can I install 
some form of a handler, so that when the EC detects a Smart Battery 
event (and -- as per the ACPI spec -- sets the EC Alarm Address and Data 
registers), and then fires off a General Purpose Event, a chunk of *my* 
code gets run?

Any pointers for the above questions will be very welcome -- and thanks 
to everyone who has responded with bug reports so far.

cheers,

Rich


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
