From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH 25/70] ACPICA: Update disassembler for DMAR table changes
Date: Fri, 20 Jun 2008 12:52:01 +0100
Message-ID: <20080620115201.GB8637@srcf.ucam.org>
References: <087803d18fb8259cb844c075a35fb27c2d80792e.1213947349.git.len.brown@intel.com> <ee61cb033678eaf16901813eb6394dafa51e9c85.1213947350.git.len.brown@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:49591 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751292AbYFTLwF (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 20 Jun 2008 07:52:05 -0400
Content-Disposition: inline
In-Reply-To: <ee61cb033678eaf16901813eb6394dafa51e9c85.1213947350.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>, Lin Ming <ming.m.lin@intel.com>, Len Brown <len.brown@intel.com>

On Fri, Jun 20, 2008 at 03:43:27AM -0400, Len Brown wrote:
>  extern struct acpi_dmtable_info acpi_dm_table_info_dmar1[];
> +extern struct acpi_dmtable_info acpi_dm_table_info_dmar2[];
>  extern struct acpi_dmtable_info acpi_dm_table_info_ecdt[];

Maybe I'm missing something here, but we don't actually seem to have the 
disassembler code in Linux? It would be nice if we did (as a debug 
option) - I'd love to be able to dump a disassembled version of what's 
actually getting executed in response to events.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
