From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH] ACPI: Add missing Thinkpad models to OSI(Linux) white
 list
Date: Fri, 14 Jun 2013 18:45:28 +0100
Message-ID: <20130614174527.GA29875@srcf.ucam.org>
References: <51BB4312.6060302@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:58095 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753623Ab3FNRpl (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 14 Jun 2013 13:45:41 -0400
Content-Disposition: inline
In-Reply-To: <51BB4312.6060302@gmx.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Koch <linrunner@gmx.net>
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org

On Fri, Jun 14, 2013 at 06:21:38PM +0200, Thomas Koch wrote:
> acpi_osi=Linux helps the mute button work properly by sending Linux a
> mute key press.

There was a proper fix for this a while back, but it never seemed to go 
anywhere. Can you try 
http://comments.gmane.org/gmane.linux.drivers.platform.x86.devel/1895 
and see if it works? If so we should just merge that instead.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
