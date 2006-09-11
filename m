From: Andi Kleen <ak@suse.de>
Subject: Re: io-apic - no timer ticks after resume on IXP200
Date: Mon, 11 Sep 2006 07:46:58 +0200
Message-ID: <200609110746.58548.ak@suse.de>
References: <20060910141533.GA6594@srcf.ucam.org> <20060910223308.GA1691@elf.ucw.cz> <20060911003129.GA10600@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:35794 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S964900AbWIKF5H (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Mon, 11 Sep 2006 01:57:07 -0400
In-Reply-To: <20060911003129.GA10600@srcf.ucam.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

On Monday 11 September 2006 02:31, Matthew Garrett wrote:
> (Cc:ing Andi because I seem to remember him reworking the code for this
> chipset)

You forgot to mention on which kernel version you're seeing this?
In particular did it work in some kernel version and then stop in another?

BTW here suspend/resume works fine on a IXP200, so it's something
specific to your board.

-Andi
