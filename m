From: Bela Lubkin <blubkin@vmware.com>
Subject: RE: [PATCH v1 3/5] ipmi: remove unused PCI probe coded
Date: Wed, 2 Dec 2009 13:04:09 -0800
Message-ID: <E0AA796A7E3F4C4E8F1065D15FE478618CE8B806@EXCH-MBX-4.vmware.com>
References: <20091118000427.14214.14043.stgit@bob.kio>
 <20091118000524.14214.41587.stgit@bob.kio>
 <20091201231841.GA7903@minyard.local>
 <200912021253.00726.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp-outbound-2.vmware.com ([65.115.85.73]:48230 "EHLO
	smtp-outbound-2.vmware.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753774AbZLBVED convert rfc822-to-8bit
	(ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 2 Dec 2009 16:04:03 -0500
In-Reply-To: <200912021253.00726.bjorn.helgaas@hp.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: 'Bjorn Helgaas' <bjorn.helgaas@hp.com>, "minyard@acm.org" <minyard@acm.org>
Cc: Zhao Yakui <yakui.zhao@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Myron Stowe <myron.stowe@hp.com>, "openipmi-developer@lists.sourceforge.net" <openipmi-developer@lists.sourceforge.net>, Len Brown <lenb@kernel.org>

Bjorn Helgaas wrote:

> The original 5-patch series leaves the PCI base address alone.  That's
> the same as the old behavior for HP devices, and we verified that it
> works on an HP DL380G6 by disabling SMBIOS/SMPI/PNP detection.  (We
> also verified that, as you would expect, it did NOT work if we increment
> the base address).
...
> So the question is what to do about non-HP PCI IPMI interfaces.  The
> pre-b0defcdbd2b7d code increments the base address, but that's been
> gone for several years.  Since we've had no complaints, and we don't
> know about any non-HP PCI interfaces, I propose that we just remove
> that HP-specific adjustment completely, i.e., use this series as-is.

Much older HP systems had a PCI SMIC interface.  Are you
sure those haven't been broken somewhere along the way?

(Please don't say "we don't care about things that old".)

>Bela<