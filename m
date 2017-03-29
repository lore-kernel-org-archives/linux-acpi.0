From: Aaron Knister <aaron.s.knister@nasa.gov>
Subject: APEI Errors
Date: Wed, 29 Mar 2017 18:10:56 -0400
Message-ID: <62c08eb6-49a4-2982-8a60-572204e2bf31@nasa.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from NDMSVNPF103.ndc.nasa.gov ([198.117.0.153]:39274 "EHLO
        ndmsvnpf103.ndc.nasa.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752944AbdC2W3D (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 29 Mar 2017 18:29:03 -0400
Received: from ndmsppt102.ndc.nasa.gov (ndmsppt102.ndc.nasa.gov [198.117.0.67])
        by ndmsvnpf103.ndc.nasa.gov (Postfix) with ESMTP id B444F4024B4F
        for <linux-acpi@vger.kernel.org>; Wed, 29 Mar 2017 17:10:55 -0500 (CDT)
Received: from pps.filterd (ndmsppt102.ndc.nasa.gov [127.0.0.1])
        by ndmsppt102.ndc.nasa.gov (8.16.0.20/8.16.0.20) with SMTP id v2TM6mtS007488
        for <linux-acpi@vger.kernel.org>; Wed, 29 Mar 2017 17:10:55 -0500
Received: from ndmscht102.ndc.nasa.gov (ndmscht102-pub.ndc.nasa.gov [198.117.0.202])
        by ndmsppt102.ndc.nasa.gov with ESMTP id 29gne8g0at-1
        for <linux-acpi@vger.kernel.org>; Wed, 29 Mar 2017 17:10:55 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

I've got a number of server that when APEI reporting is enabled in the 
BIOS will periodically show messages like these dmesg:

[3989185.213054] {31}[Hardware Error]: Hardware error from APEI Generic 
Hardware Error Source: 0
[3989185.213059] {31}[Hardware Error]: APEI generic hardware error status
[3989185.213063] {31}[Hardware Error]: severity: 2, corrected
[3989185.213066] {31}[Hardware Error]: section: 0, severity: 2, corrected
[3989185.213069] {31}[Hardware Error]: flags: 0x01
[3989185.213072] {31}[Hardware Error]: primary
[3989185.213074] {31}[Hardware Error]: section_type: PCIe error
[3989185.213077] {31}[Hardware Error]: port_type: 4, root port
[3989185.213080] {31}[Hardware Error]: version: 1.16
[3989185.213083] {31}[Hardware Error]: command: 0x0010, status: 0x0547
[3989185.213086] {31}[Hardware Error]: device_id: 0000:04:00.0
[3989185.213089] {31}[Hardware Error]: slot: 0
[3989185.213091] {31}[Hardware Error]: secondary_bus: 0x00
[3989185.213093] {31}[Hardware Error]: vendor_id: 0x1000, device_id: 0x005d
[3989185.213096] {31}[Hardware Error]: class_code: 040100

The kernel is on the older side, it's a SLES11 kernel (3.0.101), and PCI 
device 0000:04:00.0 is an LSI-based RAID controller.

All I've been able to figure out here is that an error happened and it 
was corrected but I've not been able to figure out (and I've tried 
scouring the ACPI, UEFI, and PCIe specs) *what* happened (e.g. command 
timeout, parity error, etc.).

I found this file 
http://lxr.free-electrons.com/source/Documentation/acpi/apei/output_format.txt?v=3.0 
that seems to outline the output format of apei errors and there's a 
whole bunch of aer_* fields that can appear with PCIe errors but I'm not 
seeing any of those here.

My questions, specifically are:

1. Is this event data enough alone to identify what kind of an error 
occurred here? If so what error was it?
2. Should there be additional aer_ fields with the error? If so how can 
I see them and is it up to the firmware to pass these along? Are there 
some ACPI table I can query that would indicate whether or not the 
hardware is configured to report them?

Thanks!

-Aaron

-- 
Aaron Knister
NASA Center for Climate Simulation (Code 606.2)
Goddard Space Flight Center
(301) 286-2776
