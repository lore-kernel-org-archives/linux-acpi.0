From: Angela Dalton <angela-VPOBD8XdS/WVc3sceRu5cw@public.gmane.org>
Subject: Trying to generate ACPI events from software
Date: Thu, 17 Apr 2003 09:36:20 -0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3E9EADD4.6060401@cs.duke.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hello,

I apologize in advance for the lengthy message!

I am working on a program in which I would like to control the video 
device power state based on something other than a timeout (specifically 
based on information from external sensors).  Unfortunately, I can't 
seem to figure out how to turn off the LCD and backlight from the 
program.  I can blank the screen using "xset dpms force off" but the 
backlight remains on, and a subsequent "xset dpms force on" from my 
program has no effect, I actually have to physically move the mouse or 
press a key.  I also tried writing to the /dev/nvram locations that 
change when the lid is closed or the special keys are pressed to switch 
from LCD to CRT.  Apparently, the changes in the nvram values do not 
directly cause the display state change.

I have been looking through the ACPI driver source code and the ACPID 
code as well as the APCI Specification.  I have not been able to figure 
out how to generate an event from within my program to tell ACPI to shut 
the LCD off on my ThinkPad.  Here is what I think I understand:

1. Based on the ACPI Specification, there is a Notify(VGA, 0x80) call to 
tell the OSPM when the user presses the hotkey (in my case, FnF7) for 
switching monitor output.  The OSPM should call the _DSS method to set 
the device state of the LCD and CRT devices.

2. From looking through the driver code, I found a file evevent.c that 
seems to handle General Purpose events such as the one I want to cause. 
 This code detects events like a power button event and dispatches it to 
an installed handler.  There appear to be both fixed event handlers and 
generic general purpose event handlers.  There are also notify handlers. 
 This is a confusing part of the code for me as far as what I need to 
do.  Do I need to write a notify handler and a fixed event handler?  Is 
there a general notify handler that will invoke a general purpose event 
handler that I would write?

3.  Finally, based on what I see in the ospm directory, there is code to 
handle a variety of events.  I assume this would be where my handler 
would go.  It seems like this is a rather large undertaking, based on 
the code for the other devices.  

My questions are:

Am I on the right track or completely lost??  And is there is much 
easier way to do this using the ACPID or OSPMD?  If so, can someone 
please explain it to me?  One thought I had was if my program could 
generate a lid event then it might shut off the display (but how would I 
get it back on and how can I prevent other stuff from also occuring, 
like a suspend or hibernate?)

I appreciate any help I can get!

Best Regards,
Angela Dalton



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
