From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: Problem with the Fn+F3 key. acpi problem ?
Date: Sat, 12 Jan 2008 12:46:19 +0000
Message-ID: <20080112124619.GA15578@srcf.ucam.org>
References: <fmaaj5$jsl$1@ger.gmane.org> <20080112121714.GB15173@srcf.ucam.org> <fmac61$oc8$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([78.32.9.130]:60829 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755750AbYALMq0 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 12 Jan 2008 07:46:26 -0500
Content-Disposition: inline
In-Reply-To: <fmac61$oc8$1@ger.gmane.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: giggz <giggzounet@gmail.com>
Cc: linux-acpi@vger.kernel.org

On Sat, Jan 12, 2008 at 01:33:38PM +0100, giggz wrote:

> What is the acpi video module ?

If you have /proc/acpi/video, it's loaded.

> I don't have any /var/log/acpid.log

In that case, try catting /proc/acpi/event and hit the button.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
