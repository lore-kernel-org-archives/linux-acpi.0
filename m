From: Manuel Serrano <Manuel.Serrano-0GlwE4rufLnvuXihggDW+w@public.gmane.org>
Subject: Fw: Problem with ACPI and X windows on a Sony Picturebook PCG-C1MHP
Date: 06 Nov 2002 15:30:05 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20021106152937.144285da.Manuel.Serrano@sophia.inria.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

Hello there, 

quite recently I have posted these bug reports to the Linux kernel mailing
list. Someone suggested me to post to the ACPI devel mailing list too.
So I'm...

Sincerely,

Begin forwarded message:

Date: 05 Nov 2002 09:54:32 +0100
From: Manuel Serrano <Manuel.Serrano-0GlwE4rufLnvuXihggDW+w@public.gmane.org>
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dwmw2@redhat.com, andrew.grover@intel.com, ptb@it.uc3m.es
Subject: Problem with ACPI and X windows on a Sony Picturebook PCG-C1MHP


From: Manuel Serrano <Manuel.Serrano-0GlwE4rufLnvuXihggDW+w@public.gmane.org>
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dwmw2@redhat.com, andrew.grover@intel.com, ptb@it.uc3m.es
Subject: Problem with ACPI and X windows on a Sony Picturebook PCG-C1MHP
Date: 05 Nov 2002 09:54:32 +0100
Sender: Manuel.Serrano-0GlwE4rufLnvuXihggDW+w@public.gmane.org
Organization: Inria

Hello there,

Here is the description of the second problem I have when running Linux
on my Sony Picturebook PCG-C1MHP. This time, it concerns the ACPI support.
I have actually two problems with ACPI. Let's start with the first one
(the most important one).

[1.] One line summary of the problem:
=====================================

Accessing ACPI files insert spurious characters in X's windows (such as Xterm,
Emacs, ...)

[2.] Full description of the problem/report:
============================================

ACPI works in the sense that it provides significant and relevant information.
Actually I'm using the following modules:

ospm_thermal (for proc temperature)
ospm_battery (for battery charge level)
ospm_ac_adapter (for checking if we are on/off-line)
ospm_bsmgr (which is, as far as I have understood used by the other modules)

Up to now every thing is fine, loading these modules enable access to
/proc/acpi/XXX/XXX/{status,info} files. Perfect. The problem is that 
reading any of these files has a very cumbersome effect. It seems to
generate interruptions that act as key press. The consequence is that
if simultaneously you access a /proc/acpi/XXXX file and you move the mouse
over an Xterm or an Emacs window, the window is filled out with random
characters! The best way to illustrate the problem is by running a loop
such as:

while : ; do 
  cat /proc/acpi/ac_adapter/0/status
done

and then moving the mouse over and Xterm. Each time we move the mouse, each
time a new random character is displayed. 

In addition to my previous shell loop, I run in another Xterm the following:

while : ; do
  cat /proc/interrupts
done

This last file shows:

-----|-----|-----|-----|-----|-----|-----|-----|-----|-----|-----|-----|-----
  0:      64839          XT-PIC  timer
  1:        487          XT-PIC  keyboard
  2:          0          XT-PIC  cascade
  8:          3          XT-PIC  rtc
  9:       4414          XT-PIC  acpi, eth0, Ricoh Co Ltd RL5c475, ALi Audio Accelerator
 12:        993          XT-PIC  PS/2 Mouse
 14:       9315          XT-PIC  ide0
NMI:          0 
ERR:          0
           CPU0       
  0:      64840          XT-PIC  timer
  1:        488          XT-PIC  keyboard
  2:          0          XT-PIC  cascade
  8:          3          XT-PIC  rtc
  9:       4414          XT-PIC  acpi, eth0, Ricoh Co Ltd RL5c475, ALi Audio Accelerator
 12:        993          XT-PIC  PS/2 Mouse
 14:       9315          XT-PIC  ide0
NMI:          0 
ERR:          0
-----|-----|-----|-----|-----|-----|-----|-----|-----|-----|-----|-----|-----

That is, my impression is that each time I access the /proc/acpi/XXX files,
the keyboard interrupt counter is incremented!

Now let's go to the real strange thing. If in addition to the previously
loaded modules (the ones describe in section 7.3 above), I load the two
additional modules: usbcore and usb-ohci the problem totally disappear! 
That is, when loading these two additional modules, accessing the /proc/acpi
files and moving the mouse simultaneously does not introduce spurious
characters anymore!

You could think that, loading the two additional modules is a simple 
workaround... Well actually it is but, loading the two usb modules introduce,
in turn, new problems that I will describe in a next bug report...

[3.] Keywords (i.e., modules, networking, kernel):
==================================================


-- 
Manuel


-------------------------------------------------------
This sf.net email is sponsored by: See the NEW Palm 
Tungsten T handheld. Power & Color in a compact size!
http://ads.sourceforge.net/cgi-bin/redirect.pl?palm0001en
