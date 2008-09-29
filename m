From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [patch 0/2] don't check disabled PCI BARs for conflicts with PNP devices
Date: Mon, 29 Sep 2008 09:53:54 -0600
Message-ID: <200809290953.56565.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pci-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-pci-owner@vger.kernel.org
To: Jesse Barnes <jbarnes@virtuousgeek.org>, Len Brown <lenb@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>
Cc: Frans Pop <elendil@planet.nl>, Rene Herman <rene.herman@keyaccess.nl>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org, Adam Belay <abelay@mit.edu>, Avuton Olrich <avuton@gmail.com>, Karl Bellve <karl.bellve@umassmed.edu>, Willem Riede <wriede@riede.org>, Matthew Hall <mhall@mhcomputing.net>
List-Id: linux-acpi@vger.kernel.org

These two patches address this 2.6.26 regression, so they should go
in before 2.6.27:
    http://bugzilla.kernel.org/show_bug.cgi?id=11550

This PNP/PCI resource conflict area has been a trouble spot in the
past:
    http://thread.gmane.org/gmane.linux.acpi.devel/27312
    https://bugzilla.redhat.com/show_bug.cgi?id=280641
    https://bugzilla.redhat.com/show_bug.cgi?id=313491

It would be great if Matthew, Avuton, Karl, and Willem could test
these patches to make sure they don't re-introduce the old problem.

Bjorn
