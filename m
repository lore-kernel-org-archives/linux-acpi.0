From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH 5/7] x86 platform drivers: hp-wmi Set placeholder for
	unimplemented events
Date: Fri, 28 May 2010 14:33:14 +0100
Message-ID: <20100528133314.GB25189@srcf.ucam.org>
References: <1274451495-10252-1-git-send-email-trenn@suse.de> <1274451495-10252-6-git-send-email-trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:39564 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755267Ab0E1NdR (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 28 May 2010 09:33:17 -0400
Content-Disposition: inline
In-Reply-To: <1274451495-10252-6-git-send-email-trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org

On Fri, May 21, 2010 at 04:18:13PM +0200, Thomas Renninger wrote:
> And tell the user that those have happened.

Marking these as unimplemented seems fine, but I think the message is 
too much - my system generates the smart charger events, and I'd rather 
not have even more spew when I plug/unplug. Mind if I merge this without 
the messages?

-- 
Matthew Garrett | mjg59@srcf.ucam.org
