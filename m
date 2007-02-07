From: Alexey Starikovskiy <alexey.y.starikovskiy@linux.intel.com>
Subject: Re: acpi change between 2.6.8.1 and 2.6.17 breaks Tyan S2466N power
 button
Date: Wed, 07 Feb 2007 21:56:52 +0300
Message-ID: <45CA20F4.9050205@linux.intel.com>
References: <E1HErfN-00051j-Dm@mendel.bio.caltech.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.89]:24918 "EHLO
	fmsmga101.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1422870AbXBGS5F (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 7 Feb 2007 13:57:05 -0500
In-Reply-To: <E1HErfN-00051j-Dm@mendel.bio.caltech.edu>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: David Mathog <mathog@caltech.edu>
Cc: linux-acpi@vger.kernel.org

Please open bug at bugzilla.kernel.org for ACPI/Button, attach dmesg, 
acpidump,config.
Also please try stock kernel (2.6.20?) -- as it could be 
Mandriva-specific bug...

Regards,
    Alex.

David Mathog wrote:
>   
>> Could it be that you don't load button module?
>>     
>
> Good guess but "button" is loaded, that was the first
> thing I checked.  Here is the output of lsmod:
>
> Module                  Size  Used by
> ipv6                  237120  12
> w83627hf               24848  0
> nfs                   215916  3
> lockd                  56360  2 nfs
> nfs_acl                 3776  1 nfs
> sunrpc                137532  4 nfs,lockd,nfs_acl
> eeprom                  6320  0
> w83781d                31368  0
> hwmon_vid               3392  2 w83627hf,w83781d
> i2c_isa                 4352  2 w83627hf,w83781d
> i2c_amd756              6436  0
> i2c_core               17536  5 w83627hf,eeprom,w83781d,i2c_isa,i2c_amd756
> 3c59x                  40616  0
> mii                     5664  1 3c59x
> af_packet              17960  2
> iptable_filter          3232  0
> iptable_mangle          3104  0
> iptable_nat             7652  0
> ip_nat                 15692  1 iptable_nat
> ip_conntrack           48320  2 iptable_nat,ip_nat
> nfnetlink               5912  2 ip_nat,ip_conntrack
> iptable_raw             2496  0
> ip_tables              12740  4
> iptable_filter,iptable_mangle,iptable_nat,iptable_raw
> x_tables               12132  2 iptable_nat,ip_tables
> video                  13924  0
> thermal                11240  0
> fan                     4036  0
> container               3968  0
> button                  5808  0
> battery                 8260  0
> ac                      4292  0
> ide_cd                 35776  0
> binfmt_misc             9800  1
> loop                   15400  0
> dm_mod                 49944  0
> cpufreq_ondemand        6956  0
> cpufreq_conservative     6952  0
> cpufreq_powersave       2400  0
> freq_table              4800  0
> processor              21448  1 thermal
> amd_k7_agp              7660  1
> agpgart                27240  1 amd_k7_agp
> hw_random               5688  0
> evdev                   8864  1
> tsdev                   7040  0
> ext3                  124936  3
> jbd                    51028  1 ext3
>
>
> Next guess?
>
> Thanks,
>
> David Mathog
> mathog@caltech.edu
> Manager, Sequence Analysis Facility, Biology Division, Caltech
> -
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>   
