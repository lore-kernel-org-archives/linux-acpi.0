From: Thomas Renninger <trenn@suse.de>
Subject: Re: new pmtools available for testing
Date: Wed, 22 Nov 2006 14:55:42 +0100
Message-ID: <1164203742.3721.346.camel@queen.suse.de>
References: <45634459.8040404@linux.intel.com>
Reply-To: trenn@suse.de
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ns1.suse.de ([195.135.220.2]:16002 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1755887AbWKVNzn (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Wed, 22 Nov 2006 08:55:43 -0500
In-Reply-To: <45634459.8040404@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <alexey.y.starikovskiy@linux.intel.com>
Cc: "Brown, Len" <len.brown@intel.com>, linux-acpi@vger.kernel.org

On Tue, 2006-11-21 at 21:24 +0300, Alexey Starikovskiy wrote:
> Hi,
> 
> acpixtract perl-script is being replaced by C xtract utility. Please test.
> Advances are:
>     - Perl not required :)
>     - no 64k output limit of perl-script
>     - --list option shows all tables in the file
>     - unified interface with acpidump
>     - faster(?)
> 
> Thanks in advance,
Is this acpixtract that already existed in ACPICA since some time and
now moved to pmtools?

If yes, I can say that it's working stable (at least older ACPICA vers)
and makes live easier.

Thanks,

   Thomas

