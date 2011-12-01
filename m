From: "Luck, Tony" <tony.luck@intel.com>
Subject: RE: [PATCH 2/2] ACPICA: support Generic Address Structure
 bit_offset in acpi_read/write
Date: Wed, 30 Nov 2011 16:53:43 -0800
Message-ID: <0207C53569FE594381A4F2EB66570B2A018ED45DA7@orsmsx508.amr.corp.intel.com>
References: <20111111230347.20897.28797.stgit@bhelgaas.mtv.corp.google.com>
	 <201111172127.40664.rjw@sisk.pl> <1321578279.13860.108.camel@yhuang-dev>
	 <201111181025.58650.rjw@sisk.pl> <1321861880.13860.128.camel@yhuang-dev>
	 <987664A83D2D224EAE907B061CE93D53027D89B5A9@orsmsx505.amr.corp.intel.com>
	 <1322532903.4849.24.camel@yhuang-dev>
	 <0207C53569FE594381A4F2EB66570B2A018ED45AA8@orsmsx508.amr.corp.intel.com>
 <1322700551.4849.66.camel@yhuang-dev>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:28844 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753410Ab1LAAxr (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 30 Nov 2011 19:53:47 -0500
In-Reply-To: <1322700551.4849.66.camel@yhuang-dev>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Huang, Ying" <ying.huang@intel.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Russell King <linux@arm.linux.org.uk>, Bjorn Helgaas <bhelgaas@google.com>, Thomas Renninger <trenn@suse.de>, Len Brown <lenb@kernel.org>, "Moore, Robert" <robert.moore@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "bondd@us.ibm.com" <bondd@us.ibm.com>, Myron Stowe <myron.stowe@redhat.com>

PiBJcyBpdCBwb3NzaWJsZSB0byB1c2UgdGhlIHBhZ2VfaXNfcmFtKCkgYW5kIGthbXAoKSBwYXRo
IGluIHRoZSBwYXRjaCB0byBhdm9pZCB0aGUgc2l0dWF0aW9uIHlvdSBtZW50aW9uZWQ/DQoNCk1h
eWJlIC0gaXQgY291bGQgY2VydGFpbmx5IGNoZWNrIHRoZSBjdXJyZW50IGF0dHJpYnV0ZXMgYW5k
IG1hdGNoIHRoZW0uDQoNCk5vdCBzdXJlIHdoZXRoZXIgdGhlcmUgbWlnaHQgYmUgYSBnYXAgaWYg
dGhlIGFjcGkgbWFwcGluZyBpcyBsb25nLWxpdmVkLA0KYW5kIHRoZSBvdGhlciBrZXJuZWwgbWFw
cGluZ3MgY2hhbmdlIC4uLiB0aG91Z2ggdGhpcyBpcyB2ZXJ5IHJhcmUgdG8NCnN3aXRjaCBhdHRy
aWJ1dGVzDQoNCi1Ub255DQo=
