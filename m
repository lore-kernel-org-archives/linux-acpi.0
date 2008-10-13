From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH 23/85] ACPI: Clear WAK_STS on resume
Date: Mon, 13 Oct 2008 11:01:37 +0200
Message-ID: <200810131101.37578.borntraeger@de.ibm.com>
References: <1223707005-26864-1-git-send-email-lenb@kernel.org>  <32bd813b0324309ab744d70a93bc5d8b82af36ce.1223706853.git.len.brown@intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mtagate7.uk.ibm.com ([195.212.29.140]:61589 "EHLO
	mtagate7.uk.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755032AbYJMJCX (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 13 Oct 2008 05:02:23 -0400
In-Reply-To: <32bd813b0324309ab744d70a93bc5d8b82af36ce.1223706853.git.len.brown@intel.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Matthew Garrett <mjg59@srcf.ucam.org>, Matthew Garrett <mjg@redhat.com>, Andi Kleen <ak@linux.intel.com>, Len Brown <len.brown@intel.com>

Am Samstag, 11. Oktober 2008 schrieb Len Brown:
> From: Matthew Garrett <mjg59@srcf.ucam.org>
> 
> The leading other brand OS appears to clear the WAK_STS flag on resume.
> When rebooted, certain BIOSes assume that the system is actually
> resuming if it's still set and so fail to reboot correctly. Make sure
> that it's cleared at resume time.
> 
> Comment clarified as suggested by Bob Moore
> 
> Signed-off-by: Matthew Garrett <mjg@redhat.com>
> Signed-off-by: Andi Kleen <ak@linux.intel.com>
> Signed-off-by: Len Brown <len.brown@intel.com>

This patch fixes reboot after suspend on my ASUS P5K.

Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>

