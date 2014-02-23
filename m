From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: Using intel_pstate
Date: Sun, 23 Feb 2014 02:23:20 +0100
Message-ID: <9891809.rXh9YKnm5H@vostro.rjw.lan>
References: <5309294E.2090706@ubuntu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:54284 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752070AbaBWBIZ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 22 Feb 2014 20:08:25 -0500
In-Reply-To: <5309294E.2090706@ubuntu.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Phillip Susi <psusi@ubuntu.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Saturday, February 22, 2014 05:48:46 PM Phillip Susi wrote:
> The intel_pstate driver says it should be the preferred driver on
> sandy bridge systems, but my system is using the acpi p state driver
> instead.  According to the cpufreq Makefile this appears to be
> intended as it is placed first in the link order.  Why is this and how
> can I make sure the intel_pstate driver is used instead?

Do you have CONFIG_X86_INTEL_PSTATE=y set in your .config?

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
