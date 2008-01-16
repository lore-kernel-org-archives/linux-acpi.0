From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: thinkpad_acpi: define _sta only when needed
Date: Wed, 16 Jan 2008 17:13:17 -0200
Message-ID: <20080116191317.GA29449@khazad-dum.debian.net>
References: <1200488504-6789-1-git-send-email-hannes@saeurebad.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:53581 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751194AbYAPTNX (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Wed, 16 Jan 2008 14:13:23 -0500
Content-Disposition: inline
In-Reply-To: <1200488504-6789-1-git-send-email-hannes@saeurebad.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Johannes Weiner <hannes@saeurebad.de>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

On Wed, 16 Jan 2008, Johannes Weiner wrote:
> Define _sta() helper conditionally; also remove its prototype from
> the internal header and also some other unneeded ones.
> 
> This function is only needed when the bay or the dock subdriver is
> enabled.  Otherwise, gcc complains about an unused static function.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

Johannes, thanks for the patches, but NAK.  A similar group of patches that
clean up the _sta and heander file (kills it, actually) has already been
sent to Len Brown to be merged for 2.6.25.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
