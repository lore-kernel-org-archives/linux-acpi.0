From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: [0/5] remove ACPI motherboard driver, use PNP system driver instead (take 2)
Date: Tue, 23 Jan 2007 08:44:52 -0700
Message-ID: <200701230844.52674.bjorn.helgaas@hp.com>
References: <200701181636.45590.bjorn.helgaas@hp.com> <200701220925.49821.bjorn.helgaas@hp.com> <414cba4e0701230107ocac73kc3f20a6a3da959bb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from atlrel8.hp.com ([156.153.255.206]:48811 "EHLO atlrel8.hp.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932916AbXAWPpC (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 23 Jan 2007 10:45:02 -0500
In-Reply-To: <414cba4e0701230107ocac73kc3f20a6a3da959bb@mail.gmail.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: emisca <emisca.ml@gmail.com>
Cc: Len Brown <len.brown@intel.com>, linux-acpi@vger.kernel.org, Adam Belay <ambx1@neo.rr.com>, Matthieu Castet <castet.matthieu@free.fr>, Li Shaohua <shaohua.li@intel.com>

On Tuesday 23 January 2007 02:07, emisca wrote:
> What kernel version I should use? If I should use git, could you give
> me the path of the branch you use?
> I tried with vanilla 2.6.19.2 kernel, but obviously 8250_pnp.c hasn't
> the suspend and resume functions......

I made the patch from 2.6.20-rc3-mm1, and it should apply on any recent
mm kernel.  That'd be the easiest thing to debug, I think.

If that's not convenient for you, we can work on 2.6.19.2, and you can
just ignore the 8250_pnp patch (you can just remove that section from
the patch).
