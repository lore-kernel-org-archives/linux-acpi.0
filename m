From: "Johnson, Charles F" <charles.f.johnson@intel.com>
Subject: RE: External monitor switching problem on Lenovo Thinkpad X60s
Date: Tue, 16 May 2006 08:43:49 -0700
Message-ID: <4D6E93A290A3B348B3AD8B1758A1EA0C6F11DC@orsmsx413.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:47722 "EHLO
	azsmga101-1.ch.intel.com") by vger.kernel.org with ESMTP
	id S1751241AbWEPPoj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 16 May 2006 11:44:39 -0400
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Brown, Len" <len.brown@intel.com>, Vladimir Florinski <vflorins@ucr.edu>, Linux-ACPI mailing list <linux-acpi@vger.kernel.org>

The X11 2D driver (i810) included in FC5 does not have 945GM support. 

By default SuSE is just enabling clone mode in the X11 config file.  Has
nothing to do with ACPI or hotkey switching.
It is likely in you /etc/X11/xorg.conf file, you add the following to
the "Device" section where the "i810" driver parameters are set, then
the external display will be enabled:

Option   "Clone" "yes"
Option    "MonitorLayout" "CRT,LFP"

I just copied this out of the xorg.conf from SLED 10 RC1.

Charles Johnson
Channel Platform Solutions Group
Intel Corporation
charles.f.johnson@intel.com
503-712-5181
 

>-----Original Message-----
>From: linux-acpi-owner@vger.kernel.org 
>[mailto:linux-acpi-owner@vger.kernel.org] On Behalf Of Brown, Len
>Sent: Monday, May 15, 2006 11:43 PM
>To: Vladimir Florinski; Linux-ACPI mailing list
>Subject: RE: External monitor switching problem on Lenovo Thinkpad X60s
>
>I have a Dell i6400 with the same hardware that works.
>I run SuSE Linux 10.1 on it, and X comes up by default
>with dual monitor support enabled.  I have not tried
>FC5 on it yet.
>
>-Len 
>
>>-----Original Message-----
>>From: linux-acpi-owner@vger.kernel.org 
>>[mailto:linux-acpi-owner@vger.kernel.org] On Behalf Of 
>>Vladimir Florinski
>>Sent: Tuesday, May 16, 2006 1:53 AM
>>To: Linux-ACPI mailing list
>>Subject: External monitor switching problem on Lenovo Thinkpad X60s
>>
>>Folks,
>>
>>Monitor switching does not work on my machine (Thinkpad X60s). 
>>The video
>>is Intel 945GM, and I am running kernel 2.6.16 in Fedora Core 5. It is
>>impossible to get a picture on an external monitor. Writing
>>to /proc/acpi/ibm/video has no effect - I would write 
>>'crt_enable' , but
>>it is still shown as disabled:
>>
>>$cat /proc/acpi/ibm/video
>>status:         supported
>>lcd:            enabled
>>crt:            disabled
>>dvi:            disabled
>>auto:           enabled
>>commands:       lcd_enable, lcd_disable
>>commands:       crt_enable, crt_disable
>>commands:       dvi_enable, dvi_disable
>>commands:       auto_enable, auto_disable
>>commands:       video_switch, expand_toggle
>>
>>(video switching hotkey Fn-F7 doesn't work either, although all others
>>do).
>>
>>dmesg shows there are two video output devices:
>>ACPI: Video Device [VID] (multi-head: yes  rom: no  post: no)
>>ACPI: Video Device [VID] (multi-head: yes  rom: no  post: no)
>>
>>and there are two /proc/acpi/video/VID directories. Could this be
>>confusing the kernel? I looked in the decompiled DSDT code 
>and, while I
>>don't understand what it does (not being a developer) I can see that
>>there are two VID devices there (_SB.PCI0.VID and 
>_SB.PCI0.AGP.VID) and
>>it looks like video switching routines are different for the two. This
>>is just my guess, but could this be what causes the problem?
>>
>>By the way, video switching works fine with IBM DOS v.5 (1991 
>version).
>>
>>Could someone shed some light on this issue? I would be happy 
>>to provide
>>any additional info, DSDT tables, etc.
>>
>>Regards,
>>
>>-- 
>>Vladimir Florinski <vflorins@ucr.edu>
>>
>>-
>>To unsubscribe from this list: send the line "unsubscribe 
>>linux-acpi" in
>>the body of a message to majordomo@vger.kernel.org
>>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>-
>To unsubscribe from this list: send the line "unsubscribe 
>linux-acpi" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
