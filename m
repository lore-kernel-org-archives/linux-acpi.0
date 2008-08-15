From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: ACPI-related bug caused poor responsitivity (2.6.26.x line)
Date: Fri, 15 Aug 2008 10:35:18 +0800
Message-ID: <1218767718.3209.40.camel@rzhang-dt>
References: <20080814211348.GA6268@sarge.my.own.domain.no-net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:3226 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752347AbYHOCfe (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 14 Aug 2008 22:35:34 -0400
In-Reply-To: <20080814211348.GA6268@sarge.my.own.domain.no-net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zbigniew Baniewski <zb@ispid.com.pl>
Cc: linux-acpi@vger.kernel.org

On Thu, 2008-08-14 at 23:13 +0200, Zbigniew Baniewski wrote:
> Hallo,
> 
> There are so many issues reported during last 3 months, that I'm not sure,
> whether (or not) someone wrote about the problem. But few words anyway:
> 
> I noticed, that using new kernels (tested 2.6.26 and 2.6.26.2), there are
> typical for ACPI-related problems troubles with responsitivity. For example:
> if I'm opening "bloated" web page using Opera, one can't move the mouse
> cursor smoothly around the screen; there is a "jitter" during the movement,
> and any output (like GKrellm's diagrams created in real time) for that 2-3
> seconds is "frozen". As I've found googling around, these are rather typical
> ACPI-related problems, and indeed: forcing "acpi=off" was the cure.
> 
> Additionally I noticed, that there are no such problems while using older
> kernel 2.6.25.2 - so something bad happened during the period "between"
> 2.6.25.2 and 2.6.26.
> 
> Attached gzipped dmesg's messages; those described "aon" are with ACPI
> switched on, and - respectively - "aoff" with ACPI off.
> 
> Tested under Debian Etch, Pentium III 700, mobo Gigabyte GA-6BX7 with newest
> BIOS available.

Please check if it's a duplicate of bug
http://bugzilla.kernel.org/show_bug.cgi?id=11141

thanks,
rui

