From: Johannes Engel <j-engel@gmx.de>
Subject: Suspend2RAM Asus V6V
Date: Sat, 05 May 2007 01:36:09 +0200
Message-ID: <463BC369.7010309@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:46836 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754655AbXEDXfn (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 4 May 2007 19:35:43 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hello everyone listening!

Since my laptop does not wake up from suspend2RAM under Linux I want to
get rid of that problem. I hope someone can help me here.

My system:
Asus V6V (Pentium M 740, intel ICH6)
openSuSE 10.2
Kernel 2.6.21.1 vanilla (also tested with suspend2 patch), same symptoms
using original openSuSE kernel
suspend-0.50-6

Symptoms:
I tried the various options and combinations of s2ram also from init
level 1. The symptoms remain as follows:
The laptop goes down to suspend2ram, if it is suspended the power led
starts blinking as it is supposed to do.
Switching the laptop on again hitting the power button (other buttons do
not show any effect) the cdrom drive gets initialised, the harddisk led
gets switched on but the screen remains black and the laptop hangs
completely (no keystroke accepted, even not Magic SysRq keys).

Do you have any hint where I can start digging (DSDT, BIOS, drivers)?

Thank you in advance,

Johannes
