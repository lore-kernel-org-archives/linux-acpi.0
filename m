From: Dominik Brodowski <linux@dominikbrodowski.net>
Subject: Re: powernow-k8 and thermal / voltage data
Date: Wed, 25 Oct 2006 22:42:24 -0400
Message-ID: <20061026024224.GG32048@dominikbrodowski.de>
References: <1161006602.17644.273439231@webmail.messagingengine.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from isilmar.linta.de ([213.239.214.66]:38804 "EHLO linta.de")
	by vger.kernel.org with ESMTP id S1422862AbWJZDIe (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Wed, 25 Oct 2006 23:08:34 -0400
Content-Disposition: inline
In-Reply-To: <1161006602.17644.273439231@webmail.messagingengine.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mathew Brown <mathewbrown@fastmail.fm>
Cc: linux-acpi@vger.kernel.org

Hi,

On Mon, Oct 16, 2006 at 06:50:02AM -0700, Mathew Brown wrote:
>     I've successfully gotten CPU frequency scaling working (which I
>     tested by looking at the cpu frequency before and during running a
>     CPU intensive task).  However, there are currently 2 issues:
> 
>     1) cat /proc/acpi/thermal_zone/* is empty (there's nothing under the
>     thermal_zone directory)

That's a BIOS issue -- if the BIOS does not expose thermal zones, then they
cannot be displayed there.


	Dominik
