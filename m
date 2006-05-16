From: Vladimir Florinski <vflorins@ucr.edu>
Subject: External monitor switching problem on Lenovo Thinkpad X60s
Date: Mon, 15 May 2006 22:52:35 -0700
Message-ID: <1147758755.19165.20.camel@zeos>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ylpvm01-ext.prodigy.net ([207.115.57.32]:29590 "EHLO
	ylpvm01.prodigy.net") by vger.kernel.org with ESMTP
	id S1751469AbWEPFwi (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 16 May 2006 01:52:38 -0400
Received: from pimout3-ext.prodigy.net (pimout3-int.prodigy.net [207.115.4.218])
	by ylpvm01.prodigy.net (8.12.10 outbound/8.12.10) with ESMTP id k4G5qXpW027422
	for <linux-acpi@vger.kernel.org>; Tue, 16 May 2006 01:52:33 -0400
Received: from [192.168.0.2] (adsl-69-234-239-143.dsl.irvnca.pacbell.net [69.234.239.143])
	by pimout3-ext.prodigy.net (8.13.6 out.dk/8.13.6) with ESMTP id k4G5qafm046606
	for <linux-acpi@vger.kernel.org>; Tue, 16 May 2006 01:52:36 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linux-ACPI mailing list <linux-acpi@vger.kernel.org>

Folks,

Monitor switching does not work on my machine (Thinkpad X60s). The video
is Intel 945GM, and I am running kernel 2.6.16 in Fedora Core 5. It is
impossible to get a picture on an external monitor. Writing
to /proc/acpi/ibm/video has no effect - I would write 'crt_enable' , but
it is still shown as disabled:

$cat /proc/acpi/ibm/video
status:         supported
lcd:            enabled
crt:            disabled
dvi:            disabled
auto:           enabled
commands:       lcd_enable, lcd_disable
commands:       crt_enable, crt_disable
commands:       dvi_enable, dvi_disable
commands:       auto_enable, auto_disable
commands:       video_switch, expand_toggle

(video switching hotkey Fn-F7 doesn't work either, although all others
do).

dmesg shows there are two video output devices:
ACPI: Video Device [VID] (multi-head: yes  rom: no  post: no)
ACPI: Video Device [VID] (multi-head: yes  rom: no  post: no)

and there are two /proc/acpi/video/VID directories. Could this be
confusing the kernel? I looked in the decompiled DSDT code and, while I
don't understand what it does (not being a developer) I can see that
there are two VID devices there (_SB.PCI0.VID and _SB.PCI0.AGP.VID) and
it looks like video switching routines are different for the two. This
is just my guess, but could this be what causes the problem?

By the way, video switching works fine with IBM DOS v.5 (1991 version).

Could someone shed some light on this issue? I would be happy to provide
any additional info, DSDT tables, etc.

Regards,

-- 
Vladimir Florinski <vflorins@ucr.edu>

