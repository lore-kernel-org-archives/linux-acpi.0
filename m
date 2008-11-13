From: Lin Ming <ming.m.lin@intel.com>
Subject: Re: ACPICA Release 20081031 linuxized patch set
Date: Thu, 13 Nov 2008 15:54:56 +0800
Message-ID: <1226562896.30025.176.camel@minggr.sh.intel.com>
References: <1226555956.30025.150.camel@minggr.sh.intel.com>
	 <1226556783.30025.154.camel@minggr.sh.intel.com>
	 <alpine.LFD.2.00.0811130147180.21141@localhost.localdomain>
	 <alpine.LFD.2.00.0811130230060.21141@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:6833 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751081AbYKMH4j (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 13 Nov 2008 02:56:39 -0500
In-Reply-To: <alpine.LFD.2.00.0811130230060.21141@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: "Moore, Robert" <robert.moore@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, acpi <acpi@linux.intel.com>

On Thu, 2008-11-13 at 15:31 +0800, Len Brown wrote:
> 
> $ git bisect bad
> 7a55a3d54bd8d9e712e70cf9491f649e7e472a22 is first bad commit
> commit 7a55a3d54bd8d9e712e70cf9491f649e7e472a22
> Author: Bob Moore <robert.moore@intel.com>
> Date:   Thu Nov 13 11:08:59 2008 +0800
> 
>     ACPICA: Add Buffer->String conversion for predefined methods
>     
>     For predefined methods (such as _BIF), add automatic conversion for
>     objects that are required to be a String, but a Buffer was found
>     instead. This can happen when reading string battery data from
>     an operation region, because it used to be difficult to convert
>     the data from buffer to string from within the ASL. Linux BZ 11822.
>     
>     http://bugzilla.kernel.org/show_bug.cgi?id=11822
> 

Thanks, I'm looking at this.

Lin Ming

