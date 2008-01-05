From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [RFC][PATCH 0/7] Fix the ACPI 1.0 vs ACPI 2.0 suspend ordering issue (rev. 2)
Date: Sat, 5 Jan 2008 23:32:43 +0100
Message-ID: <200801052332.44500.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:58232 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752694AbYAEXQP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 5 Jan 2008 18:16:15 -0500
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Cc: Arjan van de Ven <arjan@infradead.org>, Carlos Corbacho <carlos@strangeworlds.co.uk>, Linus Torvalds <torvalds@linux-foundation.org>, Pavel Machek <pavel@suse.cz>, pm list <linux-pm@lists.linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Len Brown <lenb@kernel.org>, Alexey Starikovskiy <aystarik@gmail.com>, "Moore, Robert" <robert.moore@intel.com>, Matthew Garrett <mjg59@srcf.ucam.org>

Hi,

The following patchset is intended to fix the ACPI 1.0 vs ACPI 2.0 susp=
end
ordering issue described at http://bugzilla.kernel.org/show_bug.cgi?id=3D=
9528 and
in a recent LKML thread (http://lkml.org/lkml/2007/12/25/37).

The patches actually do more than that, as I think it's reasonable to u=
ntangle
some ACPI-specific suspend code by the way. =A0The details are describe=
d in the
changelogs.

The patches apply on top of the suspend branch of the ACPI tree
(git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux-acpi-2.6 susp=
end).

The previous (slightly different) iteration was tested on several syste=
ms and
it was confirmed that it fixed the issues at hand.

Please review.

Thanks,
Rafael

-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
