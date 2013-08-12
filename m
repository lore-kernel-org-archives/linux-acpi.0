From: "Luck, Tony" <tony.luck@intel.com>
Subject: RE: [PATCH 3/3] mce: acpi/apei: trace: Enable ghes memory error
 trace event
Date: Mon, 12 Aug 2013 17:54:21 +0000
Message-ID: <3908561D78D1C84285E8C5FCA982C28F31CB71B5@ORSMSX106.amr.corp.intel.com>
References: <1375986471-27113-1-git-send-email-naveen.n.rao@linux.vnet.ibm.com>
 <1375986471-27113-4-git-send-email-naveen.n.rao@linux.vnet.ibm.com>
 <20130808163822.67e0828a@samsung.com> <20130810180322.GC4155@pd.tnic>
 <20130812083355.47c1bae8@samsung.com> <20130812123813.GD18018@pd.tnic>
 <20130812114932.52bb0314@samsung.com> <20130812150424.GH18018@pd.tnic>
 <20130812142557.2a43f155@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20130812142557.2a43f155@samsung.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Mauro Carvalho Chehab <m.chehab@samsung.com>, Borislav Petkov <bp@alien8.de>
Cc: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>, "bhelgaas@google.com" <bhelgaas@google.com>, "rostedt@goodmis.org" <rostedt@goodmis.org>, "rjw@sisk.pl" <rjw@sisk.pl>, "lance.ortiz@hp.com" <lance.ortiz@hp.com>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

>> We are, of course, going to have only one tracepoint which reports
>> memory errors, not two.
>
> Yes, that's my point.

Is life that simple?

We have systems that have no EDAC driver (in some cases because the
architecture precludes one from ever being written, in other because
we either don't have the documentation, or because no driver has been
written yet).	

Systems also have varying degrees of APEI support (from none at all, to
full support ... possibly we may have some with apparent support, but BIOS
provides bogus information ... assuming BIOS folks live up/down to our
usual expectations).

-Tony
