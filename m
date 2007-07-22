From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 0/7] sony-laptop for 2.6.23 (updated)
Date: Sun, 22 Jul 2007 00:37:41 -0400
Message-ID: <200707220037.41552.lenb@kernel.org>
References: <1184520879452-git-send-email-malattia@linux.it>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:47895 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750891AbXGVEiL (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 22 Jul 2007 00:38:11 -0400
In-Reply-To: <1184520879452-git-send-email-malattia@linux.it>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mattia Dongili <malattia@linux.it>
Cc: linux-acpi@vger.kernel.org, Stelian Pop <stelian@popies.net>

applied (w/ updated 5/7)

thanks,
-Len

On Sunday 15 July 2007 13:34, Mattia Dongili wrote:
> Hi Len,
> 
> These patches a targeted to 2.6.23.
> I updated the previous series with a couple more patches one of which fixes a
> bug present in 2.6.22 and that I'll push to the stable maintainers.
> Important changes include the scancode enabling work done by Richard Hughes and
> support for some recent vaio models.
> 
> Many thanks
> ---
>  drivers/misc/sony-laptop.c |  312 ++++++++++++++++++++++++++++++++++++---------
>  1 file changed, 252 insertions(+), 60 deletions(-)
