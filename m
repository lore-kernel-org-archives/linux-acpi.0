From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH 02/11] Check for ACPI backlight support otherwise use vendor ACPI drivers
Date: Wed, 16 Jul 2008 12:16:11 +0100
Message-ID: <20080716111611.GA27442@srcf.ucam.org>
References: <1216205553-8486-1-git-send-email-trenn@suse.de> <1216205553-8486-3-git-send-email-trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:46790 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751807AbYGPLQZ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 16 Jul 2008 07:16:25 -0400
Content-Disposition: inline
In-Reply-To: <1216205553-8486-3-git-send-email-trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: ak@linux.intel.com, jwoithe@physics.adelaide.edu.au, hmh@hmh.eng.br, rui.zhang@intel.com, corentincj@iksaif.net, linux-acpi@vger.kernel.org, dannybaumann@web.de, marcus@better.se, corsac@debian.org, mzxreary@0pointer.de, carlos@strangeworlds.co.uk, malattia@linux.it

There's no need to do the IGD flagging (the drm driver probes it 
properly), but the rest looks good.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
