From: Alex Chiang <achiang@hp.com>
Subject: Re: [PATCH v4 1/6] ACPI: dock: convert sysfs attributes to an
	attribute_group
Date: Mon, 19 Oct 2009 20:57:33 -0600
Message-ID: <20091020025733.GA5814@ldl.fc.hp.com>
References: <20091019211132.5412.80438.stgit@bob.kio> <20091019211424.5412.15540.stgit@bob.kio> <20091020013844.GB24370@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g1t0028.austin.hp.com ([15.216.28.35]:21444 "EHLO
	g1t0028.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756820AbZJTC5a (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 19 Oct 2009 22:57:30 -0400
Content-Disposition: inline
In-Reply-To: <20091020013844.GB24370@core.coreip.homeip.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: shaohua.li@intel.com, lenb@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

* Dmitry Torokhov <dmitry.torokhov@gmail.com>:
> On Mon, Oct 19, 2009 at 03:14:24PM -0600, Alex Chiang wrote:
> > As suggested by Dmitry Torokhov, convert the individual sysfs
> > attributes into an attribute group.
> > 
> > This change eliminates quite a bit of copy/paste code in the
> > error handling paths.
> > 
> 
> Looks good to me, thank you for making the changes.

Thank you for your patience along the way.

Can I count this as an Acked-by? :)

/ac

