From: Thomas Renninger <trenn@suse.de>
Subject: Re: ACPI: Unsupported model
Date: Wed, 17 Oct 2007 10:30:58 +0200
Message-ID: <1192609858.9847.634.camel@queen.suse.de>
References: <4714FAFC.8090909@lorenz.kiefner.de>
Reply-To: trenn@suse.de
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:58412 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751567AbXJQIbH (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 17 Oct 2007 04:31:07 -0400
In-Reply-To: <4714FAFC.8090909@lorenz.kiefner.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lorenz Kiefner <mail@lorenz.kiefner.de>
Cc: linux-acpi@vger.kernel.org

On Tue, 2007-10-16 at 19:55 +0200, Lorenz Kiefner wrote:
> Hello!
> I've got a new notebook and kernel 2.6.23 complains, I should send the 
> DSDT to "the developers". It would be nice to see an eMail-address there 
> - I hope this mail gets to the right persons...
> 
> The notebook is a ASUS S37E barebone with a "Santa Rosa"-chipset.
> 
> You can download the DSDT and other ACPI-tables at 
> http://irmhil.de/~lorenz/asus-S37E-acpitables.tar.bz2
> 

Have you checked for a BIOS upgrade for the machine already?
If there is one, better upgrade first, verify whether the bug is still
there and open a bugzilla entry on http://bugzilla.kernel.org and assign
it to the ACPI component and attach acpidump caught from the newly
installed BIOS.

Thanks,

   Thomas

