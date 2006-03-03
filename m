From: Michael Schierl <schierlm@gmx.de>
Subject: Re: Resume problems on Fujitsu-Siemens AMILO M7440G
Date: Fri, 03 Mar 2006 19:59:02 +0100
Message-ID: <440891F6.1030404@gmx.de>
References: <44076762.404@gmx.de> <1141349791.19013.1.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:64155 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751067AbWCCS6y (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 3 Mar 2006 13:58:54 -0500
In-Reply-To: <1141349791.19013.1.camel@sli10-desk.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Shaohua Li <shaohua.li@intel.com>
Cc: linux-acpi@vger.kernel.org

Shaohua Li schrieb:

> Did the keyboard response after resume?

it works even better. If I compile in sysrq support, I can reboot the
box after "resume" by pressing alt+sysrq+b.

when I do

mount /sys
setleds +caps
echo mem >/sys/power/state
setleds +num

the num lock LED switches on after "resume". When adding a while loop

while true; do
setleds +num
setleds -num
done

the num lock LED flashes as expected, so the notebook is still running,
yet quite disconnected from the outside world.

however, when I do not do setleds before suspend, or when I do any other
action that accesses my hard disk before turning on the led, it does not
work. So I guess the hard disk has some problems with suspend as well.

anything else to try?

Michael
