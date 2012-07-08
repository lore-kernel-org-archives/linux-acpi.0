From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] ACPI: Leave Bus Master Arbitration enabled for suspend/resume
Date: Sun, 8 Jul 2012 21:43:03 +0200
Message-ID: <201207082143.04099.rjw@sisk.pl>
References: <op.wg3en6ij6g6bxc@localhost.localdomain> <20120708190434.GD7328@burratino> <20120708193204.GF7328@burratino>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([193.178.161.156]:58309 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751938Ab2GHThb (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 8 Jul 2012 15:37:31 -0400
In-Reply-To: <20120708193204.GF7328@burratino>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
Cc: Octavio Alvarez <alvarezp@alvarezp.com>, Bob Moore <robert.moore@intel.com>, Adrian Knoth <adi@drcomp.erfurt.thur.de>, Shaohua Li <shli@kernel.org>, Len Brown <len.brown@intel.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On Sunday, July 08, 2012, Jonathan Nieder wrote:
> Hi again,
> 
> Jonathan Nieder wrote:
> 
> > The bug snuck back in in commit 33620c5419e8 (ACPICA: Support for
> > custom ACPICA build for ACPI 5 reduced hardware, 2012-02-14),
> > presumably by copy/pasting from the wrong source for the legacy case.
> 
> Um, wrong commit.  Sorry, here's a fixed message.
> 
> ACPI: Leave Bus Master Arbitration enabled for suspend/resume
> 
> This is an old suspend/resume lockup fix:
> 
> 	commit 2780cc4660e1
> 	Author: Len Brown <len.brown@intel.com>
> 	Date:   Thu Dec 23 13:43:30 2004 -0500
> 
> 	    [ACPI] Fix suspend/resume lockup issue
> 	    by leaving Bus Master Arbitration enabled.
> 	    The ACPI spec mandates it be disabled only for C3.
> 
> 	    http://bugzilla.kernel.org/show_bug.cgi?id=3599
> 
> 	    Signed-off-by: David Shaohua Li <shaohua.li@intel.com>
> 	    Signed-off-by: Len Brown <len.brown@intel.com>
> 
> The bug snuck back in in commit 2feec47d4c5f (ACPICA: ACPI 5: Support
> for new FADT SleepStatus, SleepControl registers, 2012-02-14),
> presumably by copy/pasting a copy of the code without that fix for the
> legacy case.
> 
> On affected machines, after that commit, the machine locks up hard
> on resume from suspend.  The same fix as seven years ago still works.
> 
> Addresses <https://bugzilla.kernel.org/show_bug.cgi?id=43641>.
> 
> Reported-bisected-and-tested-by: Octavio Alvarez <alvarezp@alvarezp.com>
> Reported-by: Adrian Knoth <adi@drcomp.erfurt.thur.de>
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
> Cc: <stable@vger.kernel.org> # 3.4
> --

Can you please repost it with _both_ the changelog and the patch?

Thanks,
Rafael
