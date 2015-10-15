From: "Moore, Robert" <robert.moore@intel.com>
Subject: RE: [PATCH 01/13] ACPICA: Remove unnecessary conditional
 compilation.
Date: Thu, 15 Oct 2015 18:33:13 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E37D98068A@ORSMSX112.amr.corp.intel.com>
References: <aa7d0bcbc2bcc13cf65b7b9a14fa0e6c7329c3b7.1444874756.git.lv.zheng@intel.com>
 <201510152319.YsLO24JO%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:29179 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751674AbbJOSdP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 15 Oct 2015 14:33:15 -0400
In-Reply-To: <201510152319.YsLO24JO%fengguang.wu@intel.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lkp <lkp@intel.com>
Cc: "kbuild-all@01.org" <kbuild-all@01.org>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, "Brown, Len" <len.brown@intel.com>, "Zheng, Lv" <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Box, David E" <david.e.box@intel.com>

This appears as though it is related to this conditional:

#if defined(ACPI_DEBUG_OUTPUT) || defined(ACPI_DEBUGGER)
/*
 * rsinfo
 */
extern ACPI_RSDUMP_INFO         *AcpiGbl_DumpResourceDispatch[];
extern ACPI_RSDUMP_INFO         *AcpiGbl_DumpSerialBusDispatch[];


So, I'm going to let Lv take a look at this.
Bob



> -----Original Message-----
> From: lkp
> Sent: Thursday, October 15, 2015 8:51 AM
> To: Zheng, Lv
> Cc: kbuild-all@01.org; Wysocki, Rafael J; Brown, Len; Zheng, Lv; Lv Zheng;
> linux-kernel@vger.kernel.org; linux-acpi@vger.kernel.org; Moore, Robert
> Subject: Re: [PATCH 01/13] ACPICA: Remove unnecessary conditional
> compilation.
> 
> Hi Bob,
> 
> [auto build test ERROR on pm/linux-next -- if it's inappropriate base,
> please suggest rules for selecting the more suitable base]
> 
> url:    https://github.com/0day-ci/linux/commits/Lv-Zheng/ACPICA-20150930-
> Release/20151015-101636
> config: x86_64-lkp (attached as .config)
> reproduce:
>         # save the attached .config to linux build tree
>         make ARCH=x86_64
> 
> All errors (new ones prefixed by >>):
> 
>    drivers/acpi/acpica/rsdump.c: In function 'acpi_rs_dump_resource_list':
> >> drivers/acpi/acpica/rsdump.c:136:7: error:
> >> 'acpi_gbl_dump_serial_bus_dispatch' undeclared (first use in this
> >> function)
>           acpi_gbl_dump_serial_bus_dispatch
>           ^
>    drivers/acpi/acpica/rsdump.c:136:7: note: each undeclared identifier is
> reported only once for each function it appears in
> >> drivers/acpi/acpica/rsdump.c:141:7: error:
> >> 'acpi_gbl_dump_resource_dispatch' undeclared (first use in this
> >> function)
>           acpi_gbl_dump_resource_dispatch
>           ^
>    drivers/acpi/acpica/rsdump.c: In function 'acpi_rs_dump_irq_list':
> >> drivers/acpi/acpica/rsdump.c:186:40: error: 'acpi_rs_dump_prt'
> >> undeclared (first use in this function)
>       acpi_rs_dump_descriptor(prt_element, acpi_rs_dump_prt);
>                                            ^
>    drivers/acpi/acpica/rsdump.c: In function
> 'acpi_rs_dump_address_common':
> >> drivers/acpi/acpica/rsdump.c:445:37: error:
> >> 'acpi_rs_dump_memory_flags' undeclared (first use in this function)
>       acpi_rs_dump_descriptor(resource, acpi_rs_dump_memory_flags);
>                                         ^
> >> drivers/acpi/acpica/rsdump.c:450:37: error: 'acpi_rs_dump_io_flags'
> >> undeclared (first use in this function)
>       acpi_rs_dump_descriptor(resource, acpi_rs_dump_io_flags);
>                                         ^
> >> drivers/acpi/acpica/rsdump.c:467:36: error:
> >> 'acpi_rs_dump_general_flags' undeclared (first use in this function)
>      acpi_rs_dump_descriptor(resource, acpi_rs_dump_general_flags);
>                                        ^
> 
> vim +/acpi_gbl_dump_serial_bus_dispatch +136 drivers/acpi/acpica/rsdump.c
> 
> 39239fed Bob Moore 2015-04-13  130  		}
> 39239fed Bob Moore 2015-04-13  131
> 39239fed Bob Moore 2015-04-13  132  		/* Dump the resource
> descriptor */
> 39239fed Bob Moore 2015-04-13  133
> 39239fed Bob Moore 2015-04-13  134  		if (type ==
> ACPI_RESOURCE_TYPE_SERIAL_BUS) {
> 39239fed Bob Moore 2015-04-13  135
> 	acpi_rs_dump_descriptor(&resource_list->data,
> 39239fed Bob Moore 2015-04-13 @136
> 	acpi_gbl_dump_serial_bus_dispatch
> 39239fed Bob Moore 2015-04-13  137
> 	[resource_list->data.
> 39239fed Bob Moore 2015-04-13  138
> common_serial_bus.type]);
> 39239fed Bob Moore 2015-04-13  139  		} else {
> 39239fed Bob Moore 2015-04-13  140
> 	acpi_rs_dump_descriptor(&resource_list->data,
> 39239fed Bob Moore 2015-04-13 @141
> 	acpi_gbl_dump_resource_dispatch
> 39239fed Bob Moore 2015-04-13  142
> 	[type]);
> 39239fed Bob Moore 2015-04-13  143  		}
> 39239fed Bob Moore 2015-04-13  144
> 39239fed Bob Moore 2015-04-13  145  		/* Point to the next
> resource structure */
> 39239fed Bob Moore 2015-04-13  146
> 39239fed Bob Moore 2015-04-13  147  		resource_list =
> ACPI_NEXT_RESOURCE(resource_list);
> 39239fed Bob Moore 2015-04-13  148
> 39239fed Bob Moore 2015-04-13  149  		/* Exit when END_TAG
> descriptor is reached */
> 39239fed Bob Moore 2015-04-13  150
> 39239fed Bob Moore 2015-04-13  151  	} while (type !=
> ACPI_RESOURCE_TYPE_END_TAG);
> 39239fed Bob Moore 2015-04-13  152  }
> 39239fed Bob Moore 2015-04-13  153
> 39239fed Bob Moore 2015-04-13  154
> /*************************************************************************
> ******
> 39239fed Bob Moore 2015-04-13  155   *
> 39239fed Bob Moore 2015-04-13  156   * FUNCTION:    acpi_rs_dump_irq_list
> 39239fed Bob Moore 2015-04-13  157   *
> 39239fed Bob Moore 2015-04-13  158   * PARAMETERS:  route_table     -
> Pointer to the routing table to dump.
> 39239fed Bob Moore 2015-04-13  159   *
> 39239fed Bob Moore 2015-04-13  160   * RETURN:      None
> 39239fed Bob Moore 2015-04-13  161   *
> 39239fed Bob Moore 2015-04-13  162   * DESCRIPTION: Print IRQ routing
> table
> 39239fed Bob Moore 2015-04-13  163   *
> 39239fed Bob Moore 2015-04-13  164
> **************************************************************************
> ****/
> 39239fed Bob Moore 2015-04-13  165
> 39239fed Bob Moore 2015-04-13  166  void acpi_rs_dump_irq_list(u8
> *route_table) 39239fed Bob Moore 2015-04-13  167  {
> 39239fed Bob Moore 2015-04-13  168  	struct acpi_pci_routing_table
> *prt_element;
> 39239fed Bob Moore 2015-04-13  169  	u8 count;
> 39239fed Bob Moore 2015-04-13  170
> 39239fed Bob Moore 2015-04-13  171  	ACPI_FUNCTION_ENTRY();
> 39239fed Bob Moore 2015-04-13  172
> 39239fed Bob Moore 2015-04-13  173  	/* Check if debug output enabled
> */
> 39239fed Bob Moore 2015-04-13  174
> 39239fed Bob Moore 2015-04-13  175  	if
> (!ACPI_IS_DEBUG_ENABLED(ACPI_LV_RESOURCES, _COMPONENT)) {
> 39239fed Bob Moore 2015-04-13  176  		return;
> 39239fed Bob Moore 2015-04-13  177  	}
> 39239fed Bob Moore 2015-04-13  178
> 39239fed Bob Moore 2015-04-13  179  	prt_element =
> ACPI_CAST_PTR(struct acpi_pci_routing_table, route_table);
> 39239fed Bob Moore 2015-04-13  180
> 39239fed Bob Moore 2015-04-13  181  	/* Dump all table elements, Exit
> on zero length element */
> 39239fed Bob Moore 2015-04-13  182
> 39239fed Bob Moore 2015-04-13  183  	for (count = 0; prt_element-
> >length; count++) {
> 39239fed Bob Moore 2015-04-13  184  		acpi_os_printf("\n[%02X]
> PCI IRQ Routing Table Package\n",
> 39239fed Bob Moore 2015-04-13  185  			       count);
> 39239fed Bob Moore 2015-04-13 @186
> 	acpi_rs_dump_descriptor(prt_element, acpi_rs_dump_prt);
> 39239fed Bob Moore 2015-04-13  187
> 39239fed Bob Moore 2015-04-13  188  		prt_element =
> ACPI_ADD_PTR(struct acpi_pci_routing_table,
> 39239fed Bob Moore 2015-04-13  189
> prt_element, prt_element->length);
> 
> :::::: The code at line 136 was first introduced by commit
> :::::: 39239fedbfb5493d5804d6cefb806fd208a006c5 ACPICA: Update Resource
> descriptor dump module.
> 
> :::::: TO: Bob Moore <robert.moore@intel.com>
> :::::: CC: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology
> Center
> https://lists.01.org/pipermail/kbuild-all                   Intel
> Corporation
