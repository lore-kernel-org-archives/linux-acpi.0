From: Lin Ming <ming.m.lin@intel.com>
Subject: Re: [patch 0/5] iASL patches in Debian
Date: Thu, 08 Jul 2010 22:14:39 +0000
Message-ID: <1278627279.2164.18.camel@localhost>
References: <20100704044332.573836359@linux.it>
	 <4911F71203A09E4D9981D27F9D830858A10EFE10@orsmsx503.amr.corp.intel.com>
	 <20100707220736.GD5635@kamineko.org>
	 <4911F71203A09E4D9981D27F9D830858A11648F6@orsmsx503.amr.corp.intel.com>
	 <20100708134138.GC1909@kamineko.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:65299 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752221Ab0GHOOn (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 8 Jul 2010 10:14:43 -0400
In-Reply-To: <20100708134138.GC1909@kamineko.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "malattia@linux.it" <malattia@linux.it>
Cc: "Moore, Robert" <robert.moore@intel.com>, Len Brown <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Thu, 2010-07-08 at 21:41 +0800, malattia@linux.it wrote:
> On Wed, Jul 07, 2010 at 04:41:11PM -0700, Moore, Robert wrote:
> > Then be sure to disable the disassembler with an appropriate error
> > message on these architectures.
> 
> Right, makes sense.
> It may take a few more days before I get the time to get back to digging
> into iasl code, I'll see if it's not too hard to support disassembling
> before doing as you suggests.
> 
> > Note, we now have a data table compiler, you should look at that also.
> 
> sure, any pointer to a starting point? :)

We have a nice document, see 
http://www.acpica.org/download/aslcompiler.pdf

Section 2.4 Data Table Compiler

> 
> Thanks!


