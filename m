From: Len Brown <lenb@kernel.org>
Subject: Re: acpi git versus x86_64 tree
Date: Sat, 16 Dec 2006 01:41:24 -0500
Message-ID: <200612160141.24286.lenb@kernel.org>
References: <20061214153750.b70744ad.akpm@osdl.org> <200612150101.41044.lenb@kernel.org> <20061214220750.7617fae3.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:60818 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030653AbWLPGmH (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 16 Dec 2006 01:42:07 -0500
In-Reply-To: <20061214220750.7617fae3.akpm@osdl.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>
Cc: Andi Kleen <ak@suse.de>, linux-acpi@vger.kernel.org

> > For now I will remove the ACPICA update from my test branch
> > so that it doesn't block the unrelated patches that should go up now.
> > The ACPICA update will still be available on a dedicated acpica branch.
> 
> OK, thanks.  I'll resync with gti-acpi and will go through another round of
> squirting patches at everyone.

Andrew,
the acpi-test tree is ready for you to resume pulling it.

(for those of you who pull it and update the result: Sorry --
I created new history, as I dropped both the acpica and sysfs branches
from "test" -- the are available only on their dedicated branches.

At the moment, the only thing in acpi-test that I don't think is both
ready and appropriate for for 2.6.20-rc1 is the bay driver.

> But the problem remains: there is outstanding work in ACPICA which
> conflicts with outstanding x86/x86_64 work.  Once those two patchsets
> finally coincide somewhere, things will blow up.  

Alexey and I looked at this today and we think we can modify the ACPICA
update to touch fewer lines and cause fewer conflicts.

So the plan is to shrink the patch, merge it back into acpi-test,
let it stew in -mm, and then push to 2.6.21.

thanks,
-Len

