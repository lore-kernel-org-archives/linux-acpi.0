From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH 10/11] thinkpad_acpi: fingers off backlight if video.ko is serving this functionality
Date: Wed, 16 Jul 2008 12:20:27 +0100
Message-ID: <20080716112027.GB27442@srcf.ucam.org>
References: <1216205553-8486-1-git-send-email-trenn@suse.de> <1216205553-8486-11-git-send-email-trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:53690 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750758AbYGPLUf (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 16 Jul 2008 07:20:35 -0400
Content-Disposition: inline
In-Reply-To: <1216205553-8486-11-git-send-email-trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: ak@linux.intel.com, jwoithe@physics.adelaide.edu.au, hmh@hmh.eng.br, rui.zhang@intel.com, corentincj@iksaif.net, linux-acpi@vger.kernel.org, dannybaumann@web.de, marcus@better.se, corsac@debian.org, mzxreary@0pointer.de, carlos@strangeworlds.co.uk, malattia@linux.it

I still don't think we need the IGD code here.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
