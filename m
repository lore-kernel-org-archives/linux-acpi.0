From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC][PATCH] ACPI: EC: Don't trust ECDT tables from ASUS
Date: Wed, 3 Dec 2008 01:09:38 +0100
Message-ID: <200812030109.38768.rjw@sisk.pl>
References: <20081201204706.32465.23231.stgit@thinkpad> <20081202155228.GI1668@khazad-dum.debian.net> <49356C9C.4050907@suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:43780 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752872AbYLCAJy (ORCPT <rfc822;Linux-acpi@vger.kernel.org>);
	Tue, 2 Dec 2008 19:09:54 -0500
In-Reply-To: <49356C9C.4050907@suse.de>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <astarikovskiy@suse.de>
Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Zhao Yakui <yakui.zhao@intel.com>, LenBrown <lenb@kernel.org>, "Linux-acpi@vger.kernel.org" <Linux-acpi@vger.kernel.org>

On Tuesday, 2 of December 2008, Alexey Starikovskiy wrote:
> Henrique de Moraes Holschuh wrote:
> > On Tue, 02 Dec 2008, Alexey Starikovskiy wrote:
> >> ASUSTek keeps feeding us with broken ECDT tables, which are very hard to workaround.
> >> So, we end up always checking that ECDT from ASUS has the same info as DSDT, and
> >> bark otherwise.
> > 
> > I wish we would do more of that, AND printk "BIOS BUG" and "FIRMWARE BUG"
> > everytime we activate any quirk or bug due to something we are completely
> > sure to be a vendor firmware screw-up.
> I've talked to several Taiwanese notebook BIOS writers lately, and they all seem to
> know only one thing -- if Windows boots, BIOS is ok. So we might write huge banners in
> neon letters -- it will not work...

At least the users may notice and hopefully they will buy from another vendor
next time ...

Thanks,
Rafael
