From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: udev broken by recent ACPI git commits
Date: Mon, 13 Nov 2006 21:56:02 +0100
Message-ID: <200611132156.02989.rjw@sisk.pl>
References: <200611010004.28483.rjw@sisk.pl> <200611030039.28762.len.brown@intel.com> <200611130616.38174.len.brown@intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:56022 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1755344AbWKMU7L (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Mon, 13 Nov 2006 15:59:11 -0500
In-Reply-To: <200611130616.38174.len.brown@intel.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org

On Monday, 13 November 2006 12:16, Len Brown wrote:
> > Please test that the latest ACPICA patch works on your system and shout if it doesn't.
> > In particular, if you've got an nx6325 like Rafael's, it would be interesting to know
> > if you see the same issue.
> > 
> > You can snag the latest ACPICA patch vs  top of Linus' tree via git or plain patch here:
> > git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux-acpi-2.6.git acpica
> > http://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/patches/test/2.6.19/acpi-acpica-20061011-2.6.19-rc4.diff.gz
> 
> Rafael,
> What BIOS version is running on your nx6325?

The BIOS version is F.02 ...

> What do you see if you add the patch below to the ACPICA  patch?

... and the patch helps (ie. with this patch on top of 2.6.19-rc3 with
acpi-acpica-20061011-2.6.19-rc4.diff applied the box boots normally).

Greetings,
Rafael


-- 
You never change things by fighting the existing reality.
		R. Buckminster Fuller
