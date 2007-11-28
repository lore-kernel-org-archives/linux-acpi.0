From: Roman Zimmermann <mereandor@gmail.com>
Subject: System freeze when accessing hwclock (hp dv6155eu)
Date: Wed, 28 Nov 2007 20:25:49 +0100
Message-ID: <200711282025.49737.mereandor@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.190]:54368 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752346AbXK1T1i (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 28 Nov 2007 14:27:38 -0500
Received: by nf-out-0910.google.com with SMTP id g13so1519146nfb
        for <linux-acpi@vger.kernel.org>; Wed, 28 Nov 2007 11:27:36 -0800 (PST)
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hi!

I ran into an problem while setting up linux on a laptop (HP dv6155eu; amd64  
cpu). I'm posting here because I found some pointers to ACPI and DSDT 
problems when I searched for this.

When I (or the init scripts) access the hwclock the system often - not 
always - freezes. It never worked for more than 5 times in a row. This are 
the commands that I used to test it:

hwclock --show 
and
hwclock --directisa --show

I did test this with various kernel versions and different distributions (grml 
amd64+i386, kubuntu 7.04 i386, gentoo amd64).
It seems that everything works well on i386 systems, while on all amd64 
systems it freezes. It also seems to work on grml amd64 when I pass acpi=off 
as kernel-option and loaded the rtc kernel module afterwards.
I was unable to test it with kubuntu 7.10 amd64/i386 because both versions 
froze at boot time, with a blank screen, which may or may not be connected 
with this problem.
Windows XP seems to work fine on this laptop.

If this is not the right place to request help with this problem, please tell 
me where it would be better suited.

Please tell me what information you'd need to help me.

greetings
Roman
