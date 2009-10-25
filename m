From: Chris Vine <chris@cvine.freeserve.co.uk>
Subject: Re: ACPI processor module with Atom N270 causes DMA errors
Date: Sun, 25 Oct 2009 22:35:38 +0000
Message-ID: <20091025223538.6261f9f2@boulder.homenet>
References: <20091025210754.55abdbe6@boulder.homenet>
	<4AE4C70D.2020600@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp5.freeserve.com ([193.252.22.159]:34246 "EHLO
	smtp5.freeserve.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754328AbZJYWhN (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 25 Oct 2009 18:37:13 -0400
In-Reply-To: <4AE4C70D.2020600@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <aystarik@gmail.com>
Cc: linux-acpi@vger.kernel.org

On Mon, 26 Oct 2009 00:45:49 +0300
Alexey Starikovskiy <aystarik@gmail.com> wrote:
> Hi Chris,
> 
> Please open new bug report against ACPI/Processor in
> bugzilla.kernel.org attach outputs from dmesg, acpidump and
> dmidecode. Kernel config file might appear useful too.

Thanks.  This is now the subject of further discussion on the bcm43xx
mailing list, as I am glad to say (from my point of view) that Linux
Torvalds is suffering the same problem, albeit not with an Atom.

I will await the outcome of that before posting a kernel bug for the
processor module (there is some suggestion that the BIOS may be at
fault and that kernel ACPI may just be a side effect).

Chris


