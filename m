From: Michael Schierl <schierlm@gmx.de>
Subject: Resume problems on Fujitsu-Siemens AMILO M7440G
Date: Thu, 02 Mar 2006 22:45:06 +0100
Message-ID: <44076762.404@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.gmx.de ([213.165.64.20]:33458 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1030220AbWCBVpB (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 2 Mar 2006 16:45:01 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hi,

My new notebook, a Fujitsu-Siemens AMILO M7440G, does not resume after
suspend (echo mem >/sys/power/state).

Since my old notebook worked with APM, ACPI stuff is quite new for me; I
 tried several things but with no success.

What happens:

- I boot a minimal kernel (vanilla 2.6.15.2), with init=/bin/bash to
  minimize userspace problems (root fs = ext3, mounted read only)
- I mount /sys and echo mem >/sys/power/state
- my notebook seems to suspend properly, everything powers down, power
  LED is flashing. (I cannot eject CD now)
- when pressing the power button (the notebook cannot be waken up by
  pressing keys on the keyboard, but that is the same on Windows, so
  most likely by design), the power LED changes to light (without
  flashing), and the CDROM spins up. (Now I can eject CD). Screen is
  dark and remains so until I power it down hard (by pressing power
  button for 5 seconds).
- when compiling in network support and netconsole support (and enabling
  netconsole to maybe get error messages), the
  behaviour changes: the CDROM still spins up but the power LED remains
  flashing. (you can find the .config at
  http://home.arcor.de/mschierlm/test/acpi/_config ) No reaction on the
  net console after suspend.
- The notebook does not have any serial ports.

Next I patched the kernel with acpi-release-20050902-2.6.15.diff.bz2, no
changes. Patching it with acpi-test-20051216-2.6.15.diff.bz2 (after
unapplying the old patch), no changes either. The reaction with a
"non-minimal" kernel is like the one with the minimal one.

Next I downloaded acpica-unix-20060217.tar.gz and decompiled my DSDT.
Result is in same place as _config. Recompiling it only creates one
warning about no return value in _WAK. There are lots of tutorials
around, some say it does not matter, others say I should add a return
value. So I added a return value, but did not notice any changes in
behaviour.

The next issue was to check if the dsdt uses any _OS checks. The only
match for _OS in the file is in line

If (CondRefOf (_OSI, Local0))

which is quite unrelated I guess (I don't understand that ACPI
"programming language", but it seems that _OSI is something else than
_OS). So if I understood the tutorial correctly, there is no need to try
different ACPI os names.

I'm out of ideas now.

Any suggestions what to do to make my new notebook suspend on Linux? It
suspends fine on Windows and the latest BIOS update is installed.

Please CC me since I am not on the list. Thank you,

Michael
