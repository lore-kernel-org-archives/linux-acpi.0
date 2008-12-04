From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: 2.6.28-rc7 acpi error messages
Date: Thu, 4 Dec 2008 23:02:55 +0000
Message-ID: <20081204230255.GA14130@srcf.ucam.org>
References: <E92FAF79A8BBC642A36EEE3AA7F152D82A17260164@GVW1089EXB.americas.hpqcorp.net> <4911F71203A09E4D9981D27F9D8308580DD52E96@orsmsx503.amr.corp.intel.com> <20081203230332.GA26733@srcf.ucam.org> <4911F71203A09E4D9981D27F9D8308580DD52F0F@orsmsx503.amr.corp.intel.com> <20081203233557.GA27180@srcf.ucam.org> <4911F71203A09E4D9981D27F9D8308580DD53280@orsmsx503.amr.corp.intel.com> <E92FAF79A8BBC642A36EEE3AA7F152D82A172606EE@GVW1089EXB.americas.hpqcorp.net> <4911F71203A09E4D9981D27F9D8308580DD53927@orsmsx503.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:48488 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752412AbYLDXDE (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 4 Dec 2008 18:03:04 -0500
Content-Disposition: inline
In-Reply-To: <4911F71203A09E4D9981D27F9D8308580DD53927@orsmsx503.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Moore, Robert" <robert.moore@intel.com>
Cc: "Koornstra, Reinoud" <koornstra@hp.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Brown, Len" <len.brown@intel.com>, "Lin, Ming M" <ming.m.lin@intel.com>, "Zhao, Yakui" <yakui.zhao@intel.com>

On Thu, Dec 04, 2008 at 02:49:52PM -0800, Moore, Robert wrote:
> Well, lo and behold! With a newer version of acpidump, we do get both the RSDT and XSDT and there are indeed two different FADTs.
> 
> Acpidump should post a version number to prevent this kind of thrash in the future.
> 
> The FADT within the RSDT seems much more reasonable. It is a short (rev 1) FADT with no 64-bit register addresses to cause issues. I still suspect the GPE0 block length (0x10) however.

Huh. Right, so either Windows ignores the length or uses the length (but 
not the address) from the X block. The plot thickens.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
