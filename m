From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: 2.6.28-rc7 acpi error messages
Date: Fri, 5 Dec 2008 17:21:44 +0000
Message-ID: <20081205172144.GA27396@srcf.ucam.org>
References: <4911F71203A09E4D9981D27F9D8308580DD52E96@orsmsx503.amr.corp.intel.com> <20081203230332.GA26733@srcf.ucam.org> <4911F71203A09E4D9981D27F9D8308580DD52F0F@orsmsx503.amr.corp.intel.com> <20081203233557.GA27180@srcf.ucam.org> <4911F71203A09E4D9981D27F9D8308580DD53280@orsmsx503.amr.corp.intel.com> <E92FAF79A8BBC642A36EEE3AA7F152D82A172606EE@GVW1089EXB.americas.hpqcorp.net> <4911F71203A09E4D9981D27F9D8308580DD53927@orsmsx503.amr.corp.intel.com> <4911F71203A09E4D9981D27F9D8308580DD53D0B@orsmsx503.amr.corp.intel.com> <20081205163752.GA26710@srcf.ucam.org> <4911F71203A09E4D9981D27F9D8308580DD53D76@orsmsx503.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:42240 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751805AbYLERVw (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 5 Dec 2008 12:21:52 -0500
Content-Disposition: inline
In-Reply-To: <4911F71203A09E4D9981D27F9D8308580DD53D76@orsmsx503.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Moore, Robert" <robert.moore@intel.com>
Cc: "Koornstra, Reinoud" <koornstra@hp.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Brown, Len" <len.brown@intel.com>, "Lin, Ming M" <ming.m.lin@intel.com>, "Zhao, Yakui" <yakui.zhao@intel.com>

On Fri, Dec 05, 2008 at 08:58:39AM -0800, Moore, Robert wrote:
> >> 1) Use the RSDT instead of the XSDT and automatically get the "correct"
> >FADT with no 64-bit register definitions.
> >>
> >> 2) Use the XSDT as is done today, but use the 32-bit values instead of
> >the 64-bit values in the extended FADT.
> 
> 
> What we really want to know is what does windows do, (1), or (2).

So far I haven't managed to find any machines that have differing values 
in the version 1 FADT and the 32-bit values of the version 2 one, so 
it's difficult to know. Best bet would probably be a qemu setup that 
feeds different values for this - I think some people in Intel had 
something like this for some previous testing?
