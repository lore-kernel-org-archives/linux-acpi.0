From: Rich Townsend <rhdt-OBnUx95tOyn10jlvfTC4gA@public.gmane.org>
Subject: New SmartBattery DSDT-based controller
Date: Sat, 29 Jan 2005 14:02:58 -0500
Message-ID: <41FBDDE2.1050403@bartol.udel.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
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

Dear All,

I've been quiet with recent updates on my Smart Battery driver, because
I've been digging deeper into how smart batteries are dealt with in a
variety of systems. What I've found is this: at the most basic level,
there are three ways of dealing with smart batteries (or for that
matter, any SMBus-based device) that are run by an ACPI-aware embedded
controller (EC):

1) Direct fiddling with the SMBus registers that make up part of the EC
address space. This is what Bruno Ducrot's i2c-acpi-ec module was for:
it exposed kernel-space functions to allow one to perform the required
fiddling. My acpi-sbs module then used these functions to examine the
status of the smart battery.

2) The use of an SMBus operating region, which makes each SMBus device
(i.e., battery, charger, selector, system manager) look like a set of
registers that can be read from or written to. Although quite elegant,
this approach requires a corresponding address space driver to be
implemented in the operating system (unlike approach 1 above).
Unfortunately, no such implementation currently exists for Linux.

3) The use of ACPI methods, as specified by the SMBus Control Method
Interface specification. These present a unified, consistent interface
to the SMBus, but internally may rely on a variety of approaches (such
as 1 above) to do the actual hardware control. This SMBus-CMI approach 
can be used with non-EC SMBus segments as well.

In most smart battery systems, these details are hidden from the
operating system, since the DSDT contains device definitions (BAT0,
BAT1, BAT2 etc) that make the smart battery appear -- to the OS -- like
a traditional Control Method (CM) battery. Laptop manufacturers that 
I've seen do this include Compaq, Gateway & Sony. HOWEVER, some 
manufacturers  -- Acer in particular -- have not included the CM code in
their DSDT, preferring to rely instead on a set of software-based tools 
to examine the battery status (most likely, via approach 1 above). And, 
of course, these tools are Windows specific.

This is where my new DSDT stuff comes in: I have written the necessary
DSDT code to add CM definitions for smart-battery based systems. I've
tried to make this code as platform-independent as possible, by
accessing the SMBus where possible via approach 3 (the uniform SMBus
Control Method Interface), but there is still a certain degree of
platform dependence to the code.

So it looks like the best way to move forward at the moment is:

1) Get a copy of your DSDT
2) Send it to me, with the *full* make/model of your machine
3) I'll add in the CM definitions to your DSDT
4) I'll post the modified DSDT on my website.
5) Download the modified DSDT, and install it following the instructions
at http://forums.gentoo.org/viewtopic.php?t=122145 (see section 9;
although in Gentoo forums, these instructions should work on most systems).

Eventually, the modified DSDTs can be put back into the ACPI4Linux 
database; but I'm more interested at the moment in ironing out any 
glitches in the code.

To get the ball rolling, I have on my website the two modified DSDTs:

Acer TravelMate 4502lmi:
http://shayol.bartol.udel.edu/~rhdt/download/tm4502lmi-sbs-cm.aml
(this is my own 1.6GHz Centrino machine, I've confirmed this works)

Acer TravelMate 4001wlmi:
http://shayol.bartol.udel.edu/~rhdt/download/tm4001wlmi-sbs-cm.aml
(this is based on the *fixed* DSDT posted on Johan Vromans' web page, 
for his 1.5Ghz Centrino machine; I've not been able to test it, but I 
expect it to work).

These of course can be converted into source code using an AML
disassembler, but if you want to see the code that these DSDTs were
compiled from (including lots of comments on the new CM code), just
change the extension from .aml to .asl in the URL.

I look forward to DSDTs and bug reports!

cheers,

Rich



-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
