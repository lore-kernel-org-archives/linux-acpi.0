From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH 1/4] ACPI button: provide lid status functions
Date: Wed, 15 Jul 2009 23:48:55 +0100
Message-ID: <20090715224855.GA31194@srcf.ucam.org>
References: <1247695886-18432-1-git-send-email-jbarnes@virtuousgeek.org> <1247695886-18432-2-git-send-email-jbarnes@virtuousgeek.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:34081 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751286AbZGOWtA (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 15 Jul 2009 18:49:00 -0400
Content-Disposition: inline
In-Reply-To: <1247695886-18432-2-git-send-email-jbarnes@virtuousgeek.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: intel-gfx@lists.freedesktop.org, linux-acpi@vger.kernel.org

On Wed, Jul 15, 2009 at 03:11:23PM -0700, Jesse Barnes wrote:
> Some drivers need to know when a lid event occurs and get the current
> status.  This can be useful for when a platform firmware clobbers some
> hardware state at lid time, and a driver needs to restore things when
> the lid is opened again.
> 
> Signed-off-by: Jesse Barnes <jbarnes@virtuousgeek.org>
Acked-by: Matthew Garrett <mjg@redhat.com>

-- 
Matthew Garrett | mjg59@srcf.ucam.org
