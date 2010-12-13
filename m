From: Sedat Dilek <sedat.dilek@googlemail.com>
Subject: Re: [PATCH 0/13] ACPI / PM: Rework power resources management
Date: Mon, 13 Dec 2010 16:43:18 +0100
Message-ID: <AANLkTinarEEaJMLORBV9YozJ3GnFFVMJ-NOQhzRVJ0en@mail.gmail.com>
References: <AANLkTimahUpEL3cV6pFhkN8KqrphfVMSOw8xAN2=9jPy@mail.gmail.com>
Reply-To: sedat.dilek@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-qy0-f181.google.com ([209.85.216.181]:60095 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753151Ab0LMPnT (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 13 Dec 2010 10:43:19 -0500
In-Reply-To: <AANLkTimahUpEL3cV6pFhkN8KqrphfVMSOw8xAN2=9jPy@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: LKML <linux-kernel@vger.kernel.org>, len.brown@intel.com, Linux ACPI <linux-acpi@vger.kernel.org>, Matthew Garrett <mjg@redhat.com>, platform-driver-x86@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>

Hi Rafael,

nice to see your patchset is in linux-next (next-20101213) now.
More precisely in linux-acpi-2.6: 1/13 + 2/13 in release and rest/13
in test GIT branch.

What about the fix
"Platform-x86-Make-fujitsu_laptop-use-acpi_bus_update_power.patch"
[1]?
Will this go over platform-x86/linux-next into linux-next GIT tree?
Are you co-ordinating this with mjg?

Regards,
- Sedat -

[1] https://patchwork.kernel.org/patch/357422/
[2] http://git.kernel.org/?p=linux/kernel/git/mjg59/platform-drivers-x86.git;a=shortlog;h=refs/heads/linux-next
