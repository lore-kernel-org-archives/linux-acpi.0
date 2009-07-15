From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH 2/4] drm/i915: force mode set at lid open time
Date: Wed, 15 Jul 2009 23:54:25 +0100
Message-ID: <20090715225425.GB31194@srcf.ucam.org>
References: <1247695886-18432-1-git-send-email-jbarnes@virtuousgeek.org> <1247695886-18432-3-git-send-email-jbarnes@virtuousgeek.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:35307 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752159AbZGOWy2 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 15 Jul 2009 18:54:28 -0400
Content-Disposition: inline
In-Reply-To: <1247695886-18432-3-git-send-email-jbarnes@virtuousgeek.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: intel-gfx@lists.freedesktop.org, linux-acpi@vger.kernel.org

On Wed, Jul 15, 2009 at 03:11:24PM -0700, Jesse Barnes wrote:
> Some laptop platforms will disable pipes and/or planes at lid close time
> and not restore them when the lid is opened again.  So catch the lid
> event, and if the lid was opened, force a mode restore.
> 
> Fixes fdo bug #21230.
> 
> Signed-off-by: Jesse Barnes <jbarnes@virtuousgeek.org>
Acked-by: Matthew Garrett <mjg@redhat.com>

-- 
Matthew Garrett | mjg59@srcf.ucam.org
