From: Norbert Preining <preining@logic.at>
Subject: 2.6.12-rc1-mm4 and suspend2ram (and synaptics)
Date: Fri, 1 Apr 2005 00:08:22 +0200
Message-ID: <20050331220822.GA22418@gamma.logic.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S262015AbVCaWIo@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, acpi-devel@lists.sourceforge.net
List-Id: linux-acpi@vger.kernel.org

Dear Andrew, dear developers!

Since 2.6.12-rc1-mmX I cannot get suspend2ram working again as it was
with 2.6.11-mm4 with the same .config.

I suspends fine, but never resumes. No CapsLock, no sysrq, no network i=
s
working. Nothing in the log files. Is there anything which may cause
these troubles when compiled into the kernel and not loaded as module?
(as it was with my usb stuff until 2.6.11-mm2, after this I had to stop
hotplug, before I could go with usb running).


On a side node: Once suspend2ram couldn't stop all tasks, in fact
cpufreq, although it was stopped with /etc/init.d/cpufreqd stop, was
mentioned in syslog as not being able to be stopped, and after this
halfway through suspend, my touchpad (synaptics) and kbd wasn't working
anymore.  After resume the touchpad is somehow behaving strange.
THe touchpad is not working at all, the keyboard seems to react to some
events (Sysrq is working, but normal typing not, nor power button/acpi
stuff).

In the syslog I find:
vmunix: psmouse.c: TouchPad at isa0060/serio1/input0 lost synchronizati=
on, throwing 4 bytes away.
vmunix: psmouse.c: TouchPad at isa0060/serio1/input0 lot sync at byte 1

I would be happy to test some stuff to get S2R back to work!

Thanks a lot and all the best

Norbert

-----------------------------------------------------------------------=
--------
Norbert Preining <preining AT logic DOT at>                 Universit=E0=
 di Siena
sip:preining@at43.tuwien.ac.at                             +43 (0) 5996=
6-690018
gpg DSA: 0x09C5B094      fp: 14DF 2E6C 0307 BE6D AD76  A9C0 D2BF 4AA3 0=
9C5 B094
-----------------------------------------------------------------------=
--------
HARBLEDOWN (vb.)
To manoeuvre a double mattress down a winding staircase.
			--- Douglas Adams, The Meaning of Liff
