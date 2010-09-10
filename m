From: Thomas Renninger <trenn@suse.de>
Subject: Re: [Devel] False positive iasl compiler error on resource object?
Date: Fri, 10 Sep 2010 22:19:23 +0200
Message-ID: <201009102219.23520.trenn@suse.de>
References: <201009101133.31663.trenn@suse.de> <4911F71203A09E4D9981D27F9D830858AF0CA981@orsmsx503.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:52657 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755233Ab0IJUTo (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 10 Sep 2010 16:19:44 -0400
In-Reply-To: <4911F71203A09E4D9981D27F9D830858AF0CA981@orsmsx503.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Moore, Robert" <robert.moore@intel.com>
Cc: "devel@acpica.org" <devel@acpica.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "bjorn.helgaas@hp.com" <bjorn.helgaas@hp.com>

On Friday 10 September 2010 17:04:34 Moore, Robert wrote:
> We've provided the -cr option to disable the resource descriptor error
> checking.
AFAIK, these zeroed resources that get filled up dynamically later are a 
rather common construct. If below additional checks cannot be added
this (these?) specific resource checks should better get disabled.

> This is an interesting problem. On one hand, we would like to provide
> static (compile time) error checking as much as possible. On the other
> hand, the resource descriptors (as well as most any other ASL/AML
> object) can be dynamically changed.
> 
> We've seen many ACPI tables with invalid resource descriptors (at both
> compile time and runtime), and that is the reason the resource
> descriptor validation was added to the compiler in the first place.
> 
> I don't want to just remove this validation, but yes, perhaps iASL
> should be able to recognize that this descriptor may be modified at
> runtime and therefore a static validation cannot be performed.
> 
> There are at least a few indicators:
> 
> 1) The descriptor is basically all zeroes
> 2) There is a CreateXxxField reference to the descriptor
> 3) There is a Store to the created field
> 
> So, perhaps we could detect the above conditions and then disable
> validation for this particular descriptor. Note, conditions (2) and
> (3) may be difficult to detect.
> 
> I'm open to suggestions.
Not sure whether runtime checks for this exist already.
Bjorn has done some great work there in the past.
If not, that should be by far easier, the so called "low hanging 
fruit"...

    Thomas
