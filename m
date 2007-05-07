From: tarr qt <tarrqt@yahoo.com>
Subject: Dell Optiplex GX240 and the ACPI blacklist
Date: Mon, 7 May 2007 11:57:23 -0700 (PDT)
Message-ID: <250126.55752.qm@web63607.mail.re1.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from n10a.bullet.mail.re3.yahoo.com ([68.142.236.51]:30424 "HELO
	n10a.bullet.mail.re3.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S966205AbXEGTDb (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 7 May 2007 15:03:31 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org


Summary: If ACPI is not enabled but APIC is,
then there is trouble on Dell Optiplex GX240.
If both are enabled or if both are disabled, then
everything is fine.

Hello,

I have a Dell Optiplex GX240 and when I boot Linux, ACPI
gets set up by only acpi=ht. dmesg shows the following line:

   DELL GX240 detected: force use of acpi=ht

Everything seemed to be fine. However, I discovered that
everything is not fine. The USB controller works so slowly
that copying a few (uncached) 1 megabyte large photos from
a USB-enabled digital camera takes many minutes instead of
a couple of seconds.

I am using Linux 2.6.21.1 on a Debian 4.0 ("Etch") system.

I thought that this might be related to ACPI. So I tried
to boot with _only_ "acpi=force" appended to the kernel
command line. Voila, the USB controller started to work
at full speed and copying photos from my digital camera
took only seconds.

I tested the system with "acpi=force" and could not find
anything which did not work. So, can we please remove
Dell Optiplex GX240 from the blacklist in

..../arch/i386/kernel/acpi/boot.c

?

I thought that this might be related to interrupts and
APIC as well. (Note that this is APIC, not ACPI.) I tried
booting with _only_ "noapic" and "nolapic" appended to the
command line. Again, the USB controller started to work
at full speed.

If removing Dell Optiplex GX240 from the ACPI blacklist
is not wanted/possible, then is there a way to disable
APIC and LAPIC (note that this is APIC not ACPI) by
default on Dell GX240 machines? (I.e. Can one patch
the kernel so that APIC and LAPIC isn't used on
these machines? - I know that I can use the noapic
and nolapic options on the kernel command line.)

Thank you for your attention.

tarrqt


__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 

