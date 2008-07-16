From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH 10/11] thinkpad_acpi: fingers off backlight if video.ko is serving this functionality
Date: Wed, 16 Jul 2008 13:36:53 +0200
Message-ID: <200807161336.56354.trenn@suse.de>
References: <1216205553-8486-1-git-send-email-trenn@suse.de> <1216205553-8486-11-git-send-email-trenn@suse.de> <20080716112027.GB27442@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.suse.de ([195.135.220.2]:46895 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752697AbYGPLg7 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 16 Jul 2008 07:36:59 -0400
In-Reply-To: <20080716112027.GB27442@srcf.ucam.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: ak@linux.intel.com, jwoithe@physics.adelaide.edu.au, hmh@hmh.eng.br, rui.zhang@intel.com, corentincj@iksaif.net, linux-acpi@vger.kernel.org, dannybaumann@web.de, marcus@better.se, corsac@debian.org, mzxreary@0pointer.de, carlos@strangeworlds.co.uk, malattia@linux.it

On Wednesday 16 July 2008 13:20:27 Matthew Garrett wrote:
> I still don't think we need the IGD code here.

But it does not hurt either.
There is so much "ugly work around" code in there..., I promise to send 
something and clean it up when things work out.

We need a pointer to the IGD patches...

       Thomas
