From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH 4/4] ACPI: Make sure the FADT is at least rev 2 before
	using the reset register
Date: Wed, 23 Mar 2011 10:59:06 +0000
Message-ID: <20110323105906.GA29657@srcf.ucam.org>
References: <1299877940-6870-1-git-send-email-mjg@redhat.com> <1299877940-6870-4-git-send-email-mjg@redhat.com> <alpine.LFD.2.02.1103222354150.10549@x980>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:47866 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751109Ab1CWK7O (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 23 Mar 2011 06:59:14 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.02.1103222354150.10549@x980>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org

On Wed, Mar 23, 2011 at 12:01:50AM -0400, Len Brown wrote:
>         if (!(acpi_gbl_FADT.flags & ACPI_FADT_RESET_REGISTER))
>                 return;
> 
> For it not to be redundant, there would have to be FADTs out there
> of revision 1 that set what was then a reserved bit in the flags.

Yes. You trust them not to have set reserved flags to random garbage?

-- 
Matthew Garrett | mjg59@srcf.ucam.org
