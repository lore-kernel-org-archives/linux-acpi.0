From: John O'Hagan <johnohagan-q6EoVN9bke7vnOemgxGiVw@public.gmane.org>
Subject: S3 Suspend input devices problem with 2.6.12
Date: Tue, 27 Sep 2005 00:01:58 +1000
Message-ID: <200509270001.58875.johnohagan@iprimus.com.au>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
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

Hi all,
 
I'm running Debian testing on a "whitebox" (unbranded) Centrino laptop with a 
855GM chipset. Since kernel 2.6.12, suspend-to-disk (S4) has worked well, 
simply using the KDE klaptop applet.

However, suspend-to-ram (S3), which I think most laptop users find very 
useful, has proved more difficult. If I simply use the KDE applet or the 
regular command, the system resumes with a blank screen - a common problem 
with this chipset. I can get around it using vbetool, which reinitialises the 
graphics device (there is a handy packaged script called hibernate which 
walks you through this); however, the touchpad does not work on resume. 
Sometimes, depending on the hibernate settings,  neither does the 
keyboard.

Some digging has revealed that somehow the entries in /proc/bus/input have 
been shuffled around on resuming, so that the device node once used by the 
touchpad (/dev/input/event1) is now handled by the pc-speaker, or the 
(non-existent) joystick, or is absent altogether! Leaving the touchpad out in 
the cold...regardless of which touchpad driver I use. Reloading the relevant 
modules - or even all modules - has no effect.

So, my questions are: why does S3 suspend (and not S4) shuffle the devices 
around, and how can it be prevented? I notice that the keyboard and touchpad 
are initialized early in the boot process. Can they somehow be reinitialized 
after suspend? Is udev involved? Or is there a 
better solution?

Thanks,

John O'Hagan



-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
