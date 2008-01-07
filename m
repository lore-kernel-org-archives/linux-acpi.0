From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 0/7] Fix the ACPI 1.0 vs ACPI 2.0 suspend ordering issue (rev. 3)
Date: Tue, 8 Jan 2008 00:02:23 +0100
Message-ID: <200801080002.25044.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:38879 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753833AbYAGXKX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 7 Jan 2008 18:10:23 -0500
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Pavel Machek <pavel@suse.cz>, pm list <linux-pm@lists.linux-foundation.org>, Arjan van de Ven <arjan@infradead.org>, Carlos Corbacho <carlos@strangeworlds.co.uk>, Alexey Starikovskiy <aystarik@gmail.com>, "Moore, Robert" <robert.moore@intel.com>, Matthew Garrett <mjg59@srcf.ucam.org>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, David Brownell <david-b@pacbell.net>

Len,

The following patchset is intended to fix the ACPI 1.0 vs ACPI 2.0 susp=
end
ordering issue described at http://bugzilla.kernel.org/show_bug.cgi?id=3D=
9528 and
in a recent LKML thread (http://lkml.org/lkml/2007/12/25/37).

The patches actually do more than that, as I think it's reasonable to u=
ntangle
some ACPI-specific suspend code when we're at it. =A0The details are de=
scribed in
the changelogs.

The patches are intended for 2.6.25.

Please add them to the suspend branch.

Thanks,
Rafael

-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
