From: Mattia Dongili <malattia@linux.it>
Subject: Re: sony-laptop: Which models need snc_enable?
Date: Wed, 4 Mar 2009 15:36:48 +0900
Message-ID: <20090304063647.GB28090@kamineko.org>
References: <gojfb4$j3a$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from static-220-247-10-204.b-man.svips.gol.ne.jp ([220.247.10.204]:36119
	"EHLO smtp.kamineko.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751786AbZCDGgw (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 4 Mar 2009 01:36:52 -0500
Content-Disposition: inline
In-Reply-To: <gojfb4$j3a$1@ger.gmane.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Michael Wallner <mike@iworks.at>
Cc: linux-acpi@vger.kernel.org

On Tue, Mar 03, 2009 at 03:37:25PM +0100, Michael Wallner wrote:
> Hi,
> 
> I wonder if the special snc_enable routines are only needed
> for models with the SNY5001 device?

yes

> Mine has SNY6001 and SNY9001, so I wonder if I'd need
> the snc_enable specific stuff too?

nope, you don't need it.
SNY6001 is the SPIC device which is handled differently and SNY9001 is
PS2 controller.

-- 
mattia
:wq!
