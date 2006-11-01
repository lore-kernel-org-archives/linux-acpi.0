From: Alexey Starikovskiy <alexey_y_starikovskiy@linux.intel.com>
Subject: Re: udev broken by recent ACPI git commits
Date: Wed, 01 Nov 2006 16:03:58 +0300
Message-ID: <45489B3E.5000609@linux.intel.com>
References: <200611010004.28483.rjw@sisk.pl> <200611010016.25103.len.brown@intel.com> <200611010335.02948.len.brown@intel.com> <200611011147.42498.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga07.intel.com ([143.182.124.22]:14245 "EHLO
	azsmga101.ch.intel.com") by vger.kernel.org with ESMTP
	id S1752110AbWKANEt (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 1 Nov 2006 08:04:49 -0500
In-Reply-To: <200611011147.42498.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, Robert Moore <robert.moore@intel.com>, Alexey Starikovskiy <alexey.y.starikovskiy@intel.com>, Andrew Morton <akpm@osdl.org>

Refael,

Is it possible to get any log from failed and normal boot?

Thanks,
	Alex.

Rafael J. Wysocki wrote:
> On Wednesday, 1 November 2006 09:35, Len Brown wrote:
>>>> One of the following commits out of the git-acpi tree breaks udev on my box
>>>> (HPC nx6325 w/ 64-bit SUSE 10.1):
>> I've removed the acpica branch from the acpi test tree for now
>> so it doesn't block testing of unrelated patches.
>>
>> Rafael,
>> Please confirm that linus + the new acpi test tree works:
>> git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux-acpi-2.6.git test
>> here's a plain patch:
>> http://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/patches/test/2.6.19/acpi-test-20060707-2.6.19-rc3.diff.gz
> 
> Confirmed.
> 
>> Please confirm that linus + just the acpica branch fails:
>> git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux-acpi-2.6.git acpica
>> here's a plain patch:
>> http://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/patches/test/2.6.19/acpi-acpica-20061011-2.6.19-rc3.diff.gz
> 
> Confirmed too.  [Note: It didn't apply cleanly, I had to do one small
> adjustment of a printk() in arch/x86_64/pci/mmconfig.c]
> 
>> Yes, except for a few small changes, this is the moral equivalent of the bisect that you just did.
> 
> No big deal. :-)
> 
>> But as Andrew has bounced git-acpi.patch out of -mm, it seems prudent to
>> do this check before asking him to pull it in again.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
