From: Holger Macht <hmacht@suse.de>
Subject: Re: [PATCH] ACPI: dock: Send key=value pair instead of plain value
Date: Sun, 22 Jul 2007 23:07:54 +0200
Message-ID: <20070722210754.GA11546@homac>
References: <20070611221200.GA5675@homac.gate.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ns.suse.de ([195.135.220.2]:34169 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751041AbXGVVHx (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 22 Jul 2007 17:07:53 -0400
Content-Disposition: inline
In-Reply-To: <20070611221200.GA5675@homac.gate.uni-erlangen.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org, Kristen Carlson Accardi <kristen.c.accardi@intel.com>, linux-acpi@vger.kernel.org

On Tue 12. Jun - 00:12:00, Holger Macht wrote:
> Send key=value pair along with the uevent instead of a plain value so that
> userspace (udev) can handle it like common environment variables.
> 
> Signed-off-by: Holger Macht <hmacht@suse.de>

Len, maybe this on accidentally slipped through your attention?

Regards,
	Holger
