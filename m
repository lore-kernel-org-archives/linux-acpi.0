From: Rich Townsend <rhdt-OBnUx95tOyn10jlvfTC4gA@public.gmane.org>
Subject: Re: Re: Smart Battery System driver
Date: Mon, 17 Jan 2005 22:03:25 -0500
Message-ID: <41EC7C7D.1070003@bartol.udel.edu>
References: <41E81C2C.8010809@bartol.udel.edu>	<1105747983.7368.3.camel@tyrosine>	<47e0449d05011419037877f931@mail.gmail.com> <m2fz13x8mw.fsf@phoenix.squirrel.nl> <41EA2C1D.3030909@bartol.udel.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
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
To: Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi all --

I've just uploaded a new version of the Smart Battery driver:

http://shayol.bartol.udel.edu/~rhdt/download/acpi_sbs-20050117.tar.gz

Changes include

*) A slightly more-methodical use of mutexes (probably still broken, though)
*) An 'alarm' interface file in each SB? Smart Battery subdirectory (see 
the README file for usage instructions)
*) An 'alarm' interface file in each BAT? legacy battery subdirectory

The alarm functionality is read-write, so you can change the capacity & 
time-left levels at which the Smart Battery begins to generate alarm events.

HOWEVER, here's the rub: I haven't yet found a way of detecting when 
these alarm events are issued. Reading through chapter 12.12 of the ACPI 
spec, it appears that all Alarm Notify messages from EC-based SMBus 
should trigger a query method (_QXX), with the query value XX being set 
by the _EC named object.

For instance, on my system (TM4502):

                     Device (SMBC)
                     {
                         Name (_HID, "ACPI0001")
                         Name (_EC, 0x1820)
                         Device (SBS0)
                         {
                             Name (_HID, "ACPI0002")
                             Name (_SBS, 0x02)
                         }
                      }

...means that the SMBus has a base address of 0x18 within embedded 
controller space, and all SMBus events are handled by query method _Q20.

Looking at the definition of _Q20 on my system, we have:

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

This I think I can understand: if the SMBus Alarm Notify bit is set (bit 
14 of the SMST register), and the alarm was triggered by the device with 
shifted address 0x14, then reset the alarm bit.

Now what corresponds to shifted address 0x14? Well, shift it one bit to 
the right to get the 'true' SMBus slave address, and we find the value 
0x0a -- which corresponds (see sec. 10 of the ACPI spec.) to a Smart 
Battery System Manager (SBSM) or Smart Battery Selector (SBSEL, which 
I've got on my system). So, the _Q20 method listens for alarms coming 
from the SBSM/SBSEL, but takes no specific action when it receives one, 
beyond resetting it.

Spurred on by a post by a very helpful post by Karol Kozimor, I tried 
adding code to the _Q20 method, to fire off a notifcation to the driver 
(well, in fact I just used a Store(XXXXX, debug) to get some output). 
With this code in place, I found that my SBSEL was generating alarms 
when the AC power cord was plugged in and removed. Likewise, events were 
generated when the battery was removed and re-inserted.

Hurrah, I thought -- we can get the 'backend' for alarms to work 
(although we'll need to do some DSDT hacking). But here now is the 
problem: using the new driver, I set the alarm trigger levels to 
crazy-high values, to get the Smart Battery to fire off alarm events. 
But these events seem to be getting lost somewhere, or they're not being 
generated in the first place, because I don't get a peep from my hacked 
_Q20 method.

I don't know why this is the case, but its worth noting that section 
10.1.1 of the spec states "The Smart Battery System Manager, the Smart 
Battery Selector, and the Smart Battery Charger each have an optional 
mechanism for notifying the system that the battery configuration or AC 
status has changed. ACPI requires that this interrupt mechanism be 
through the SMBus Alarm Notify mechanism." Important note: no mention 
whatsoever of alarms generated by the Smart Battery itself!

But where, then, do the Smart Battery alarms end up? Reading sec. 
5.6.2.2.2 of the spec. gave me hope: "Similarly, for an SMBus driver, if 
no driver registers for SMBus alarms, the SMBus driver will queue 
control methods to handle these. Methods must be placed under the SMBus 
device with the name _QXX, where XX is the hex format of the SMBus 
address of the device sending the alarm". So I went added _QXX methods 
for SMBus slave address 0x0b (Smart Battery) and its shifted equivalent 
0x16. Unfortunately, again not a peep from the battery.

What could be going wrong? Some thoughts:
*) maybe there is already a driver registered for SMBus alarms, that 
prevents them from getting through?
*) I'm assuming its already there, but maybe the functionality described 
in 5.6.2.2.2 actually needs to be implemented in the i2c-acpi-ec code?
*) perhaps the battery simply isn't generating the alarms?
*) maybe I just don't know enough about what I'm doing?

Well, that's enough rambling for me -- I just wanted to share how far 
I'd got in working out what is what. I'd really like to get the alarm 
issue resolved, since it is the most important feature to me, but at the 
moment I need to do some Real Work to keep my boss happy. It would be 
great if eveyone interested in Smart Battery support could have a shot 
at playing around like I have -- seriously, you don't need to know a 
whole lot!

cheers,

Rich


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
