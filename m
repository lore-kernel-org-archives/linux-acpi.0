From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 1/2] acpi_pm.c: use proper read function also in errata
 mode.
Date: Tue, 19 Aug 2008 02:43:34 -0700
Message-ID: <20080819024334.2f3e69fa.akpm@linux-foundation.org>
References: <20080818193517.GA22097@isilmar.linta.de>
	<20080818200017.GA11247@rhlx01.hs-esslingen.de>
	<20080810101730.GA10024@rhlx01.hs-esslingen.de>
	<20080810162920.GA9860@comet.dominikbrodowski.net>
	<20080810190759.GA1879@rhlx01.hs-esslingen.de>
	<20080818190325.GA12581@comet.dominikbrodowski.net>
	<20080818121924.6b61f7af.akpm@linux-foundation.org>
	<20080818193517.GA22097@isilmar.linta.de>
	<20080818124755.162f24d1.akpm@linux-foundation.org>
	<20080818200916.GA18209@comet.dominikbrodowski.net>
	<20080818201033.GB18209@comet.dominikbrodowski.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:42224 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751722AbYHSJoA (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 19 Aug 2008 05:44:00 -0400
In-Reply-To: <20080818201033.GB18209@comet.dominikbrodowski.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: Andreas Mohr <andi@lisas.de>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, johnstul@us.ibm.com, hirofumi@mail.parknet.co.jp, alan@lxorguk.ukuu.org.uk, arjan@infradead.org

On Mon, 18 Aug 2008 22:10:33 +0200 Dominik Brodowski <linux@dominikbrodowski.net> wrote:

> -	value1 = read_pmtmr();
> +	value1 = clocksource_acpi_pm.read()
>  	mach_countup(&count);
> -	value2 = read_pmtmr();
> +	value2 = clocksource_acpi_pm.read()

compiler got upset.  Did you send the wrong version?
