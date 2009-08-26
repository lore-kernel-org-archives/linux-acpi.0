From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH 5/6] thermal: Only set passive_delay for forced passive
	cooling
Date: Wed, 26 Aug 2009 17:25:37 +0100
Message-ID: <20090826162537.GC15868@srcf.ucam.org>
References: <1251303445-25317-1-git-send-email-elendil@planet.nl> <1251303445-25317-6-git-send-email-elendil@planet.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1752018AbZHZQZo@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1251303445-25317-6-git-send-email-elendil@planet.nl>
Sender: linux-kernel-owner@vger.kernel.org
To: Frans Pop <elendil@planet.nl>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>
List-Id: linux-acpi@vger.kernel.org

On Wed, Aug 26, 2009 at 06:17:24PM +0200, Frans Pop wrote:
> Setting polling_delay is useless as passive_delay has priority,
> so the value shown in proc isn't the actual polling delay. It
> also gives the impression to the user that he can change the
> polling interval through proc, while in fact he can't.
> 
> Also, unset passive_delay when the forced passive trip point is
> unbound to allow polling to be disabled.
> 
> Signed-off-by: Frans Pop <elendil@planet.nl>
> Cc: Matthew Garrett <mjg@redhat.com>
> Cc: Zhang Rui <rui.zhang@intel.com>

I'll look over this - I seem to remember having some reason to set that, 
but it escapes me now.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
