From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH] ACPI: event: fix acpi_bus_generate_netlink_event call
Date: Tue, 04 Sep 2007 08:56:38 +0800
Message-ID: <1188867398.3082.305.camel@acpi-hp.sh.intel.com>
References: <11887886153952-git-send-email-hmh@hmh.eng.br>
	 <200709031659.23663.lenb@kernel.org>
	 <20070903230642.GB3899@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:36238 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750722AbXIDAws (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 3 Sep 2007 20:52:48 -0400
In-Reply-To: <20070903230642.GB3899@khazad-dum.debian.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org

On Mon, 2007-09-03 at 20:06 -0300, Henrique de Moraes Holschuh wrote:
> On Mon, 03 Sep 2007, Len Brown wrote:
> > Wow, do you really build with CONFIG_NET=n,
> > or did randconfig find this?
> 
> My build-it-quick config for thinkpad-acpi has CONFIG_NET=n :-)
> 
> It is not a kernel I use to test anything but straight "does it even
> compile?", though...
> 
Oops, thanks for fixing this.

Rui
