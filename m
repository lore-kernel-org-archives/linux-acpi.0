From: Mauro Carvalho Chehab <m.chehab@samsung.com>
Subject: Re: [PATCH 8/8] ACPI / trace: Add trace interface for eMCA driver
Date: Thu, 17 Oct 2013 07:32:18 -0300
Message-ID: <20131017073218.11aae607@samsung.com>
References: <1381473166-29303-1-git-send-email-gong.chen@linux.intel.com>
 <1381473166-29303-9-git-send-email-gong.chen@linux.intel.com>
 <20131015165435.GA2777@naverao1-tp.ibm.com> <20131015170039.GF7908@pd.tnic>
 <525D7BCD.7080303@linux.vnet.ibm.com>
 <20131015214346.68718bcd.m.chehab@samsung.com>
 <20131016091640.GA13608@pd.tnic>
 <20131016073539.5a48f65e.m.chehab@samsung.com>
 <3908561D78D1C84285E8C5FCA982C28F31D31C28@ORSMSX106.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mailout2.w2.samsung.com ([211.189.100.12]:38621 "EHLO
	usmailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750726Ab3JQKcZ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 17 Oct 2013 06:32:25 -0400
In-reply-to: <3908561D78D1C84285E8C5FCA982C28F31D31C28@ORSMSX106.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Luck, Tony" <tony.luck@intel.com>
Cc: Borislav Petkov <bp@alien8.de>, "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>, "Chen, Gong" <gong.chen@linux.intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Aristeu Rozanski Filho <arozansk@redhat.com>, Steven Rostedt <srostedt@redhat.com>

Em Wed, 16 Oct 2013 20:35:32 +0000
"Luck, Tony" <tony.luck@intel.com> escreveu:

> > Are there any changes with regards to that, like some enforcement policy
> > for BIOS manufacturers to make it right?
> 
> I am using a cricket bat to beat BIOS teams that implement eMCA to make
> sure they get the labels in SMBIOS right. :-)

:)

> It's a non-trivial implementation effort to get all the decoding done for
> the eMCA log.  It's typically a simple string change to fix the SMBIOS
> table ... there has been some resistance - but so far I have been victorious.
> Wish me luck as I'm about to engage with another team.

Yes, the DMI changes are trivial. Let's hope that they'll do it right.

Yet, I think we should keep (at least for a while) a mechanism similar to
what EDAC does, allowing those names to be overridden by loading a different
table, where needed.

Regards,
Mauro
