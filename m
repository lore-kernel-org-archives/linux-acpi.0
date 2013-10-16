From: "Luck, Tony" <tony.luck@intel.com>
Subject: RE: [PATCH 8/8] ACPI / trace: Add trace interface for eMCA driver
Date: Wed, 16 Oct 2013 20:35:32 +0000
Message-ID: <3908561D78D1C84285E8C5FCA982C28F31D31C28@ORSMSX106.amr.corp.intel.com>
References: <1381473166-29303-1-git-send-email-gong.chen@linux.intel.com>
 <1381473166-29303-9-git-send-email-gong.chen@linux.intel.com>
 <20131015165435.GA2777@naverao1-tp.ibm.com> <20131015170039.GF7908@pd.tnic>
 <525D7BCD.7080303@linux.vnet.ibm.com>
 <20131015214346.68718bcd.m.chehab@samsung.com>
 <20131016091640.GA13608@pd.tnic>
 <20131016073539.5a48f65e.m.chehab@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20131016073539.5a48f65e.m.chehab@samsung.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Mauro Carvalho Chehab <m.chehab@samsung.com>, Borislav Petkov <bp@alien8.de>
Cc: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>, "Chen, Gong" <gong.chen@linux.intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Aristeu Rozanski Filho <arozansk@redhat.com>, Steven Rostedt <srostedt@redhat.com>
List-Id: linux-acpi@vger.kernel.org

> Are there any changes with regards to that, like some enforcement policy
> for BIOS manufacturers to make it right?

I am using a cricket bat to beat BIOS teams that implement eMCA to make
sure they get the labels in SMBIOS right. :-)

It's a non-trivial implementation effort to get all the decoding done for
the eMCA log.  It's typically a simple string change to fix the SMBIOS
table ... there has been some resistance - but so far I have been victorious.
Wish me luck as I'm about to engage with another team.

-Tony
