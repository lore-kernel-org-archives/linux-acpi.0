From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [patch 1/3] acpi: check _PSS invalidation when BIOS report
	_PSS with 0x80000000
Date: Mon, 25 May 2009 12:01:52 +0100
Message-ID: <20090525110152.GA31474@srcf.ucam.org>
References: <200905122054.n4CKsfa3001669@imap1.linux-foundation.org> <alpine.LFD.2.00.0905141335000.24833@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:40709 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751375AbZEYLCE (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 25 May 2009 07:02:04 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.0905141335000.24833@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: akpm@linux-foundation.org, linux-acpi@vger.kernel.org, youquan.song@intel.com, venkatesh.pallipadi@intel.com

On Thu, May 14, 2009 at 01:35:10PM -0400, Len Brown wrote:
> NAK
> 
> This is a recording.
> 
> Andrew, please remove this patch from your series
> per issues earlier discussed on the list.

On the dump I have from a machine showing this issue, we'd fail 
gracefully if we checked the return value of 
acpi_processor_preregister_performance() as the coordination type is set 
to an invalid value. Are there any cases where this fails and the 
hardware still works? If not, then:

diff --git a/arch/x86/kernel/cpu/cpufreq/acpi-cpufreq.c b/arch/x86/kernel/cpu/cpufreq/acpi-cpufreq.c
index 208ecf6..fbb8e59 100644
--- a/arch/x86/kernel/cpu/cpufreq/acpi-cpufreq.c
+++ b/arch/x86/kernel/cpu/cpufreq/acpi-cpufreq.c
@@ -561,7 +561,11 @@ static int __init acpi_cpufreq_early_init(void)
 	}
 
 	/* Do initialization in ACPI core */
-	acpi_processor_preregister_performance(acpi_perf_data);
+	if (acpi_processor_preregister_performance(acpi_perf_data)) {
+		free_acpi_perf_data();
+		return -EINVAL;
+	}
+
 	return 0;
 }
 
would seem to be correct. The alternative is that the number of 
processors is also set to 0x80000000 - according to the spec "OSPM will 
not start performing power state transitions to a particular P-state 
until this number of processors belonging to the same domain have been 
detected and started". Since we're clearly never reaching that 
condition, why is the governor even getting started?

-- 
Matthew Garrett | mjg59@srcf.ucam.org
