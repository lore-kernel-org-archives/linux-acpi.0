From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: Lenovo S10e, charge_full == 0 ?!?
Date: Mon, 01 Jun 2009 10:25:31 +0800
Message-ID: <1243823131.32574.73.camel@rzhang-dt>
References: <20090531214220.GK27997@hezmatt.org>
	 <1243816851.3558.14.camel@localhost.localdomain>
	 <20090601014551.GB6528@hezmatt.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:53775 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753798AbZFACYx (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 31 May 2009 22:24:53 -0400
In-Reply-To: <20090601014551.GB6528@hezmatt.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Palmer <mpalmer@hezmatt.org>
Cc: "Zhao, Yakui" <yakui.zhao@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Mon, 2009-06-01 at 09:45 +0800, Matthew Palmer wrote:
> [All: Cc's please, I'm not subscribed]
> 
> Hi Yakui,
> 
> On Mon, Jun 01, 2009 at 08:40:51AM +0800, yakui_zhao wrote:
> > On Mon, 2009-06-01 at 05:42 +0800, Matthew Palmer wrote:
> > > [Please Cc me; I'm not subscribed to the list]
> > > 
> > > Hi,
> > Will you please check whether the output of "cat /proc/acpi/battery/*/*"
> > is normal?
> 
> The tricky part there is: what exactly counts as "normal"?  As best I can
> tell by comparing it to the output of my other laptop, the only possible
> weirdnesses are:
> 
> alarm: unsupported
> last full capacity: 0 mAh
> 
> Everything else looks reasonably similar.  Since it's only about 20 lines
> long, I've pasted the whole output into the end of this e-mail.  Perhaps
> there's something that's unobviously wrong.
> 
> > Of course you can open a new bug at
> > http://bugzilla.kernel.org/enter_bug.cgi?product=ACPI
> > and attach the output of acpidump, "cat /proc/acpi/battery/*/*".
> 
> I'm not sure I care enough to create yet another never-to-be-used-again
> bugzilla account.  I plan on nailing this problem down myself, with
> assistance, rather than just reporting a bug and hoping someone else fixes
> it for me.  I've placed the acpidump output at
> http://hezmatt.org/~mpalmer/tmp/acpidump_s10e.txt 

I can not access this url.
Filing a new bug report makes it easier for us to track this bug.
so I think it's still worth doing, btw, you can attach the acpidump
there.

thanks,
rui


