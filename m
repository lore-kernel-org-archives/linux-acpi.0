From: Holger Macht <hmacht@suse.de>
Subject: Re: [stable] [patch 20/23] ACPI: dock: avoid check _STA method
Date: Mon, 17 Nov 2008 00:36:02 +0100
Message-ID: <20081116233602.GA2985@homac.site>
References: <20081107224818.593212310@mini.kroah.org> <20081107231606.GU1108@kroah.com> <20081111121607.GA32066@homac.suse.de> <20081113212305.GA5697@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:33092 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751327AbYKPXge (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 16 Nov 2008 18:36:34 -0500
Content-Disposition: inline
In-Reply-To: <20081113212305.GA5697@kroah.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: Greg KH <gregkh@suse.de>, linux-kernel@vger.kernel.org, stable@kernel.org, Justin Forbes <jmforbes@linuxtx.org>, Zwane Mwaikambo <zwane@arm.linux.org.uk>, Theodore Ts'o <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>, Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>, Chris Wedgwood <reviews@ml.cw.f00f.org>, Michael Krufky <mkrufky@linuxtv.org>, Chuck Ebbert <cebbert@redhat.com>, Domenico Andreoli <cavokz@gmail.com>, Willy Tarreau <w@1wt.eu>, Rodrigo Rubira Branco <rbranco@la.checkpoint.com>, Jake Edge <jake@lwn.net>, Eugene Teo <eteo@redhat.com>, torvalds@linux-foundation.org, akpm@linux-foundation.org, alan@lxorguk.ukuu.org.uk, linux-acpi@vger.kernel.org, Shaohua Li <shaohua.li@intel.com>, Len Brown <len.brown@intel.com>

On Thu 13. Nov - 13:23:05, Greg KH wrote:
> On Tue, Nov 11, 2008 at 01:16:07PM +0100, Holger Macht wrote:
> > On Fri 07. Nov - 15:16:06, Greg KH wrote:
> > > 2.6.26-stable review patch.  If anyone has any objections, please let us know.
> > 
> > Objecting. This will only work in conjunction with
> > 
> >   commit 39a0ad871000d2a016a4fa113a6e53d22aabf25d
> >   Author: Zhao Yakui <yakui.zhao@intel.com>
> >   Date:   Mon Aug 11 13:40:22 2008 +0800
> > 
> >       ACPI : Load device driver according to the status of acpi device
> > 
> > Otherwise a device struct already exists although the device is not
> > present.
> 
> So do you feel we should also add this patch to the 2.6.27-stable tree
> to solve this issue?

Yes, I think so.

Regards,
	Holger
