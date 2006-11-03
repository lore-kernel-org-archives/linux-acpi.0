From: Len Brown <len.brown@intel.com>
Subject: Re: udev broken by recent ACPI git commits
Date: Fri, 3 Nov 2006 00:39:27 -0500
Message-ID: <200611030039.28762.len.brown@intel.com>
References: <200611010004.28483.rjw@sisk.pl> <200611010335.02948.len.brown@intel.com> <200611011147.42498.rjw@sisk.pl>
Reply-To: Len Brown <lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:24003 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S1752985AbWKCFhJ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 3 Nov 2006 00:37:09 -0500
In-Reply-To: <200611011147.42498.rjw@sisk.pl>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-acpi@vger.kernel.org

Rafael,
Please send the .config that fails.

This failure is on your HP NX6325 laptop running SL 10.1, yes?
I know that an nx6125 works, so the question is what is unique about your system.

Everybody,
Please test that the latest ACPICA patch works on your system and shout if it doesn't.
In particular, if you've got an nx6325 like Rafael's, it would be interesting to know
if you see the same issue.

You can snag the latest ACPICA patch vs  top of Linus' tree via git or plain patch here:
git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux-acpi-2.6.git acpica
http://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/patches/test/2.6.19/acpi-acpica-20061011-2.6.19-rc4.diff.gz

thanks,
-Len
