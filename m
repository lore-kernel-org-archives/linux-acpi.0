From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: 2.6.28-rc7 acpi error messages
Date: Wed, 3 Dec 2008 23:03:32 +0000
Message-ID: <20081203230332.GA26733@srcf.ucam.org>
References: <E92FAF79A8BBC642A36EEE3AA7F152D82A17260164@GVW1089EXB.americas.hpqcorp.net> <4911F71203A09E4D9981D27F9D8308580DD52E96@orsmsx503.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:46426 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754178AbYLCXDo (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 3 Dec 2008 18:03:44 -0500
Content-Disposition: inline
In-Reply-To: <4911F71203A09E4D9981D27F9D8308580DD52E96@orsmsx503.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Moore, Robert" <robert.moore@intel.com>
Cc: "Koornstra, Reinoud" <koornstra@hp.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Brown, Len" <len.brown@intel.com>, "Lin, Ming M" <ming.m.lin@intel.com>

On Wed, Dec 03, 2008 at 02:43:12PM -0800, Moore, Robert wrote:

> Again, can't tell which one is correct.

Windows uses the 32-bit values, so they'll be the correct ones. This is 
an incredibly prevalent problem and we need to just implement Windows 
compatibility here.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
