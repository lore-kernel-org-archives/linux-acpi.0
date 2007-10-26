From: "Andrew" <andrew@nelless.net>
Subject: Re: ACPI Exception triggered by pata_amd driver in 2.6.24,
      is this an ACPI bug?
Date: Fri, 26 Oct 2007 13:34:16 +0100 (BST)
Message-ID: <35888.86.7.220.119.1193402056.squirrel@wmbeta.mxes.net>
References: <35314.86.7.220.119.1193248814.squirrel@wmbeta.mxes.net>
    <1193309591.4590.271.camel@queen.suse.de>
    <47213FFD.8060507@gmail.com>
Reply-To: "Andrew" <andrew@nelless.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mxout-04.mxes.net ([216.86.168.179]:2040 "EHLO
	mxout-04.mxes.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753259AbXJZMeS (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 26 Oct 2007 08:34:18 -0400
In-Reply-To: <47213FFD.8060507@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-acpi@vger.kernel.org

On Fri, October 26, 2007 02:16, Tejun Heo wrote:
>
> ATA ACPI is now turned on by default.  It's quite likely that ATA part
> of the ACPI table on that machine is broken.  Can you try to update the BIOS?
>
>
> --
> tejun
>

The BIOS is already up to date and I don't think the mobo manufacturer
has any intention of ever bringing out a new version. I guess I will
just disable ATA_ACPI.

--
Andrew




