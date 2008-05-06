From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] bay: Exit if notify handler cannot be installed
Date: Tue, 6 May 2008 16:49:30 +0100
Message-ID: <20080506164930.32df50d0@core>
References: <20080505202508.GA3690@homac>
	<20080506091522.GA4378@homac>
	<1210065811.12668.1.camel@sli10-desk.sh.intel.com>
	<20080506151846.GA22828@khazad-dum.debian.net>
	<20080506162049.237af49c@core>
	<20080506153901.GC22828@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1764215AbYEFQA6@vger.kernel.org>
In-Reply-To: <20080506153901.GC22828@khazad-dum.debian.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: Shaohua Li <shaohua.li@intel.com>, Holger Macht <hmacht@suse.de>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, "Accardi, Kristen C" <kristen.c.accardi@intel.com>
List-Id: linux-acpi@vger.kernel.org

> The problem has a bit of a hard edge, though: if nobody binds to an ACPI
> node that has an EJ0 subnode, bay needs to do it.  But if someone wants
> to, bay should give the node up, and somehow help that someone handle
> the ejection stuff.

A notifier chain should do all that is needed. If bay is loaded anyway
then ATA and other users can register with the bay driver and it can pass
an event to a notifier chain so that anyone who wants that event can act
on it (and if nobody does it can do its own stuff)

Alan
