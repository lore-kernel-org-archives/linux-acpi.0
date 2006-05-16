From: "Brown, Len" <len.brown@intel.com>
Subject: RE: External monitor switching problem on Lenovo Thinkpad X60s
Date: Tue, 16 May 2006 02:42:50 -0400
Message-ID: <CFF307C98FEABE47A452B27C06B85BB675ABCF@hdsmsx411.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:8277 "EHLO
	azsmga101-1.ch.intel.com") by vger.kernel.org with ESMTP
	id S1751518AbWEPGmx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 16 May 2006 02:42:53 -0400
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Vladimir Florinski <vflorins@ucr.edu>, Linux-ACPI mailing list <linux-acpi@vger.kernel.org>

I have a Dell i6400 with the same hardware that works.
I run SuSE Linux 10.1 on it, and X comes up by default
with dual monitor support enabled.  I have not tried
FC5 on it yet.

-Len 

>-----Original Message-----
>From: linux-acpi-owner@vger.kernel.org 
>[mailto:linux-acpi-owner@vger.kernel.org] On Behalf Of 
>Vladimir Florinski
>Sent: Tuesday, May 16, 2006 1:53 AM
>To: Linux-ACPI mailing list
>Subject: External monitor switching problem on Lenovo Thinkpad X60s
>
>Folks,
>
>Monitor switching does not work on my machine (Thinkpad X60s). 
>The video
>is Intel 945GM, and I am running kernel 2.6.16 in Fedora Core 5. It is
>impossible to get a picture on an external monitor. Writing
>to /proc/acpi/ibm/video has no effect - I would write 
>'crt_enable' , but
>it is still shown as disabled:
>
>$cat /proc/acpi/ibm/video
>status:         supported
>lcd:            enabled
>crt:            disabled
>dvi:            disabled
>auto:           enabled
>commands:       lcd_enable, lcd_disable
>commands:       crt_enable, crt_disable
>commands:       dvi_enable, dvi_disable
>commands:       auto_enable, auto_disable
>commands:       video_switch, expand_toggle
>
>(video switching hotkey Fn-F7 doesn't work either, although all others
>do).
>
>dmesg shows there are two video output devices:
>ACPI: Video Device [VID] (multi-head: yes  rom: no  post: no)
>ACPI: Video Device [VID] (multi-head: yes  rom: no  post: no)
>
>and there are two /proc/acpi/video/VID directories. Could this be
>confusing the kernel? I looked in the decompiled DSDT code and, while I
>don't understand what it does (not being a developer) I can see that
>there are two VID devices there (_SB.PCI0.VID and _SB.PCI0.AGP.VID) and
>it looks like video switching routines are different for the two. This
>is just my guess, but could this be what causes the problem?
>
>By the way, video switching works fine with IBM DOS v.5 (1991 version).
>
>Could someone shed some light on this issue? I would be happy 
>to provide
>any additional info, DSDT tables, etc.
>
>Regards,
>
>-- 
>Vladimir Florinski <vflorins@ucr.edu>
>
>-
>To unsubscribe from this list: send the line "unsubscribe 
>linux-acpi" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
