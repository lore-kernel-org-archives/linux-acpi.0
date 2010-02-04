From: Larry Finger <Larry.Finger@lwfinger.net>
Subject: Re: [PATCH v1 0/7] PCI: try enabling "pci=use_crs" again
Date: Thu, 04 Feb 2010 16:36:34 -0600
Message-ID: <4B6B4BF2.6080309@lwfinger.net>
References: <20100203233617.10803.92102.stgit@bob.kio> <4B6A4F17.2080806@lwfinger.net> <201002041055.58953.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-gx0-f224.google.com ([209.85.217.224]:57682 "EHLO
	mail-gx0-f224.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758479Ab0BDWgk (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 4 Feb 2010 17:36:40 -0500
In-Reply-To: <201002041055.58953.bjorn.helgaas@hp.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Jesse Barnes <jbarnes@virtuousgeek.org>, Matthew Garrett <mjg59@srcf.ucam.org>, Tony Luck <tony.luck@intel.com>, linux-pci@vger.kernel.org, Peter Haight <peterh@sapros.com>, Gary Hade <garyhade@us.ibm.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>, Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@linux-foundation.org>

On 02/04/2010 11:55 AM, Bjorn Helgaas wrote:
> On Wednesday 03 February 2010 09:37:43 pm Larry Finger wrote:
>> On 02/03/2010 05:38 PM, Bjorn Helgaas wrote:
>>> Larry, you reported the problem the last time I tried to turn on "pci=use_crs"
>>> by default.  This series shouldn't affect your machine because it's not in the
>>> whitelist, but I expect that if you boot the current kernel with "pci=use_crs",
>>> it should still fail, and if you boot with these patches and "pci=use_crs", it
>>> *should* work.  I know it's a lot to ask, but it'd be great if you had a chance
>>> to try that.
>>
>> On my system, "git describe" returns v2.6.33-rc6-146-gc80d292. Patch 1 does not
>> apply and can be reverted. That is not a problem, but beginning with patch 5,
>> these do not apply.
> 
> Looks like you're using Linus' tree.  My patches go on top of Jesse's
> PCI linux-next tree.  Here's how you can do this (assuming you have
> stgit as well as git):
> 
>   Save all the patches in files "/tmp/use-crs.1" through "/tmp/use-crs.7".
>   These can be plain email; you don't have to remove headers or
>   anything.
> 
>   $ cd <git repo>
>   $ git branch
>   $ git fetch git://git.kernel.org/pub/scm/linux/kernel/git/jbarnes/pci-2.6.git linux-next
>   $ stg branch -c use-crs 0148b041be4e7
>   $ for F in `seq 7`; do stg import -m /tmp/use-crs.$F; done
> 
> Now you should have a tree with all the patches applied.

That worked. I actually used quilt to apply the patches as I am more familiar
with it. Patch #2 was already applied, but the rest applied cleanly.

The patched version of the linux-next kernel booted fine. I put the dmesg output
as "Attachment #24914  to bug 14183".

Thanks for the help,

Larry
