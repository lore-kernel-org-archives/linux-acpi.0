From: Baoquan He <bhe@redhat.com>
Subject: Re: [Patch v2] lapic need be checked if available when initialize
 acpi processor id
Date: Fri, 2 May 2014 16:51:46 +0800
Message-ID: <20140502084707.GA1572@dhcp-17-102.nay.redhat.com>
References: <1397519754-10205-1-git-send-email-bhe@redhat.com>
 <20140430055503.GD4774@dhcp-16-105.nay.redhat.com>
 <20140430060303.GE4774@dhcp-16-105.nay.redhat.com>
 <20009828.4TTRJo9T7a@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:57926 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751386AbaEBIvy (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 2 May 2014 04:51:54 -0400
Content-Disposition: inline
In-Reply-To: <20009828.4TTRJo9T7a@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-kernel@vger.kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org, jiang.liu@linux.intel.com, vgoyal@redhat.com

On 04/30/14 at 10:13pm, Rafael J. Wysocki wrote:
> On Wednesday, April 30, 2014 02:03:03 PM Baoquan He wrote:
> > Hi Rafael,
> 
> Hi,
> 
> > Thanks for previous review for v1. Later on I thought acpi_lapic is
> > more suitable for checking whether LAPIC in MADT is available, and it can
> > hanlde both the UP system running SMP kernel with no LAPIC in MADT and kdump
> > kernel after multiple CPUs system crashed on non-1st CPU.
> > 
> > I tested the 1st case by addding "disableapic nr_cpus=1" into cmdline
> > of SMP kenrel, and it works. For 2nd case, it works too, below warning
> > message is not printed any more. 
> > 
> > acpi LNXCPU:0a: BIOS reported wrong ACPI id 0 for the processor
> > 
> > Do you like this idea?
> 
> Well, I don't hate it, but you need to make the code build in all
> configurations (including ia64).
> 
Hi Rafael,

Sorry about this, I didn't realize acpi_lapic is for x86 only. And ia64
uses it too. About this bug, it should exist in ia64 too. After checking
code, introducing acpi_lapic into ia64 is a solution, I will try to find
a ia64 machine to test this though it's a little difficult, since people
around didn't test ia64 recently.

Any suggestion  or comment?

Thanks
Baoquan

