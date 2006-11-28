From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: AE_NOT_FOUND while evaluating SleepState [\_S3_]
Date: Tue, 28 Nov 2006 02:21:00 +0000
Message-ID: <20061128022059.GA19899@srcf.ucam.org>
References: <1164640682.8724.2.camel@systems03.lan.brontes3d.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([217.147.92.49]:33416 "EHLO
	vavatch.codon.org.uk") by vger.kernel.org with ESMTP
	id S934492AbWK1CVF (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 27 Nov 2006 21:21:05 -0500
Content-Disposition: inline
In-Reply-To: <1164640682.8724.2.camel@systems03.lan.brontes3d.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Daniel Drake <ddrake@brontes3d.com>
Cc: linux-acpi@vger.kernel.org

On Mon, Nov 27, 2006 at 10:18:02AM -0500, Daniel Drake wrote:

> The message produced is:
>         AE_NOT_FOUND while evaluating SleepState [\_S3_]
> 
> Does this system simply not support suspend-to-RAM or can something be
> done on the Linux side?

The absence of an _S3_ object indicates that the system doesn't support 
S3 sleep. Check the BIOS - there may be an option to choose whether it 
supports S1 or S3.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
