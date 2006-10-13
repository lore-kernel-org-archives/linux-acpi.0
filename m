From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: Preventing ACPI from Damaging Your CPU
Date: Fri, 13 Oct 2006 02:24:30 +0100
Message-ID: <20061013012430.GA31911@srcf.ucam.org>
References: <1160663160.13196.273175261@webmail.messagingengine.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([217.147.92.49]:6103 "EHLO
	vavatch.codon.org.uk") by vger.kernel.org with ESMTP
	id S1751443AbWJMBYi (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 12 Oct 2006 21:24:38 -0400
Content-Disposition: inline
In-Reply-To: <1160663160.13196.273175261@webmail.messagingengine.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mathew Brown <mathewbrown@fastmail.fm>
Cc: linux-acpi@vger.kernel.org

On Thu, Oct 12, 2006 at 07:26:00AM -0700, Mathew Brown wrote:

>   I've been reading an alarming article on getting Gentoo to work on the
>   HP Compaq nx6325
>   (http://gentoo-wiki.com/HARDWARE_Gentoo_on_HP_Compaq_nx6325) and the
>   serious ACPI problems that were encountered.  The author states after
>   mentioning how to apply certain patches, "Without that, the CPU might
>   overheat and get damaged during heavy load (such as compiling a Gentoo
>   stage ...)!"

The author is wrong. Recent HP laptops all have hardcoded support in the 
fan control hardware, which will force the fan on if the temperature 
rises above 80 degrees.
-- 
Matthew Garrett | mjg59@srcf.ucam.org
