From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH] ACPI: Ignore the upper bits of SystemIO addresses
Date: Tue, 18 May 2010 21:56:40 +0100
Message-ID: <20100518205640.GA4183@srcf.ucam.org>
References: <1274206035-10571-1-git-send-email-mjg@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:50446 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753225Ab0ERU4q (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 18 May 2010 16:56:46 -0400
Content-Disposition: inline
In-Reply-To: <1274206035-10571-1-git-send-email-mjg@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: robert.moore@intel.com, lenb@kernel.org

Actually, let's ignore this one for now - it makes more sense for this 
to be a conditional workaround.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
