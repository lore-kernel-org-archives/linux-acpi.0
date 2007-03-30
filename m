From: Len Brown <lenb@kernel.org>
Subject: Re: [GIT PULL] rename ibm-acpi driver to thinkpad-acpi
Date: Fri, 30 Mar 2007 16:03:55 -0400
Message-ID: <200703301603.55424.lenb@kernel.org>
References: <11751443243976-git-send-email-hmh@hmh.eng.br>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:45415 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753540AbXC3UMA (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 30 Mar 2007 16:12:00 -0400
In-Reply-To: <11751443243976-git-send-email-hmh@hmh.eng.br>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: ibm-acpi-devel@lists.sourceforge.net, linux-acpi@vger.kernel.org


+MODULE_ALIAS("ibm_acpi");
good

> 
> Len,
> 
> Please pull from: 
> git://repo.or.cz/linux-2.6/linux-acpi-2.6/ibm-acpi-2.6.git
> branch for-upstream/acpi-test
> 
> to receive the following patches *already* in acpi-test:
>       ACPI: ibm-acpi: kill trailing whitespace
>       ACPI: ibm-acpi: rename some identifiers
>       ACPI: ibm-acpi: add header file
>       ACPI: ibm-acpi: organize code
>       ACPI: ibm-acpi: update copyright notice
>       ACPI: ibm-acpi: update documentation
>       ACPI: ibm-acpi: move driver to drivers/misc hierarchy

had these already.

> and to receive the following **new** patches:
>       ACPI: ibm-acpi: rename driver to thinkpad-acpi
>       ACPI: thinkpad-acpi: cleanup Kconfig for thinkpad-acpi
>       ACPI: thinkpad-acpi: add compatibility MODULE_ALIAS entry
>       ACPI: thinkpad-acpi: cleanup after rename
>       ACPI: thinkpad-acpi: update MAINTAINERS

applied these.


> As you can notice from the above, the branch contains the patches you have
> already pulled into acpi-test.  I don't know how well git will handle the
> merging as some *have* been rebased and whitespace-modified since you last
> pulled them (they are now exactly the same of what you have in acpi-test).
> 
> I suppose you could just drop the ones already in acpi-test and get them
> all again from the above branch, or you can get just the new ones from
> this thread using git-am.  I didn't base the branch on acpi-test, as you
> previously told me not to do that as it would make matters worse for you.
> 
> If you'd rather I prepare these branches in a different way, just tell me
> how you'd like them done.

I'm glad you're using git, it formats the patches perfectly.
But, I'll probably always apply the plain patches instead of pulling 
from your tree.  This is because i reserve the right to re-write history
of my test branch to suite my own needs, and I don't want to pull
back duplicate history from somebody that pulled acpi-test.

thanks,
-Len
