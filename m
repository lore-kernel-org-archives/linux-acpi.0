From: Len Brown <lenb@kernel.org>
Subject: Re: ACPI issue
Date: Thu, 16 Aug 2007 03:25:08 -0400
Message-ID: <200708160325.08515.lenb@kernel.org>
References: <200708152212.31812.robertg.123@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:55527 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754988AbXHPHZP (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 16 Aug 2007 03:25:15 -0400
In-Reply-To: <200708152212.31812.robertg.123@gmail.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Robert Gomulka <robertg.123@gmail.com>
Cc: linux-acpi@vger.kernel.org

On Wednesday 15 August 2007 18:12, Robert Gomulka wrote:
> Hello,
> I have just bought Compaq 572US laptop with AMD X64 dual core on board. I 
> installed Debian Etch on it. After first reboot I experienced many problems 
> with system freeze at many random moments. I had no idea what to do, as a 
> blind shot I disabled acpi in boot parameters (acpi=off). Those problems 
> disappeared and my system works for an hour fine (previously it was a 
> question of minutes).
> I have read article about ACPI myths and found this e-mail address there. What 
> steps would you suggest next in order to improve my system situation with 
> ACPI?

Start by upgrading to a 2.6.22.stable kernel.

If you still have problems with ACPI mode, then open a bug report here:
http://bugzilla.kernel.org/enter_bug.cgi?product=ACPI

and attach the output from dmesg -s64000 from the default and acpi=off boots.
check that the driver to IRQ mapping in /proc/interrupts is the same
in both cases.

Look if there is a temperature reported under /proc/acpi/thermal_zone/*/temperature
and see if perhaps your system is getting hot when it fails.  Make a note
if you can hear the fans turn on/off, and at what temperature.

provide the output from acpidump in the bug report.

thanks,
-Len
