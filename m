From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 2/2] staging: Use generic IGD opregion code for gma500
Date: Tue, 22 Feb 2011 21:15:15 +0000
Message-ID: <20110222211515.36fc68d5@lxorguk.ukuu.org.uk>
References: <1298404994-2907-1-git-send-email-mjg@redhat.com>
	<1298404994-2907-2-git-send-email-mjg@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:47894 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751936Ab1BVVNd (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 22 Feb 2011 16:13:33 -0500
In-Reply-To: <1298404994-2907-2-git-send-email-mjg@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg@redhat.com>
Cc: linux-acpi@vger.kernel.org, intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org, alan@linux.intel.com

On Tue, 22 Feb 2011 15:03:14 -0500
Matthew Garrett <mjg@redhat.com> wrote:

> The gma500 driver currently includes its own IGD opregion implementation.
> Rework it to use the generic one instead. Note that this is missing a
> certain level of functionality - the driver does nothing to enable
> opregion interrupts right now, and so will simply poll for updates rather
> than doing anything sensible.
> 
> Signed-off-by: Matthew Garrett <mjg@redhat.com>

Acked-by: Alan Cox <alan@linux.intel.com>
