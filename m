From: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
Subject: [1/2] 2.6.23-rc3: known regressions with patches v3
Date: Fri, 24 Aug 2007 19:39:00 +0200
Message-ID: <46CF17B4.1060403@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.185]:58871 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1764126AbXHXRjS (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 24 Aug 2007 13:39:18 -0400
Received: by mu-out-0910.google.com with SMTP id i10so1168895mue
        for <linux-acpi@vger.kernel.org>; Fri, 24 Aug 2007 10:39:17 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Gabriel C <nix.or.die@googlemail.com>, Satyam Sharma <satyam.sharma@gmail.com>, Vitaly Bordug <vitb@kernel.crashing.org>, Andrey Borzenkov <arvidjaar@mail.ru>, Bjorn Helgaas <bjorn.helgaas@hp.com>, Len Brown <len.brown@intel.com>, linux-acpi@vger.kernel.org, Alex Hunsaker <badalex@gmail.com>, szczekut@wit.edu.pl, Alexey Starikovskiy <astarikovskiy@suse.de>, Pierre Ossman <drzeus-mmc@drzeus.cx>, Christian Casteyde <casteyde.christian@free.fr>, Alan Stern <stern@rowland.harvard.edu>

Hi all,

Here is a list of some known regressions in 2.6.23-rc3
with patches available.

Feel free to add new regressions/remove fixed etc.
http://kernelnewbies.org/known_regressions

List of Aces

Name                    Regressions fixed since 21-Jun-2007
Adrian Bunk                            9
Andi Kleen                             5
Linus Torvalds                         5
Andrew Morton                          4
Al Viro                                3
Alan Stern                             3
Cornelia Huck                          3
Jens Axboe                             3
Tejun Heo                              3



Unclassified

Subject         : 8250 claims non existing device blocking IO port
References      : http://lkml.org/lkml/2007/8/18/20
Last known good : ?
Submitter       : Andrey Borzenkov <arvidjaar@mail.ru>
Caused-By       : ?
Handled-By      : Bjorn Helgaas <bjorn.helgaas@hp.com>
Patch           : http://lkml.org/lkml/2007/8/21/291
Status          : patch was suggested

Subject         : Oops while modprobing phy fixed module
References      : http://lkml.org/lkml/2007/7/14/63
Last known good : ?
Submitter       : Gabriel C <nix.or.die@googlemail.com>
Caused-By       : ?
Handled-By      : Satyam Sharma <satyam.sharma@gmail.com>
                  Vitaly Bordug <vitb@kernel.crashing.org>
Patch1          : http://lkml.org/lkml/2007/7/18/506
Status          : patch available



ACPI

Subject         : Broken hotkeys on ASUS A6Km notebook with 2.6.23-rc3/2.6.23-rc3 fails to boot (acpi)
References      : http://bugzilla.kernel.org/show_bug.cgi?id=8909
                  http://bugzilla.kernel.org/show_bug.cgi?id=8919
Last known good : 2.6.23-rc2
Submitter       : <szczekut@wit.edu.pl>
                  Alex Hunsaker <badalex@gmail.com>
Caused-By       : ?
Handled-By      : Alexey Starikovskiy <astarikovskiy@suse.de>
Patch           : http://bugzilla.kernel.org/attachment.cgi?id=12494
Status          : patch available



MMC

Subject         : Unable to access memory card reader anymore
References      : http://bugzilla.kernel.org/show_bug.cgi?id=8885
Last known good : ?
Submitter       : Christian Casteyde <casteyde.christian@free.fr>
Caused-By       : ?
Handled-By      : Alan Stern <stern@rowland.harvard.edu>
Patch           : http://bugzilla.kernel.org/attachment.cgi?id=12438
Status          : patch available



Regards,
Michal

--
LOG
http://www.stardust.webpages.pl/log/
