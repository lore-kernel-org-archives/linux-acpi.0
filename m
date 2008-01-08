From: Jan-Simon =?iso-8859-1?q?M=F6ller?= <dl9pf@gmx.de>
Subject: Re: Brightness control keys got lost
Date: Tue, 8 Jan 2008 23:30:02 +0100
Message-ID: <200801082330.02736.dl9pf@gmx.de>
References: <200712282300.51705.dl9pf@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:40704 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752516AbYAHWaG (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 8 Jan 2008 17:30:06 -0500
In-Reply-To: <200712282300.51705.dl9pf@gmx.de>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org


I updated http://bugzilla.kernel.org/show_bug.cgi?id=9663 with some checked 
kernel version:

I checked these builds now:
2.6.23-acpi.git (~ Aug/Sep 07)  with _and_ without acpi=off -> WORKS
2.6.24-rc6 from git  with no cmdline-option -> works NOT
2.6.24-rc6 from git  with acpi=off -> WORKS !!

I'm running a openSuSE 10.3 with updated kernels, because of sound, wlan and
acpi.

I'm just compiling a checkout of rc7. Will report. If you need some
lsmod/dmesg/acpidumps from these environments, drop me a note please.
