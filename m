From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: [patch 2/2] PNP: don't check disabled PCI BARs for conflicts in quirk_system_pci_resources()
Date: Wed, 1 Oct 2008 14:18:06 -0600
Message-ID: <200810011418.06908.bjorn.helgaas@hp.com>
References: <200809290953.56565.bjorn.helgaas@hp.com> <alpine.LFD.2.00.0809300904530.3389@nehalem.linux-foundation.org> <200809301312.50712.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <200809301312.50712.bjorn.helgaas@hp.com>
Content-Disposition: inline
Sender: linux-pci-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Rene Herman <rene.herman@keyaccess.nl>, Jesse Barnes <jbarnes@virtuousgeek.org>, Len Brown <lenb@kernel.org>, Frans Pop <elendil@planet.nl>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org, Adam Belay <abelay@mit.edu>, Avuton Olrich <avuton@gmail.com>, Karl Bellve <karl.bellve@umassmed.edu>, Willem Riede <wriede@riede.org>, Matthew Hall <mhall@mhcomputing.net>
List-Id: linux-acpi@vger.kernel.org

Where are we on this regression?  We got side-tracked with all
the initcall ordering stuff, but I don't think that leads to
something appropriate for this late stage of 2.6.27.

I think the safest (and already tested) path is the
"res->start == 0 means disabled" check in the PNP quirk.

Bjorn
