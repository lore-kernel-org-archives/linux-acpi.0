From: Karol Kozimor <sziwan@hell.org.pl>
Subject: Video memory corruption during suspend
Date: Mon, 19 Jul 2004 00:52:47 +0200
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <20040718225247.GA30971@hell.org.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S264577AbUGRWwn@vger.kernel.org>
Content-Disposition: inline
To: linux-kernel@vger.kernel.org, acpi-devel@lists.sourceforge.net
List-Id: linux-acpi@vger.kernel.org

Hi,
I'm having an odd problem with video memory being corrupted during suspend.

My setup is:
ASUS L3800C laptop, Radeon M7, i845 chipset, using DRI and radeonfb.

Note that this is not specific to the kernel used, as I've been seeing 
similar corruption every now and then, most recently under 2.6.7 +
ACPICA20040715 + swsusp2.0.0.100 (S3, S4), but also under 2.4 with S1 (but 
not with S4/swsusp2).

I have a very simple script I use to suspend (i.e. basically echo $arg >
/proc/acpi/sleep), which is usually started by acpid. Once the script is
triggered (by pressing power / sleep button) and an X session is running, 
various red and green patches appear on the screen (the background image
and the tinted terminal emulator), followed by the VT switch the PM code
does. After resume and subsequent VT switch by the PM code the corruption
is still visible. The screen is properly restored by a manual VT switch.
The corruption is clearly related to the existing background pixmap, as
moving the windows does not change its pattern. Oddly enough, starting a GL
app such as glxgears and moving it into and out of focus also properly
restores the screen.

I'll be happy to provide any useful information.
Best regards,

-- 
Karol 'sziwan' Kozimor
sziwan@hell.org.pl
