From: "Brown, Len" <len.brown@intel.com>
Subject: Re: ACPI slab stats
Date: Thu, 9 Mar 2006 01:00:01 -0500
Message-ID: <F7DC2337C7631D4386A2DF6E8FB22B3006523B5E@hdsmsx401.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fmr21.intel.com ([143.183.121.13]:9148 "EHLO
	scsfmr001.sc.intel.com") by vger.kernel.org with ESMTP
	id S1751021AbWCIGAG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 9 Mar 2006 01:00:06 -0500
Received: from scsfmr101.sc.intel.com (scsfmr101.sc.intel.com [10.3.253.10])
	by scsfmr001.sc.intel.com (8.12.10/8.12.10/d: major-outer.mc,v 1.1 2004/09/17 17:50:56 root Exp $) with ESMTP id k29604wS004612
	for <linux-acpi@vger.kernel.org>; Thu, 9 Mar 2006 06:00:04 GMT
Received: from fmsmsxvs043.fm.intel.com (fmsmsxvs043.fm.intel.com [132.233.42.129])
	by scsfmr101.sc.intel.com (8.12.10/8.12.10/d: major-inner.mc,v 1.2 2004/09/17 18:05:01 root Exp $) with SMTP id k295sBgf025901
	for <linux-acpi@vger.kernel.org>; Thu, 9 Mar 2006 05:54:29 GMT
Received: from fmsmsx332.amr.corp.intel.com ([132.233.42.148])
 by fmsmsxvs043.fm.intel.com (SAVSMTP 3.1.7.47) with SMTP id M2006030822000301031
 for <linux-acpi@vger.kernel.org>; Wed, 08 Mar 2006 22:00:03 -0800
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

These three jump out as worth thinking about:

> [02:40] <viro> acpi_operand: ffffffff801d90af
<acpi_os_acquire_object+b/3e> 1344

/proc/slabinfo on my 64-bit box shows these are 96 bytes each
with CONFIG_DEBUG_SLAB=y, and 72 bytes each for CONFIG_DEBUG_SLAB=n.

1344*72 = 96KB

sizeof(union acpi_operand_object) is 72, but that is significantly
larger than many of its possible members:

union acpi_operand_object 72

struct acpi_object_common 24
struct acpi_object_integer 32
struct acpi_object_string 32
struct acpi_object_buffer 56
struct acpi_object_package 56
struct acpi_object_event 32
struct acpi_object_method 56
struct acpi_object_mutex 72
struct acpi_object_region 64
struct acpi_object_notify_common 48
struct acpi_object_device 56
struct acpi_object_power_resource 56
struct acpi_object_processor 64
struct acpi_object_thermal_zone 48
struct acpi_object_field_common 56
struct acpi_object_region_field 56
struct acpi_object_buffer_field 56
struct acpi_object_bank_field 64
struct acpi_object_index_field 64
struct acpi_object_notify_handler 48
struct acpi_object_addr_handler 72
struct acpi_object_reference 48
struct acpi_object_extra 48
struct acpi_object_data 40
struct acpi_object_cache_list 32 

Bob,
is it conceivable to split this union up into multiple types
to beneift from making the smaller uses small?

> [02:42] <viro> size-128: ffffffff801ff0f8 <acpi_ut_callocate+57/d3>
801

801*128 = 102KB

Hmmm, expect this to be from 

note sure where these are from.  some of the ACPI_MEM_CALLOCATE
sizes are these:

struct acpi_namespace_node 40
struct acpi_walk_state 984
struct acpi_handler_info 24
struct acpi_pci_id 8
struct acpi_device_info 104
struct fadt_descriptor_rev2 244
struct acpi_table_desc 72 


> [02:41] <viro> size-1024: ffffffff8021a01e
<acpi_add_single_object+7b/22e> 56

1024 * 56 = 56KB

These are struct acpi_device, which break out like this:

struct acpi_device 960

void * 8
struct acpi_device * 8
struct list_head 16
struct list_head 16
struct list_head 16
struct list_head 16
struct acpi_device_status 4
struct acpi_device_flags 4
struct acpi_device_pnp 112
struct acpi_device_power 424
struct acpi_device_wakeup 120
struct acpi_device_perf 24
struct acpi_device_dir 8
struct acpi_device_ops 88
struct acpi_driver * 8
void * 8
struct kobject 80  

here we lose (1024 - 960) = 64 bytes/entry on rounding error
56 * 65 = 3.5 KB of padding

struct acpi_device_power 424:

struct acpi_device_power_flags 4
struct acpi_device_power_state 104
struct acpi_device_power_state 104
struct acpi_device_power_state 104
struct acpi_device_power_state 104

struct acpi_device_power_state 104:

int 4
int 4
struct acpi_handle_list 88     

which comes from this:

/* TBD: Make dynamic */
#define ACPI_MAX_HANDLES        10
struct acpi_handle_list {
        u32 count;
        acpi_handle handles[ACPI_MAX_HANDLES];
};

So 80-bytes can be wrung out of acpi_handle_list,
saving 320/424 bytes of acpi_device_power.
saving 320/960 bytes of acpi_device
gettig it down to 640 bytes -- though with the current
scheme that will still be rounded up to the 1024-byte slab.

volunteers?

-Len


