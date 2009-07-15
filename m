From: Jesse Barnes <jbarnes@virtuousgeek.org>
Subject: Re: [PATCH 1/4] ACPI button: provide lid status functions
Date: Wed, 15 Jul 2009 15:54:21 -0700
Message-ID: <20090715155421.2dff1641@jbarnes-g45>
References: <1247695886-18432-1-git-send-email-jbarnes@virtuousgeek.org>
	<1247695886-18432-2-git-send-email-jbarnes@virtuousgeek.org>
	<20090715224855.GA31194@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from outbound-mail-156.bluehost.com ([67.222.39.36]:59065 "HELO
	outbound-mail-156.bluehost.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1754582AbZGOWyY (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Wed, 15 Jul 2009 18:54:24 -0400
In-Reply-To: <20090715224855.GA31194@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: intel-gfx@lists.freedesktop.org, linux-acpi@vger.kernel.org, lenb@kernel.org

On Wed, 15 Jul 2009 23:48:55 +0100
Matthew Garrett <mjg59@srcf.ucam.org> wrote:

> On Wed, Jul 15, 2009 at 03:11:23PM -0700, Jesse Barnes wrote:
> > Some drivers need to know when a lid event occurs and get the
> > current status.  This can be useful for when a platform firmware
> > clobbers some hardware state at lid time, and a driver needs to
> > restore things when the lid is opened again.
> > 
> > Signed-off-by: Jesse Barnes <jbarnes@virtuousgeek.org>
> Acked-by: Matthew Garrett <mjg@redhat.com>

Len, is it ok if this ACPI button patch goes through the drm-intel
tree?  We have other patches that depend on it, so that would be
easiest...

Thanks,
-- 
Jesse Barnes, Intel Open Source Technology Center
