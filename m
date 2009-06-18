From: Carlos Corbacho <carlos@strangeworlds.co.uk>
Subject: Re: [PATCH] wmi: Fix kernel panic when stack protection enabled.
Date: Thu, 18 Jun 2009 22:52:30 +0100
Message-ID: <200906182252.32049.carlos@strangeworlds.co.uk>
References: <alpine.DEB.2.00.0906091707380.8360@debian> <200906092046.24983.carlos@strangeworlds.co.uk> <200906120644.19252.carlos@strangeworlds.co.uk>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from phoenix.slamd64.com ([217.10.145.2]:54439 "EHLO
	phoenix.slamd64.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751314AbZFRVzv (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 18 Jun 2009 17:55:51 -0400
In-Reply-To: <200906120644.19252.carlos@strangeworlds.co.uk>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Carlos Corbacho <carlos@strangeworlds.co.uk>
Cc: "lcostantino@gmail.com" <lcostantino@gmail.com>, linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>

On Friday 12 June 2009 06:44:18 Carlos Corbacho wrote:
> On Tuesday 09 Jun 2009 20:46:24 Carlos Corbacho wrote:
> > [Adding Len to CC]
> >
> > On Tuesday 09 Jun 2009 22:09:23 lcostantino@gmail.com wrote:
> > > From: Costantino Leandro <lcostantino@gmail.com>

[..]

> > > Signed-off-by: Costantino Leandro <lcostantino@gmail.com>
> >
> > Acked-by: Carlos Corbacho <carlos@strangeworlds.co.uk>
>
> Cc: stable@kernel.org
>
> Since I'm starting to get quite a few bug reports from people about 2.6.30
> when distributions are turning on stack protector.

Len,

Ping? I'm still not seeing this patch in the ACPI or Linus' tree...

-Carlos
-- 
E-Mail: carlos@strangeworlds.co.uk
Web: strangeworlds.co.uk
GPG Key ID: 0x23EE722D
