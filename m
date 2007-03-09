From: Len Brown <lenb@kernel.org>
Subject: Re: [GIT PULL] ibm-acpi: more updates
Date: Thu, 8 Mar 2007 22:59:55 -0500
Message-ID: <200703082259.55832.lenb@kernel.org>
References: <11723292823837-git-send-email-hmh@hmh.eng.br>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:46604 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S2992939AbXCIEIq (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 8 Mar 2007 23:08:46 -0500
In-Reply-To: <11723292823837-git-send-email-hmh@hmh.eng.br>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: linux-acpi@vger.kernel.org, ibm-acpi-devel@lists.sourceforge.net

Henrique,
If you could refresh this on to of the latest acpi-test,
that would be great.  (ibm-acpi changes in acpi-test are
headed for 2.6.21).

note also that you have some whitespace violations.
Space in indent is followed by a tab.
.dotest/patch:41:                                            led * led_exp_hlbl[ind]);
Space in indent is followed by a tab.
.dotest/patch:46:                                            led * led_exp_hlcl[ind]);

probably the simplest way to stay on top of these is
to maintain the driver as Lindent free upon every patch.
eg. run Lindent after every patch to make sure it doesn't
introduce any violations.

you can also use git-apply --whitespace=strip

thanks,
-Len

On Saturday 24 February 2007 10:01, Henrique de Moraes Holschuh wrote:
> Len,
> 
> Please pull from:
> git://repo.or.cz/linux-2.6/linux-acpi-2.6/ibm-acpi-2.6.git
> branch for-upstream/acpi-test
> 
> to receive the following patches:
> 
> Henrique de Moraes Holschuh (5):
>       ACPI: ibm-acpi: rename some identifiers
>       ACPI: ibm-acpi: add header file
>       ACPI: ibm-acpi: organize code
>       ACPI: ibm-acpi: update copyright notice
>       ACPI: ibm-acpi: update documentation
> 
> It has a lot of code shuffling, which I did while cleaning up and preparing for
> a sysfs conversion.  It would be helpful to me if it is merged in acpi-test, as
> that means it will be much faster for me to keep my working tree and what is in
> acpi-test and mainline in sync.  The rest are just minor doc updates.
> 
> This patch set should not change any functionality.
> 
> I just added the patches on top of what I had already sent you (and that you
> have already merged).  If you'd prefer it to be based on something else, just
> say so.
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
