From: Jesse Barnes <jbarnes@virtuousgeek.org>
Subject: Re: [PATCH 3/4] drm/i915: use ACPI LID status for LVDS ->detect
 hook
Date: Wed, 15 Jul 2009 16:09:01 -0700
Message-ID: <20090715160901.6407eb65@jbarnes-g45>
References: <1247695886-18432-1-git-send-email-jbarnes@virtuousgeek.org>
	<1247695886-18432-4-git-send-email-jbarnes@virtuousgeek.org>
	<20090715225558.GC31194@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from outbound-mail-109.bluehost.com ([69.89.22.9]:42353 "HELO
	outbound-mail-109.bluehost.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1755324AbZGOXJE (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Wed, 15 Jul 2009 19:09:04 -0400
In-Reply-To: <20090715225558.GC31194@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: intel-gfx@lists.freedesktop.org, linux-acpi@vger.kernel.org

On Wed, 15 Jul 2009 23:55:58 +0100
Matthew Garrett <mjg59@srcf.ucam.org> wrote:

> On Wed, Jul 15, 2009 at 03:11:25PM -0700, Jesse Barnes wrote:
> > We can't load or hotplug detect LVDS like we can other outputs, but
> > if there's a lid device present we can use it as a proxy.  This
> > allows the LFP state to be determined at ->detect time, making
> > configurations requiring manual intervention today "just work"
> > assuming the lid device status is correct.
> 
> I'm a bit unhappy with this appearing to be generic functionality but 
> ending up implemented in the driver rather than in the KMS core. If
> this is going in then can we at least document this behaviour and
> that other KMS drivers are expected to implement it?

Well, we don't really have generic LVDS helpers where we could put
this, but yeah we can document this as preferred for all LVDS outputs.

-- 
Jesse Barnes, Intel Open Source Technology Center
