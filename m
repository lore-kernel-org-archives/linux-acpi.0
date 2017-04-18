From: Linda Knippers <linda.knippers@hpe.com>
Subject: Re: [PATCH] acpi, nfit: fix module unload vs workqueue shutdown race
Date: Tue, 18 Apr 2017 19:16:00 -0400
Message-ID: <58F69E30.2040602@hpe.com>
References: <149253869300.4222.11825248275497461939.stgit@dwillia2-desk3.amr.corp.intel.com>
 <58F68D20.5090607@hpe.com>
 <CAPcyv4jGGiVGigQZMaXo_KfReEAJP=XgmD2GVbDW8hCLaF47Kg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g2t2352.austin.hpe.com ([15.233.44.25]:11065 "EHLO
        g2t2352.austin.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752196AbdDRXQR (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 18 Apr 2017 19:16:17 -0400
In-Reply-To: <CAPcyv4jGGiVGigQZMaXo_KfReEAJP=XgmD2GVbDW8hCLaF47Kg@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dan Williams <dan.j.williams@intel.com>
Cc: "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, Linux ACPI <linux-acpi@vger.kernel.org>

On 04/18/2017 07:05 PM, Dan Williams wrote:

>> It seems a bit better because I can sometimes get a test to complete
>> but then I'll get a panic when I try again.
> 
> Some forward progress... let me go back and try your test script on my
> bare metal config because this patch only addressed the reliable
> failure I was seeing for a single run of "make check".
> 
>> The footprints are the same
>> as before, sometimes when unloading the module but sometimes in a kfree
>> or related function.
>>
>> I'd be interested in your .config file and exactly how you're building
>> your bare metal kernel.
> 
> Here's the config and build + install steps I'm performing.
> 
> https://gist.github.com/djbw/73946ed4e8623aa1ded1b3615ba6d82b
> 

Thanks, I'll try your config.  There are quite a few differences,

-- ljk

