From: "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: Trying to generate ACPI events from software
Date: Fri, 18 Apr 2003 16:50:52 +0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3ACA40606221794F80A5670F0AF15F842722A6@pdsmsx403.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
content-class: urn:content-classes:message
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Angela Dalton <angela-VPOBD8XdS/WVc3sceRu5cw@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


Do you want ACPI export a interface to user to shut off the LCD through =
command like:
#echo -n 3  > /proc/acpi/display/LCD0
I don't think there is such functionality in current ACPI =
implementation.
Maybe you can try to write such a driver display.=20
But we should enhance the stability of ACPI core on various platform =
first.
Anyway, the various attractive PM features are based on a stable ACPI =
core.

Thanks,
Luming



-----Original Message-----
From: Angela Dalton [mailto:angela-VPOBD8XdS/WVc3sceRu5cw@public.gmane.org]
Sent: 2003?4?17? 21:36
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Subject: [ACPI] Trying to generate ACPI events from software


Hello,

I apologize in advance for the lengthy message!

I am working on a program in which I would like to control the video=20
device power state based on something other than a timeout (specifically =

based on information from external sensors).  Unfortunately, I can't=20
seem to figure out how to turn off the LCD and backlight from the=20
program.  I can blank the screen using "xset dpms force off" but the=20
backlight remains on, and a subsequent "xset dpms force on" from my=20
program has no effect, I actually have to physically move the mouse or=20
press a key.  I also tried writing to the /dev/nvram locations that=20
change when the lid is closed or the special keys are pressed to switch=20
from LCD to CRT.  Apparently, the changes in the nvram values do not=20
directly cause the display state change.

I have been looking through the ACPI driver source code and the ACPID=20
code as well as the APCI Specification.  I have not been able to figure=20
out how to generate an event from within my program to tell ACPI to shut =

the LCD off on my ThinkPad.  Here is what I think I understand:

1. Based on the ACPI Specification, there is a Notify(VGA, 0x80) call to =

tell the OSPM when the user presses the hotkey (in my case, FnF7) for=20
switching monitor output.  The OSPM should call the _DSS method to set=20
the device state of the LCD and CRT devices.

2. From looking through the driver code, I found a file evevent.c that=20
seems to handle General Purpose events such as the one I want to cause.=20
 This code detects events like a power button event and dispatches it to =

an installed handler.  There appear to be both fixed event handlers and=20
generic general purpose event handlers.  There are also notify handlers. =

 This is a confusing part of the code for me as far as what I need to=20
do.  Do I need to write a notify handler and a fixed event handler?  Is=20
there a general notify handler that will invoke a general purpose event=20
handler that I would write?

3.  Finally, based on what I see in the ospm directory, there is code to =

handle a variety of events.  I assume this would be where my handler=20
would go.  It seems like this is a rather large undertaking, based on=20
the code for the other devices. =20

My questions are:

Am I on the right track or completely lost??  And is there is much=20
easier way to do this using the ACPID or OSPMD?  If so, can someone=20
please explain it to me?  One thought I had was if my program could=20
generate a lid event then it might shut off the display (but how would I =

get it back on and how can I prevent other stuff from also occuring,=20
like a suspend or hibernate?)

I appreciate any help I can get!

Best Regards,
Angela Dalton



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
Acpi-devel mailing list
Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
https://lists.sourceforge.net/lists/listinfo/acpi-devel


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
