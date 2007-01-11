From: Alexey Starikovskiy <alexey.y.starikovskiy@linux.intel.com>
Subject: Re: ACPI Exception  Could not copy ACPI table
Date: Thu, 11 Jan 2007 15:24:16 +0300
Message-ID: <45A62C70.4040703@linux.intel.com>
References: <45A61965.6080205@tempus.metal.agh.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.89]:30855 "EHLO
	fmsmga101.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1030301AbXAKMYX (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 11 Jan 2007 07:24:23 -0500
In-Reply-To: <45A61965.6080205@tempus.metal.agh.edu.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jarek Durak <jdk@tempus.metal.agh.edu.pl>
Cc: linux-acpi@vger.kernel.org

Jarek Durak wrote:
> ACPI: Looking for DSDT in initramfs... found /DSDT.aml ... successfully
> read 110139 bytes from /DSDT.
> aml
> ACPI: Using customized DSDT
> ACPI Error (tbget-0326): ut_allocate: Could not allocate size 200A202A
> [20060127]
> ACPI Error (tbget-0330): Could not allocate table memory for [/*
> ] length 200A202A [20060127]
> ACPI Exception (tbget-0275): AE_NO_MEMORY, Could not copy ACPI table
> [20060127]
>
> OpenSuSE 10.1 i586 on AmiloA 7800
> 2.6.16.21-0.25-default
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>   
This (loading custom DSDT from initrd image) is unsupported SUSE 
extension, so please open bug against them. What was the reason to use 
custom DSDT?
Size 200a202a seem to be bogus and too high for a table.
