From: Nigel Cunningham <nigel@nigel.suspend2.net>
Subject: Re: [linux-pm] Re: [patch] hibernation: utilize ACPI hardware signature
Date: Thu, 03 Jan 2008 19:31:13 +1100
Message-ID: <477C9D51.5000604@nigel.suspend2.net>
References: <1199257162.14632.4.camel@sli10-desk.sh.intel.com> <200801021505.39789.rjw@sisk.pl> <477C019D.1070001@nigel.suspend2.net> <200801022301.45706.rjw@sisk.pl>
Reply-To: nigel@nigel.suspend2.net
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from home.nigel.suspend2.net ([203.171.70.205]:33686 "EHLO
	server1.example.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756722AbYACIbQ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 3 Jan 2008 03:31:16 -0500
In-Reply-To: <200801022301.45706.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Shaohua Li <shaohua.li@intel.com>, linux acpi <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Pavel Machek <pavel@suse.cz>

Hi.

Rafael J. Wysocki wrote:
>> I suppose we can always disable this when we start to support hardware
>> changing over hibernate (I have ideas in this direction - memory cold
>> plugging, for a start).
> 
> Well, if we support such features, we won't be following ACPI any more.

Mmm. Apparently I'm not as focused on specs as you :).

I was starting to think through whether it could make for a new and much
faster was to boot live cds - something along the lines of complete
redetection of hardware and memory cold plugging. Of course it's only in
the 'I wonder if this would be possible' stage at the mo, but seemed at
least feasible - keep the e820 tables from boot, make _init routines not
get thrown away and do something like the kexec device shutdown etc
around an atomic restore.

I know there'd be limitations, but perhaps worth thinking about...

Nigel
