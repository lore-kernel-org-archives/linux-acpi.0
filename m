From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH 1/3] backlight: Allow drivers to update the core, and
	generate events on changes
Date: Wed, 29 Jul 2009 16:20:41 +0100
Message-ID: <20090729152041.GA15650@srcf.ucam.org>
References: <1247517685-7719-1-git-send-email-mjg@redhat.com> <1247574573.23871.8.camel@dax.rpnet.com> <1247644518.26272.88.camel@rzhang-dt> <1247646153.6248.3.camel@dax.rpnet.com> <1247647105.26272.99.camel@rzhang-dt> <1247649089.20241.5.camel@dax.rpnet.com> <20090715135808.GA19054@srcf.ucam.org> <1247711974.26272.190.camel@rzhang-dt> <20090716024057.GA2461@srcf.ucam.org> <20090729150524.GD1534@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754654AbZG2PUr@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20090729150524.GD1534@ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Zhang Rui <rui.zhang@intel.com>, Richard Purdie <rpurdie@rpsys.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "lenb@kernel.org" <lenb@kernel.org>, "corentincj@iksaif.net" <corentincj@iksaif.net>
List-Id: linux-acpi@vger.kernel.org

On Wed, Jul 29, 2009 at 05:05:24PM +0200, Pavel Machek wrote:
> > No, I mean that the only default policy you could reasonably have in the 
> > kernel would be tying the backlight directly to the ALS. And that sucks. 
> > You need some degree of smoothing, and that's a job better left to 
> > userspace.
> 
> How would that be done? Wake up userspace 100times a second so it can
> read an integer and ardd it to running average?

I don't think you'd need more than once a second, possibly modified by 
the size of the change since the last measurement. Response doesn't need 
to be immediate.

> Is ALS device stupid sensor, or can it do some smoothing/watermarks
> itself?

Generally stupid.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
