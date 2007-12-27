From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [RFC][PATCH 0/7] Fix the ACPI 1.0 vs ACPI 2.0 suspend ordering issue
Date: Thu, 27 Dec 2007 19:03:52 +0100
Message-ID: <200712271903.53961.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:43404 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752192AbXL0SBa (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 27 Dec 2007 13:01:30 -0500
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Cc: Arjan van de Ven <arjan@infradead.org>, Carlos Corbacho <carlos@strangeworlds.co.uk>, Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@suse.cz>, pm list <linux-pm@lists.linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Len Brown <lenb@kernel.org>, Alexey Starikovskiy <aystarik@gmail.com>, "Moore, Robert" <robert.moore@intel.com>

Hi,

The following patchset is intended to fix the ACPI 1.0 vs ACPI 2.0 suspend
ordering issue described at http://bugzilla.kernel.org/show_bug.cgi?id=9528 and
in a recent LKML thread (http://lkml.org/lkml/2007/12/25/37).

The patches actually do more than that, as I think it's reasonable to untangle
some ACPI-specific suspend code by the way.  The details are described in the
changelogs.

The patches apply on top of the suspend branch of the ACPI tree
(git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux-acpi-2.6 suspend),
but they are also included in the quilt patch series at:
http://www.sisk.pl/kernel/hibernation_and_suspend/2.6.24-rc6/patches/ .

Please review (and test, if possible).

Thanks,
Rafael


-- 
"Premature optimization is the root of all evil." - Donald Knuth

