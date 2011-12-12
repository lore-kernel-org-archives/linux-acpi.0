From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Re-add ibft tree to linux-next please
Date: Mon, 12 Dec 2011 15:25:11 -0800
Message-ID: <4EE68D57.7030603@zytor.com>
References: <20111212145330.GA16278@andromeda.dapyr.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from terminus.zytor.com ([198.137.202.10]:43211 "EHLO mail.zytor.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752023Ab1LLXZ3 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 12 Dec 2011 18:25:29 -0500
In-Reply-To: <20111212145330.GA16278@andromeda.dapyr.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Konrad Rzeszutek Wilk <konrad@kernel.org>, "Brown, Len" <len.brown@intel.com>, linux-acpi@vger.kernel.org
Cc: sfr@canb.auug.org.au, linux-next@vger.kernel.org, linux-kernel@vger.kernel.org, pjones@redhat.com

On 12/12/2011 06:53 AM, Konrad Rzeszutek Wilk wrote:
> Hey Stephen,
> 
> I've one patch for the iBFT and since I am the co-maintainer of said tree,
> please add this tree to your awesome build system:
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/konrad/ibft.git
> 
> The branch is "linux-next"
> 
> Signed-off-by: Konrad Rzeszutek Wilk <konrad@kernel.org>
> CC: Peter Jones <pjones@redhat.com>
> Thanks!
> 
> P.S.
> After kernel.org went down, I choose not to resurface the iBFT tree b/c I
> figured that the driver was sooo stable that there would be no need for any
> patches. Well, not the case

iBFT is basically an ACPI table with nonstandard discovery.  Any way we
could get this merged into the ACPI core eventually?

	-hpa

