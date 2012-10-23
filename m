From: "Robert P. J. Day" <rpjday@crashcourse.ca>
Subject: does X86_64_ACPI_NUMA completely obsolete AMD_NUMA?
Date: Tue, 23 Oct 2012 07:28:17 -0400 (EDT)
Message-ID: <alpine.DEB.2.02.1210230720500.14423@oneiric>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from astoria.ccjclearline.com ([64.235.106.9]:48437 "EHLO
	astoria.ccjclearline.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751958Ab2JWL2V (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 23 Oct 2012 07:28:21 -0400
Received: from cpec03f0ed08c7f-cm001ac318e826.cpe.net.cable.rogers.com ([174.115.5.73]:38239 helo=crashcourse.ca)
	by astoria.ccjclearline.com with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.77)
	(envelope-from <rpjday@crashcourse.ca>)
	id 1TQcei-00078V-Lr
	for linux-acpi@vger.kernel.org; Tue, 23 Oct 2012 07:28:20 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org


  from arch/x86/Kconfig:

config AMD_NUMA
        def_bool y
        prompt "Old style AMD Opteron NUMA detection"
        depends on X86_64 && NUMA && PCI
        ---help---
          Enable AMD NUMA node topology detection.  You should say Y here if
          you have a multi processor AMD system. This uses an old method to
          read the NUMA configuration directly from the builtin Northbridge
          of Opteron. It is recommended to use X86_64_ACPI_NUMA instead,
          which also takes priority if both are compiled in.

config X86_64_ACPI_NUMA
        def_bool y
        prompt "ACPI NUMA detection"
        depends on X86_64 && NUMA && ACPI && PCI
        select ACPI_NUMA
        ---help---
          Enable ACPI SRAT based node topology detection.


  from the wording above, it's unclear whether someone on x86_64 would
want to select AMD_NUMA if X86_64_ACPI_NUMA is supported.  obviously,
if ACPI is not selected, then the first option makes sense.  but the
help for AMD_NUMA clearly encourages the user to select that option,
even while recommending the second option if it's available.

  and a followup question -- in arch/x86/mm/numa.c, we read:

/**
 * x86_numa_init - Initialize NUMA
 *
 * Try each configured NUMA initialization method until one succeeds.  The
 * last fallback is dummy single node config encomapssing whole memory and
 * never fails.
 */
void __init x86_numa_init(void)
{
        if (!numa_off) {
#ifdef CONFIG_X86_NUMAQ
                if (!numa_init(numaq_numa_init))
                        return;
#endif
#ifdef CONFIG_ACPI_NUMA
                if (!numa_init(x86_acpi_numa_init))
                        return;
#endif
#ifdef CONFIG_AMD_NUMA
                if (!numa_init(amd_numa_init))
                        return;
#endif
        }

        numa_init(dummy_numa_init);
}


  if both of those earlier options are properly selected, is there any
way that the CONFIG_ACPI_NUMA test could fail, while the
CONFIG_AMD_NUMA test would subsequently succeed?  without digging into
the code, it's not clear from the help or comments what the safest
approach is here; as in, even if you select ACPI_NUMA, should you
still select the older AMD_NUMA just to play it safe?

rday

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                        http://crashcourse.ca

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================
