From: Andy Grover <agrover@redhat.com>
Subject: Re: [ibm-acpi-devel] TP Edge E220s freezes when hotkeys pressed
Date: Wed, 11 May 2011 09:42:08 -0700
Message-ID: <4DCABC60.9000103@redhat.com>
References: <4DC97328.9090200@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:26457 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753558Ab1EKR1w (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 11 May 2011 13:27:52 -0400
In-Reply-To: <4DC97328.9090200@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: ibm-acpi-devel@lists.sourceforge.net
Cc: linux-acpi@vger.kernel.org

On 05/10/2011 10:17 AM, Andy Grover wrote:
> I just got an Edge e220s, and am having some issues. If I press Fn-F7
> (lower screen brightness) two times or Fn-F8 (increase brightness) the
> laptop freezes up solid. I get an unhandled HKEY 0x6050 message from
> Fn-F7 the first time I press it, but I'm not thinking thinkpad_acpi is
> the culprit, since  the behavior is the same (2nd F7, 1st F8 freezes
> laptop) even without the module loaded.
> 
> Do you have any advice or insight into this issue, or how to diagnose
> the cause of this issue?

[ccing linux-acpi too]

Self-replying..

Apparently the hang is ACPI-related, it only happens when using ACPI
backlight controls. It works if acpi=off, but that's not really a good
solution these days. I think this means I'm out of luck without a BIOS
update -- the backlight ASL (avail on request) ends up calling a "SMI"
method, so the trail ends there.

I also found out that blacklisting the video module doesn't work,
perhaps because i915 depends on it?

Another weird thing is that acpi_backlight=vendor causes it to hang,
right before gdm screen comes up, so that's not an option either, alas.

Cmon Lenovo bios people, I thought you had a clue!

Regards -- Andy
