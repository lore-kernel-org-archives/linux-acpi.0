From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: How to help with sony-laptop on Vaio VGN-TT11
Date: Fri, 9 Jan 2009 01:57:54 +0000
Message-ID: <20090109015754.GB23621@srcf.ucam.org>
References: <496634F2.3080505@iworks.at> <alpine.LFD.2.00.0901081534190.4505@localhost.localdomain> <20090108234127.GB19979@gamma.logic.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:42837 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751573AbZAIB6A (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 8 Jan 2009 20:58:00 -0500
Content-Disposition: inline
In-Reply-To: <20090108234127.GB19979@gamma.logic.tuwien.ac.at>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Norbert Preining <preining@logic.at>
Cc: Len Brown <lenb@kernel.org>, Michael Wallner <mike@iworks.at>, linux-acpi@vger.kernel.org

On Fri, Jan 09, 2009 at 12:41:27AM +0100, Norbert Preining wrote:

> Michael: Which kernel you are running? There have been some fixed which
> helped my laptop to at least get the /sys files working.

If you're getting KEY_BRIGHTNESSUP type events from the hotkeys, then 
you'll need some userspace to tie the events to the brightness changing.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
