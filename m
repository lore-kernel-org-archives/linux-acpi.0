From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] ACPI SBS redesign
Date: Wed, 15 Aug 2007 00:56:47 -0400
Message-ID: <200708150056.47419.lenb@kernel.org>
References: <46BF7422.6090107@suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:39621 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750880AbXHOE4x (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 15 Aug 2007 00:56:53 -0400
In-Reply-To: <46BF7422.6090107@suse.de>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <astarikovskiy@suse.de>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>

On Sunday 12 August 2007 16:57, Alexey Starikovskiy wrote:
> Hi Len,
> 
> Here is the patchset to re-design SBS subsystem.
> It is a lot simpler, uses notifies from ec, rather then timeouts for
> operation
> Finally, notifies on AC removal and alarms are working
> Last patch adds support for sysfs.
> SBS was always marked EXPERIMENTAL, so I think it is possible
> to include these patches in .23

Too late for 2.6.23 for this type/size patch -- we're already post -rc3.
target is 2.6.24-rc1

note that this series didn't apply the 1st time because
it has whitespace errors.

ie. I had to run with
git am --whitespace=warn
instead of 
git am --whitespace=strip
in order for subsequent patches to apply.

thanks,
-Len
