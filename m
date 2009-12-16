From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: [PATCH v1 3/5] ipmi: remove unused PCI probe coded
Date: Wed, 16 Dec 2009 13:53:53 -0700
Message-ID: <200912161353.56581.bjorn.helgaas@hp.com>
References: <20091118000427.14214.14043.stgit@bob.kio> <200912021253.00726.bjorn.helgaas@hp.com> <E0AA796A7E3F4C4E8F1065D15FE478618CE8B806@EXCH-MBX-4.vmware.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g4t0015.houston.hp.com ([15.201.24.18]:47710 "EHLO
	g4t0015.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753465AbZLPUyA (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 16 Dec 2009 15:54:00 -0500
In-Reply-To: <E0AA796A7E3F4C4E8F1065D15FE478618CE8B806@EXCH-MBX-4.vmware.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bela Lubkin <blubkin@vmware.com>
Cc: "minyard@acm.org" <minyard@acm.org>, Zhao Yakui <yakui.zhao@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Myron Stowe <myron.stowe@hp.com>, "openipmi-developer@lists.sourceforge.net" <openipmi-developer@lists.sourceforge.net>, Len Brown <lenb@kernel.org>

On Wednesday 02 December 2009 02:04:09 pm Bela Lubkin wrote:
> Much older HP systems had a PCI SMIC interface.  Are you
> sure those haven't been broken somewhere along the way?

It looks like this would be a 103c:121a NetServer SMIC Controller,
which Google thinks was used in LT 6000r and LH 3000 HP NetServers.

Unfortunately, those are pretty ancient boxes, and I haven't been
able to dig one up to play with it.  If anybody can find one, I'll
be happy to do whatever we need to get that SMIC controller working.

Bjorn
