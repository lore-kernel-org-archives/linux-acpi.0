From: Andreas Herrmann <andreas.herrmann3@amd.com>
Subject: Re: panic caused by 653a00c9662304ef72a3eb4e681c91720960e0b4
	(ACPI:thermal fixup)
Date: Fri, 14 Mar 2008 15:56:06 +0100
Message-ID: <20080314145606.GE22740@alberich.amd.com>
References: <20080314144559.GD22740@alberich.amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from outbound-wa4.frontbridge.com ([216.32.181.16]:33267 "EHLO
	outbound6-wa4-R.bigfish.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752399AbYCNO6Y (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Fri, 14 Mar 2008 10:58:24 -0400
Content-Disposition: inline
In-Reply-To: <20080314144559.GD22740@alberich.amd.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

Forget about it.

I've just pulled the current Linux tree and it seems to
contain already a fix for the problem (commit
c8d16e27a3601d1cbcdfe657eb4ff5e762019e8d).

I'll retest ...


Andreas


