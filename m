From: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] amd76x_pm: C3 powersaving for AMD K7
Date: Thu, 2 Feb 2006 14:37:25 -0800
Message-ID: <20060202143725.46d218dc.akpm@osdl.org>
References: <20060202222407.GB896@sommrey.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.4]:40097 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932374AbWBBWff (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 2 Feb 2006 17:35:35 -0500
In-Reply-To: <20060202222407.GB896@sommrey.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Joerg Sommrey <jo@sommrey.de>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, tony@atomide.com, len.brown@intel.com, erik@slagter.name, alan@lxorguk.ukuu.org.uk

Joerg Sommrey <jo@sommrey.de> wrote:
>
> This is a processor idle module for AMD SMP 760MP(X) based systems.
>

Len's comments about loss of cache coherency on some machines possibly
causing corruption made me drop this patch.   Was I wrong to do so?
