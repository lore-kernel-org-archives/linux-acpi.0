From: Len Brown <len.brown@intel.com>
Subject: Re: [PATCH 00/21] ACPI: ibm-acpi: cleanups, extended fan/thermal support
Date: Thu, 7 Dec 2006 01:23:25 -0500
Message-ID: <200612070123.25992.len.brown@intel.com>
References: <20061125204155.6604.35338.stgit@thorin.khazad-dum.debian.net>
Reply-To: Len Brown <lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:56104 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1031684AbWLGGUY (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 7 Dec 2006 01:20:24 -0500
In-Reply-To: <20061125204155.6604.35338.stgit@thorin.khazad-dum.debian.net>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: ibm-acpi-devel@lists.sourceforge.net, linux-acpi@vger.kernel.org

On Saturday 25 November 2006 15:41, Henrique de Moraes Holschuh wrote:
> git://repo.or.cz/linux-2.6/linux-acpi-2.6/ibm-acpi-2.6.git for-upstream/acpi-test

Henrique,
FYI, A pull of this branch will take everything included underneath it.
In this case, it will take all the contents of acpi-test that this branch is built upon.

That is fine for testing, but it isn't a path to upstream b/c
not everything in acpi-test is going to get sent up to Linus at the same time as ibm-acpi.

For this batch, I'll just re-parent the series, or re-commit the e-mail patches.
But in the future, if you base your patches directly against some snapshot of Linus' tree
and don't include anything else besides your changes, then I can pull it directly.

Of course you can do both by checking your changes in on a branch off of Linus'
baseline and then merging onto your mirror of acpi-test.  In that event I'd
pull from your branch based on Linus' mirror.

thanks,
-Len
