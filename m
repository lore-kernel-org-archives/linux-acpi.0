From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH 2/2] ACPI: Override arbitrary ACPI tables via initrd for
 debugging
Date: Mon, 24 Sep 2012 13:27:32 -0700
Message-ID: <5060C234.80006@zytor.com>
References: <1348234085-39220-1-git-send-email-trenn@suse.de> <1348234085-39220-3-git-send-email-trenn@suse.de> <505DD65F.9080203@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from terminus.zytor.com ([198.137.202.10]:56724 "EHLO mail.zytor.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757981Ab2IXU2J (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 24 Sep 2012 16:28:09 -0400
In-Reply-To: <505DD65F.9080203@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Thomas Renninger <trenn@suse.de>, initramfs@vger.kernel.org, robert.moore@intel.com, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, yinghai@kernel.org, eric.piel@tremplin-utc.net, vojcek@tlen.pl, Lin Ming <ming.m.lin@intel.com>

On 09/22/2012 08:16 AM, Len Brown wrote:
> This isn't a NAK, but I'm at best, "like warm" on this.
> 
> I'm not convinced it is a good thing to have - enabled by default -
> the ability for users to easily over-ride ACPI tables.

For the record: I'm fine with the implementation from a technical
standpoint now; I'm completely agnostic on the policy.  Since Len is the
ACPI maintainer this is up to him.

	-hpa

