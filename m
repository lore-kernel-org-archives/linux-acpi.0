From: Yu Luming <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [RFC] generic acpi hotkey
Date: Fri, 13 Jan 2006 09:49:37 +0800
Message-ID: <200601130949.38988.luming.yu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Matthew Garrett <mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org>, Karol Kozimor <sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>, borislav-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, john-wanGne27zNesTnJN9+BGXg@public.gmane.org, Stelian Pop <stelian-ibX4/ixPftWsTnJN9+BGXg@public.gmane.org>, Timo Hoenig <thoenig-l3A5Bk7waGM@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

				ACPI hotkey ver.0.03
				Luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
				1/13/2005

A. What Is Hot-Key?
B. Hot-key implementation And Support in Kernel.
C. How to Support Hotkey through Generic Hotkey Driver?
	C.1 What doesn't work
	C.2 What does Generic Hotkey Work
	C.3 Successful story
D. Investigation Reports
	IBM Thinkpad T42: (IBM0068)
	Fujitsu Lifebook S6130: (Fuj02b1)
	Toshiba Satellite M20:
	Sony T26 (SNY5001)
	Sony PCG-Z1XZC
	Acer Aspire 1522
	Panasonic Toughbook CF-51: (MAT0019)
E. ACPI Video control driver
F. SYSFS Support.
G. call For Action

A. What is Hot-key?

1. Keyboard keys, handled by the keyboard driver/Linux input 
sub-system/X-window system. Some platforms add additional keys to the 
keyboard hardware, and the input sub-system needs to be augmented to 
Understand them through utilities to map scan-codes to characters, or 
though model-specific keyboard drivers.

2. Power, Sleep, and Lid buttons. These three buttons are fully described by 
the ACPI specification. The kernel's ACPI button.c driver sends these events 
to user space via /proc/acpi/event. A user space utility such as acpid(8) is 
responsible for deciding what to do with them. Typically shutdown is invoked 
on power button events, and suspend is invoked for sleep or lid button 
events.

3. The "other" keys are generally called "hotkeys," and have icons on them 
describing various functions such as display output switching, LCD 
brightness control, WiFi radio, audio volume control etc.

B. Hot-key Implementation And Support In Kernel.

Hot-keys may be implemented in a variety of ways, even within the same 
platform.

1. Full BIOS control: Here hot-keys trigger an SMI, and the SMM BIOS will 
handle everything. Using this method, the hotkey is invisible to the 
kernel-- to the OS they are effectively done "in hardware."
The advantage is that the buttons will do their functions successfully, even 
in the presence of an ignorant or broken OS. The disadvantage is that OS is 
completely un-aware that these functions are occurring and thus has no 
opportunity to optimize its policies. Also, as the SMI/SMM is shipped by the 
OEM in the BIOS, users are unable to either fix it when it is broken, or 
customize it in any way.
Some systems include this SMI-based hotkey mechanism, but disable it when an 
ACPI-enabled OS boots and puts the system into ACPI-mode.

2. Self-contained AML methods: from a user's-- even a kernel programmer's -- 
point of view, method is analogous to the full-BIOS control method above. The 
OS is un-aware that the button is pressed and what the button does. However, 
the OS actually supplies the mechanics for this kind of button to work, It 
would not work if the OS's interrupts and ACPI AML interpreter were not 
available.
Here a GPE causes an ACPI interrupt. The ACPI sub-system responds to the 
interrupt, decodes which GPE caused it. and vectors to the associated 
BIOS-supplied GPE handler (_Lxx/_Exx/_Qxx). The handler is supplied by the 
BIOS in AML, and the kernel's AML interpreter make it run, but the OS is not 
informed about what the handler does. The handler in this scenario is 
hard-coded to tickle whatever hardware is necessary to implement the 
button's function.

3. Event based: This is a platform-specific method. Each hotkey event 
triggers a corresponding hotkey event from /proc/acpi/event to notify user 
space daemon, such as acpid. Then acpid must execute corresponding AML 
methods for hotkey function.

4. Polling based: Another non-standard implementation. Each hot-key 
pressing will trigger a polling event from /proc/acpi/event to notify user 
space daemon acpid to query the hot-key status. Then acpid should call 
related AML methods.

5. Others.

Today there are several platform specific ACPI drivers in the kernel tree 
such as asus_acpi.c, ibm_acpi.c, and toshiba_acpi.c, and there are even more 
of this group out-of-tree. The problem with these drivers is that they work 
only for the platforms they're designed for. If you don't have that 
platform, it doesn't help you. Also, the different drivers perform largely 
the same functions. There are many different platform vendors, and so 
producing and supporting a platform specific driver for every possible 
vendor is not a good strategy. So this year several efforts have been made 
to unify some of this code, with the goal that the kernel contain less code 
that works on more platforms.

C. How To Support Hotkey Through Generic Hotkey Driver?
 
The goal Generic Hotkey driver is to factor the common code out of 
the platform-specific drivers. This driver is intended to support two non-standard
hot-key implementations-event-based and polling-based.

The idea is that configurable interfaces can be used to register mappings 
between event number and GPEs associated with hot-keys, and mappings between 
event number and AML methods, then we don't need the platform specific 
drivers. Here the user-space daemon, acpid, needs to issue a request to an 
interfaces for the execution of those AML methods, upon receiving a specific 
hot-key GPE. So, the generic hot-key driver implements the following 
interfaces to meet the requirements of non-standard hot-key.

C.1 What doesn't Work?

Based on the fact of my recent investigation on how hotkey 
get supported on IBM T42 and several others, It is proved that
my proposal of generic hotkey driver (hotkey.c) is NOT practical to
the laptops controlling hotkey function in native or synthetical way.

For example, on my T42, pressing key Fn+home (increase brightness)
cause EC gpe, in turn call _Q14, then brightness increases.
According to assumption of generic hotkey driver, if I directly invoke
_Q14,  it should work too. Unfortunately, my testing shows this assumption is
wrong for this T42.  But, ibm_acpi.c works.  I did the following test:
echo  level  2 > /proc/acpi/ibm/video ,  brightness magically changed.
>From the execution log, I found the only difference was 
ibm_acpi.c wrote brightness value at a magic place on EC.
And, I believe ibm_acpi.c is a reverse engineered work. 
So, I think I CANNOT cleanly integrate the functionality of ibm_acpi.c
into hotkey.c like what I did for sony_acpi.c.  In that case, brightness control
and video output switch control are wrapped in AML method respectively.

C.2 What does Generic Hotkey Work?

1. There are dedicated AML methods for hot-keys.
2. There are dedicated Hotkey devices and dedicated AML methods for hot-keys.

C.3 Successful Story

1. Ported sony_acpi.c to hotkey.c.
2. Ported panasonic_acpi.c to hotkey.c
3. Fujitsu 1630 works in hotkey.c
4. ASUS A6B works in hotkey.c
Notes: The patch will be released.

D. Investigation Reports

ibm_acpi.c (in kernel)
sony_acpi.c sonypi.c (in suse 10 )
panasonic_acpi.c (in SuSE 10)
asus_acpi.c (in base kernel)
toshiba_acpi.c (in base kernel)

IBM Thinkpad T42: (IBM0068)
        AML:
        Name (_HID, EisaId ("IBM0068"))
        ibm_acpi.c

Fujitsu Lifebook S6130: (Fuj02b1)
        AML:
	\_SB.PCI0.LPC0.FJEX.SBLL can change brightness manually.

Toshiba Satellite M20:
        AML:
        1. video switch: _Q25, manually invoking _Q25 works.


Sony T26 (SNY5001)
Sony PCG-Z1XZC
	AML:
	1.described in sony_acpi.c
	

ASUS  A6BVC: (ATK0100)
	AML:
	0. ACPI Device: ATK0100
	1. video switch:: -Q21
	2. brightness : _Q0E, _Q0F, 
	3. directly inovking works.

Panasonic Toughbook CF-51: (MAT0019)
	AML
	1. ACPI Device: MAT0019


E. ACPI Video control driver

The ACPI specification includes an appendix describing ACPI Extensions for 
Display Adapters. This year, Bruno Ducrot created the initial acpi/video.c 
driver to implement it. This driver registers notify handlers on the ACPI 
video device to handle events. It also exports files in /proc for manual 
control. The notify handlers in the video driver are sufficient on many 
machines to make the display control hot-keys work. This is because the AML 
GPE handlers associated with these buttons simply issue a Notify event on 
the display device, and if the video.c driver is loaded and registered on 
that device, it receives the event and invokes the AML methods associated 
with the request via the ACPI interpreter.

F. SYS FS Support.
There will have unified input interface under /sys/hotkey.
/sys/hotkey/brightnessss
/sys/hotkey/output_device
/sys/hotkey/sound_volume
/sys/hotkey/video_zoom

G. Call For Action
Please take a look at patchs filed at http://bugzilla.kernel.org/show_bug.cgi?id=5749.
Please give it a run if it fit your laptop, any feedbacks are appreciated.

The hot-keys on keyboard for brightness, sound volume, display output switching
is very popular and remain stable ,because user needs these buttons. 

For each ODM, if they implement hot-keys with dedicated ACPI devices and dedicated 
AML methods. It doesn't make any sense to change the name on new platforms for 
supporting same hot-keys.

We need a hotkey interface defined in ACPI spec for those well-know hot-keys now.
Then, we can look forward to a clean hotkey driver in the future.


-- 
Thanks,
Luming
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
