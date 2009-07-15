From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH 1/3] backlight: Allow drivers to update the core, and
	generate events on changes
Date: Wed, 15 Jul 2009 14:58:08 +0100
Message-ID: <20090715135808.GA19054@srcf.ucam.org>
References: <1247517685-7719-1-git-send-email-mjg@redhat.com> <1247574573.23871.8.camel@dax.rpnet.com> <1247644518.26272.88.camel@rzhang-dt> <1247646153.6248.3.camel@dax.rpnet.com> <1247647105.26272.99.camel@rzhang-dt> <1247649089.20241.5.camel@dax.rpnet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:52900 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753957AbZGON6O (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 15 Jul 2009 09:58:14 -0400
Content-Disposition: inline
In-Reply-To: <1247649089.20241.5.camel@dax.rpnet.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Richard Purdie <rpurdie@rpsys.net>
Cc: Zhang Rui <rui.zhang@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "lenb@kernel.org" <lenb@kernel.org>, "corentincj@iksaif.net" <corentincj@iksaif.net>

On Wed, Jul 15, 2009 at 10:11:29AM +0100, Richard Purdie wrote:

> So there are basically two values we're ever interested in at a given
> point in time. The current ambient light reading and the corresponding
> display luminance adjustment. Both of those could just be exposed as an
> input device really?

The alternative would be hwmon, I guess.

> Agreed, userspace should be where policy is decided. Having a standalone
> module which connected the two together with a "default" policy might be
> acceptable too though? If userspace then wants to handle things it just
> makes sure the module is not loaded.

You want smoothing even in a default policy, and doing that well might 
be a bit much for the kernel?

-- 
Matthew Garrett | mjg59@srcf.ucam.org
