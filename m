From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: [Regression] GPEs being enabled inappropriately
Date: Fri, 10 Dec 2010 17:55:05 +0000
Message-ID: <20101210175505.GA12319@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:33270 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756384Ab0LJRzL (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 10 Dec 2010 12:55:11 -0500
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: rjw@sisk.pl

I've just had a bug report from someone who's seeing high GPE-triggered 
load in .37. It turns out that GPEs 1B and 1E are constantly firing. 
Both have associated _L1B and _L1E methods, but they're also present in 
_PRW methods s should be disabled by default. However, part of the GPE 
rework means that we're now ignoring _PRW methods if the device they're 
associated with reports itself missing in _STA. I think we need to pay 
attention to _PRW regardless of whether or not the device is present, as 
otherwise we may be enabling GPEs that are tied to GPIOs that aren't 
connected to anything at the other end.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
