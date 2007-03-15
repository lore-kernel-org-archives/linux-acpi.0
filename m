From: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
Subject: Re: CONFIG_IBM_BAY
Date: Thu, 15 Mar 2007 11:01:56 -0700
Message-ID: <20070315110156.09e80b99.kristen.c.accardi@intel.com>
References: <11736588493609-git-send-email-hmh@hmh.eng.br>
	<20070315031015.GA6292@khazad-dum.debian.net>
	<20070315031251.GB6292@khazad-dum.debian.net>
	<200703150206.05811.lenb@kernel.org>
	<20070315133900.GC26862@khazad-dum.debian.net>
	<20070315080644.c73db24a.kristen.c.accardi@intel.com>
	<20070315175505.GB6596@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:36567 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751292AbXCOSE6 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 15 Mar 2007 14:04:58 -0400
In-Reply-To: <20070315175505.GB6596@khazad-dum.debian.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, ibm-acpi-devel@lists.sourceforge.net

On Thu, 15 Mar 2007 14:55:06 -0300
Henrique de Moraes Holschuh <hmh@hmh.eng.br> wrote:

> Note that these are all just stop-gap measures.  We either need to have
> ACPI_BAY do everything needed in ThinkPads (like handling bay batteries), or
> to make both drivers work together, or I'll just pull all the ACPI_BAY
> functionality into ibm-acpi (and then I will definately conflict with
> ACPI_BAY).

I think we should focus our efforts on a generic (non platform specific) 
solution that can work across many laptops (i.e. ACPI_BAY).  Let's make
the bay driver do what it should - I've got a stack of modules for Dell
module bays we can check against too - and I believe that Dell also 
supports charging the battery in the module bay.  I am happy to take 
patches to the bay driver, and am also happy to help develop them.  
I don't have handling content of bay changes on my radar at the moment, 
so if you do have time to work on this, that would be great.  I am happy 
to test on the set of laptops I've got.

Thanks,
Kristen
