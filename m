From: yakui_zhao <yakui.zhao@intel.com>
Subject: Re: [Intel-gfx] [RFC] i915/acpi: add lid status notification and
	detection
Date: Wed, 17 Jun 2009 10:32:31 +0800
Message-ID: <1245205951.3583.169.camel@localhost.localdomain>
References: <20090513115734.338b7d55@jbarnes-g45>
	 <1242264144.3773.415.camel@localhost.localdomain>
	 <20090519171545.GA17801@srcf.ucam.org>
	 <1242896273.32574.10.camel@rzhang-dt> <20090521093418.3f1a03d5@jbarnes-g45>
	 <4A15FE57.7040002@linux.intel.com> <20090527015801.2f47089f@jbarnes-x200>
	 <1244704587.3616.109.camel@localhost.localdomain>
	 <20090616113320.69fa477d@jbarnes-g45>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:6952 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751373AbZFQCbU (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 16 Jun 2009 22:31:20 -0400
In-Reply-To: <20090616113320.69fa477d@jbarnes-g45>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: Fu Michael <michael_fu@linux.intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Zhang, Rui" <rui.zhang@intel.com>, "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>, "lenb@kernel.org" <lenb@kernel.org>, Matthew Garrett <mjg59@srcf.ucam.org>

On Wed, 2009-06-17 at 02:33 +0800, Jesse Barnes wrote:
> Well, what should we use then?  Think of a common use case: you plug
> in
> an external monitor and shut your lid.  Do we want to make the user
> manually change their configuration?  Or detect that the lid is no
> longer in use?  And what about the case where they boot with the lid
> closed (e.g. in a docked scenario)?  We want to support that
> automatically too...
This feature should work on most laptops. When the LID is closed, the
LVDS is marked as disconnected.

But this can't work for some boxes on which the initial Lid state is
incorrect. We see such an exception on several laptops in ACPI bugzilla.

If we expect this feature for most laptops, how about adding the
exception boxes into the blacklist that doesn't support this feature?

Thanks.
> 
> If we can solve these issues some other way, that's fine, but right
> now
> we have nothing; I think my patch is an improvement over that, even if
> it won't work everywhere w/o quirks.
> 
> Len or Matthew, any comments

