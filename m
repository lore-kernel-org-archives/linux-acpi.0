From: "James Shatto" <shadow.seven-xOqKmqBdiMhF6kxbq+BtvQ@public.gmane.org>
Subject: Re: Acpi-devel digest, Vol 1 #766 - 4 msgs
Date: Tue, 21 Jan 2003 04:34:26 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <000601c2c130$4a7d1ea0$64f1dc0c@insightbb.com>
References: <E18aorV-0004ws-00@sc8-sf-list2.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
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

Pardon my newness to ACPI.  That being said, I have an ACPI problem.
However inconsistent it may be.  The problem being sometimes it works, and
when it does it keeps the computer cooler than APM, maybe even cooler than
WinME.  But when it doesn't my laptop gets really hot and shuts itself down.

Is there anyway to fix this?
Should I always use APM instead of ACPI?
Should I use APM and ACPI?
(The problem here is that SonyPI conflicts with APM)

Laptop ='s Sony Vaio - PCG-FX215 - PIII 800MHz Duron
VIA Tech VT82C686 Power Management Controller

Power management details under windows:
(Control Panel->System->Device Manager)
ACPI AC Power Source
ACPI Battery
ACPI Embedded Controller
ACPI Lid
ACPI Sleep Button
ACPI System Button
Advanced Configuration and Power Interface BIOS

When this doesn't work, it only takes about 5 to 30 minutes for the computer
to get hot enough for it to shut itself down.  I am running Debian
Linux(Sarge).  With Kernel 2.4.20pre3.  I've had the same results with
earlier 2.4 kernels, even with the ac patches.  The only real extras are
SonyPI and the Alsa drivers for sound.  Is there a patch to fix this?  If
so, where would I go to find it?

Like I said it sometimes works, but it's a 50/50 chance that it doesn't
work.  Generally it works on the day I build the kernel, then any days there
after it doesn't work.  Probably useless information, but I thought I should
mention it.

The heat sources appear to be on the lower half of the machine as the upper
portion remains cooler than APM.  With majority of the heat near the PCMCIA
and Battery areas.  PCMCIA is completely omitted on my system since it tends
to hang linux(TI 1420) and I generally don't use it.  As a side note, when I
switch between APM and ACPI, I've got to recompile the alsa
modules(via82xx).

The problem is compounded by me actually using my laptop on my lap.  Which
drapes the power chord across the fan vent.  And can also partially block
this vent with clothing.  Although I do tend to use a bamboo back scratcher
to prop it up a little.  It also provide a bit of thermal insulation between
the laptop and my legs.

James Shatto
YAUCP - yet another unemployed computer programmer.
mailto:shadow.seven-xOqKmqBdiMhF6kxbq+BtvQ@public.gmane.org
mailto:Shadow_7-BBLMrNziy+9BDgjK7y7TUQ@public.gmane.org
http://home.insightbb.com/~shadow.seven/



-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
