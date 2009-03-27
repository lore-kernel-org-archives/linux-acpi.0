From: Len Brown <lenb@kernel.org>
Subject: Re: [patch] x86, acpi: add support for x2apic ACPI extensions
Date: Fri, 27 Mar 2009 18:24:07 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0903271822190.26419@localhost.localdomain>
References: <1238013838.27006.435.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173019pub.verizon.net ([206.46.173.19]:47239 "EHLO
	vms173019pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753042AbZC0WY1 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 27 Mar 2009 18:24:27 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms173019.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KH6000JERKAGRGY@vms173019.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 27 Mar 2009 17:24:12 -0500 (CDT)
In-reply-to: <1238013838.27006.435.camel@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Suresh Siddha <suresh.b.siddha@intel.com>
Cc: linux-acpi@vger.kernel.org, venkatesh.pallipadi@intel.com, mingo@elte.hu, hpa@linux.intel.com, steiner@sgi.com


scripts/checkpatch.pl

ERROR: "foo * bar" should be "foo *bar"
#34: FILE: arch/x86/kernel/acpi/boot.c:233:
+acpi_parse_x2apic(struct acpi_subtable_header * header, const unsigned 
long end)

WARNING: line over 80 characters
#70: FILE: arch/x86/kernel/acpi/boot.c:321:
+acpi_parse_x2apic_nmi(struct acpi_subtable_header * header, const 
unsigned long end)

ERROR: "foo * bar" should be "foo *bar"
#70: FILE: arch/x86/kernel/acpi/boot.c:321:
+acpi_parse_x2apic_nmi(struct acpi_subtable_header * header, const 
unsigned long end)

WARNING: line over 80 characters
#109: FILE: arch/x86/kernel/acpi/boot.c:883:
+	    acpi_table_parse_madt(ACPI_MADT_TYPE_LOCAL_X2APIC_NMI, 
acpi_parse_x2apic_nmi, 0);

WARNING: line over 80 characters
#169: FILE: drivers/acpi/numa.c:140:
+					  "SRAT Processor 
(x2apicid[0x%08x]) in proximity domain %d %s\n",

ERROR: spaces required around that '?' (ctx:VxE)
#172: FILE: drivers/acpi/numa.c:143:
+					  (p->flags & 
ACPI_SRAT_CPU_ENABLED)?
 					                                    
^

ERROR: "foo * bar" should be "foo *bar"
#194: FILE: drivers/acpi/numa.c:207:
+acpi_parse_x2apic_affinity(struct acpi_subtable_header * header,

WARNING: usage of NR_CPUS is often wrong - consider using cpu_possible(), 
num_possible_cpus(), for_each_possible_cpu(), etc
#220: FILE: drivers/acpi/numa.c:287:
+				      NR_CPUS);

WARNING: space prohibited between function name and open parenthesis '('
#232: FILE: include/linux/acpi.h:100:
+void acpi_numa_x2apic_affinity_init (struct acpi_srat_x2apic_cpu_affinity 
*pa);

WARNING: line over 80 characters
#295: FILE: drivers/acpi/tables.c:72:
+			       (p->lapic_flags & ACPI_MADT_ENABLED) ? 
"enabled" : "disabled");

WARNING: line over 80 characters
#313: FILE: drivers/acpi/tables.c:137:
+			       mps_inti_flags_polarity[p->inti_flags & 
ACPI_MADT_POLARITY_MASK	],

ERROR: space prohibited before that close square bracket ']'
#313: FILE: drivers/acpi/tables.c:137:
+			       mps_inti_flags_polarity[p->inti_flags & 
ACPI_MADT_POLARITY_MASK	],

WARNING: line over 80 characters
#314: FILE: drivers/acpi/tables.c:138:
+			       mps_inti_flags_trigger[(p->inti_flags & 
ACPI_MADT_TRIGGER_MASK) >> 2],

total: 5 errors, 8 warnings, 259 lines checked


--
Len Brown, Intel Open Source Technology Center

