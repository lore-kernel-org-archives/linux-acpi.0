From: Matthew Palmer <mpalmer@hezmatt.org>
Subject: Re: Lenovo S10e, charge_full == 0 ?!?
Date: Mon, 1 Jun 2009 11:45:51 +1000
Message-ID: <20090601014551.GB6528@hezmatt.org>
References: <20090531214220.GK27997@hezmatt.org> <1243816851.3558.14.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from sasquatch.hezmatt.org ([70.85.129.92]:38173 "EHLO
	sasquatch.hezmatt.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753135AbZFABpt (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 31 May 2009 21:45:49 -0400
Content-Disposition: inline
In-Reply-To: <1243816851.3558.14.camel@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: yakui_zhao <yakui.zhao@intel.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

[All: Cc's please, I'm not subscribed]

Hi Yakui,

On Mon, Jun 01, 2009 at 08:40:51AM +0800, yakui_zhao wrote:
> On Mon, 2009-06-01 at 05:42 +0800, Matthew Palmer wrote:
> > [Please Cc me; I'm not subscribed to the list]
> > 
> > Hi,
> Will you please check whether the output of "cat /proc/acpi/battery/*/*"
> is normal?

The tricky part there is: what exactly counts as "normal"?  As best I can
tell by comparing it to the output of my other laptop, the only possible
weirdnesses are:

alarm: unsupported
last full capacity: 0 mAh

Everything else looks reasonably similar.  Since it's only about 20 lines
long, I've pasted the whole output into the end of this e-mail.  Perhaps
there's something that's unobviously wrong.

> Of course you can open a new bug at
> http://bugzilla.kernel.org/enter_bug.cgi?product=ACPI
> and attach the output of acpidump, "cat /proc/acpi/battery/*/*".

I'm not sure I care enough to create yet another never-to-be-used-again
bugzilla account.  I plan on nailing this problem down myself, with
assistance, rather than just reporting a bug and hoping someone else fixes
it for me.  I've placed the acpidump output at
http://hezmatt.org/~mpalmer/tmp/acpidump_s10e.txt if anyone can make any
sense of it.  (If there's a "Dummies Guide to Interpreting acpidump Output"
somewhere, I'd love to know about it).

- Matt

---[BEGIN: /proc/acpi/battery/*/* ]---
alarm:                   unsupported
present:                 yes
design capacity:         4876 mAh
last full capacity:      0 mAh
battery technology:      rechargeable
design voltage:          10800 mV
design capacity warning: 487 mAh
design capacity low:     146 mAh
capacity granularity 1:  10 mAh
capacity granularity 2:  25 mAh
model number:            LE60_S
serial number:            
battery type:            LION
OEM info:                Sanyo
present:                 yes
capacity state:          ok
charging state:          discharging
present rate:            871 mA
remaining capacity:      4359 mAh
present voltage:         12026 mV
---[END]---

-- 
<Igloo> I remember going to my first tutorial in room 404. I was most upset
when I found it.
