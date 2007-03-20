From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: Ambient Light Sensor?
Date: Tue, 20 Mar 2007 15:50:34 +0000
Message-ID: <20070320155034.GA30532@srcf.ucam.org>
References: <200703191341.41823.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([217.147.92.49]:56840 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753838AbXCTPur (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 20 Mar 2007 11:50:47 -0400
Content-Disposition: inline
In-Reply-To: <200703191341.41823.lenb@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org

On Mon, Mar 19, 2007 at 01:41:41PM -0400, Len Brown wrote:

> I've seen just the dmesg from a MacBook Pro on the web
> suggesting that system exports ACPI0008:
> http://www.uwsg.iu.edu/hypermail/linux/kernel/0703.0/1475.html

Yes, it's present in the Macbook Pro. The HP nc6220 has a sensor, but 
doesn't expose it via ACPI - there's some BIOS calls to get at it.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
