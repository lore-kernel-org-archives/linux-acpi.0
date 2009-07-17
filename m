From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: Need ACPI table examples
Date: Fri, 17 Jul 2009 08:59:31 +0800
Message-ID: <1247792371.26272.207.camel@rzhang-dt>
References: <4911F71203A09E4D9981D27F9D8308582ECF6AD9@orsmsx503.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:58010 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751593AbZGQA6l (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 16 Jul 2009 20:58:41 -0400
In-Reply-To: <4911F71203A09E4D9981D27F9D8308582ECF6AD9@orsmsx503.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Moore, Robert" <robert.moore@intel.com>
Cc: "acpi@linux.intel.com" <acpi@linux.intel.com>, linux-acpi <linux-acpi@vger.kernel.org>, "Devel@acpica.org" <Devel@acpica.org>

On Fri, 2009-07-17 at 01:11 +0800, Moore, Robert wrote:
> We are implementing support for new ACPI 4.0 tables in ACPICA, and we need examples of the new tables to help implement and test the disassembler support and related headers.
> 
> If you have any examples of the tables below, we would appreciate it if you would send them. Any format is acceptable. Please mail to me.
> 
> Thanks,
> Bob
> 
> 
> Tables needed:
> 
> IVRS
> MSCT
> UEFI
> WAET
> WDAT
> WDRT
> 

# find -name WDRT*
./13529/WDRT.dsl
./9879/WDRT.dat
./13417/WDRT.dsl
./11135/WDRT.dsl
# find -name WDAT*
./13263/WDAT.dsl
./13023/WDAT.dsl
./13410/WDAT.dsl

I don't find any other tables

the number here stands for the bugzilla entry in bugzilla.kernel.org.
you can get the acpidump there. :)

thanks,
rui


> _______________________________________________
> acpi mailing list
> acpi@linux.intel.com
> http://linux.intel.com/mailman/listinfo/acpi

