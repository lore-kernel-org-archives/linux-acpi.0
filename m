From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [Xen-devel] Re: Paravirtualizing bits of acpi access
Date: Mon, 23 Mar 2009 13:42:24 -0700
Message-ID: <49C7F430.8060205@goop.org>
References: <49C484B7.20100@goop.org> <200903231920.12991.rjw@sisk.pl> <49C7DDDC.2050103@goop.org> <200903232127.40683.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from gw.goop.org ([64.81.55.164]:38434 "EHLO mail.goop.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751660AbZCWUma (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 23 Mar 2009 16:42:30 -0400
In-Reply-To: <200903232127.40683.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: "Tian, Kevin" <kevin.tian@intel.com>, "Brown, Len" <len.brown@intel.com>, Xen-devel <xen-devel@lists.xensource.com>, the arch/x86 maintainers <x86@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Cihula, Joseph" <joseph.cihula@intel.com>

Rafael J. Wysocki wrote:
> Hmm, in that case it may be more appropriate to modify
> do_suspend_lowlevel().  Have you considered doing that?
>   

do_suspend_lowlevel is in asm with 32 and 64-bit variants, so it is a 
little awkward to deal with.  But, yes, I was thinking of adding a 
do_suspend() with this logic in it, which calls do_suspend_lowlevel() as 
appropriate.

    J
