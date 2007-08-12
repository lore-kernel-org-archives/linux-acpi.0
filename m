From: Mattia Dongili <malattia@linux.it>
Subject: Re: [PATCH 1/2] sony-laptop: enable vaio FZ events
Date: Sun, 12 Aug 2007 12:33:00 +0900
Message-ID: <20070812033259.GA10937@inferi.kami.home>
References: <1186796587433-git-send-email-malattia@linux.it> <11867965871757-git-send-email-malattia@linux.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mtoichi16.ns.itscom.net ([219.110.2.186]:63480 "EHLO
	mtoichi16.ns.itscom.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755860AbXHLDdM (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 11 Aug 2007 23:33:12 -0400
Content-Disposition: inline
In-Reply-To: <11867965871757-git-send-email-malattia@linux.it>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, Stelian Pop <stelian@popies.net>

On Sat, Aug 11, 2007 at 10:43:06AM +0900, Mattia Dongili wrote:
> Signed-off-by: Mattia Dongili <malattia@linux.it>
...
>  			.matches = {
>  				DMI_MATCH(DMI_SYS_VENDOR, "Sony Corporation"),
>  				DMI_MATCH(DMI_PRODUCT_NAME, "VGN-FE"),
>  			},
> +			{
> +				DMI_MATCH(DMI_SYS_VENDOR, "Sony Corporation"),
> +				DMI_MATCH(DMI_PRODUCT_NAME, "VGN-FZ"),
> +			},
>  		},
>  		{

sorry, this is wrong. Will resend shortly
-- 
mattia
:wq!
