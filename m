From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: breakage in current git-acpi
Date: Fri, 16 Feb 2007 23:49:48 -0800
Message-ID: <20070216234948.6bf2ed82.akpm@linux-foundation.org>
References: <20070216223956.d04af327.akpm@linux-foundation.org>
	<200702170225.07774.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.24]:51940 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1946478AbXBQHvB (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 17 Feb 2007 02:51:01 -0500
In-Reply-To: <200702170225.07774.lenb@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org

On Sat, 17 Feb 2007 02:25:07 -0500 Len Brown <lenb@kernel.org> wrote:

> On Saturday 17 February 2007 01:39, Andrew Morton wrote:
> > 
> > Standard FC5 RH install, it is set up to suspend to disk when I close the
> > lid.
> > 
> > With git-acpi.patch applied, this just stops working on the second or third
> > attempt.  It's like acpid just didn't see the lid close at all.  Closing
> > the lid causes no kernel messages at all.
> > 
> > Any suggestions as to how to debug this, apart from git-bisect, which will
> > take rather a long time?
> 
> nuke kacpid

I hope you meant acpid - I can't kill a kernel thread ;)

> and cat /proc/acpi/event

> click the lid a bunch of times

sony:/home/akpm# cat /proc/acpi/event
button/lid LID0 00000080 00000005
button/lid LID0 00000080 00000006
button/lid LID0 00000080 00000007
button/lid LID0 00000080 00000008


> and also the power button

button/power PWRB 00000080 00000001
button/power PWRB 00000080 00000002
button/power PWRB 00000080 00000003
button/power PWRB 00000080 00000004

> you should see the acpi line in /proc/interrupts tick each time,
> and a message come out of /proc/acpi/event

yup.

9:       1344   IO-APIC-fasteoi   acpi

it's increasing even while the machine is just sitting there.

> Also, you should be able to see the state of the lid in a file under /proc/acpi/button/*/

sony:/home/akpm# cat /proc/acpi/button/lid/LID0/state
state:      closed
sony:/home/akpm# cat /proc/acpi/button/lid/LID0/state
state:      open

all seems well.

Stopping and restarting acpid doesn't fix it.

