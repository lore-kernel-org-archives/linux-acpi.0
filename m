From: Matthew Garrett <mjg@redhat.com>
Subject: [PATCH 0/3] acpica: Rewrite GPE handling
Date: Mon, 9 Nov 2009 22:20:03 +0000
Message-ID: <20091109222003.GA3424@srcf.ucam.org>
References: <4911F71203A09E4D9981D27F9D83085837684E6D@orsmsx503.amr.corp.intel.com> <20090916145517.GA24333@srcf.ucam.org> <4911F71203A09E4D9981D27F9D830858376D879E@orsmsx503.amr.corp.intel.com> <20090916164448.GA26552@srcf.ucam.org> <7276C2EDBEF0FA4AAA4A8FAD7DE3436531596BE0@orsmsx503.amr.corp.intel.com> <4911F71203A09E4D9981D27F9D830858376D905E@orsmsx503.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:37960 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750845AbZKIWUF (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 9 Nov 2009 17:20:05 -0500
Content-Disposition: inline
In-Reply-To: <4911F71203A09E4D9981D27F9D830858376D905E@orsmsx503.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Moore, Robert" <robert.moore@intel.com>
Cc: "Lin, Ming M" <ming.m.lin@intel.com>, linux-acpi@vger.kernel.org, mjg@redhat.com

This is a rework of my original set of GPE rework patches. The principle 
difference is that I've readded the scan of _PWR methods in the initial 
GPE parsing - though there's little distinction between runtime and 
wakeup GPEs after this patchset (other than whether they can wake the 
system), it's still necessary to do this in order to retain the existing 
behaviour of enabling all GPEs with methods *except* for those that are 
able to wake the system.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
