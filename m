From: Jesse Barnes <jbarnes@virtuousgeek.org>
Subject: Re: [Intel-gfx] [PATCH 1/2] ACPI/Intel: Rework Opregion support
Date: Tue, 22 Feb 2011 12:18:40 -0800
Message-ID: <20110222121840.32a6e782@jbarnes-desktop>
References: <1298404994-2907-1-git-send-email-mjg@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from oproxy3-pub.bluehost.com ([69.89.21.8]:34706 "HELO
	oproxy3-pub.bluehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751867Ab1BVUSp (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 22 Feb 2011 15:18:45 -0500
In-Reply-To: <1298404994-2907-1-git-send-email-mjg@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg@redhat.com>
Cc: linux-acpi@vger.kernel.org, intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org, alan@linux.intel.com

On Tue, 22 Feb 2011 15:03:13 -0500
Matthew Garrett <mjg@redhat.com> wrote:

> The Integrated Graphics Device opregion specification defines a mechanism
> for the OS and system firmware to collaborate on various graphics-related
> functionality. This is currently implemented in the i915 driver but isn't
> strictly limited to these devices. Move it to a more generic location and
> remove the i915 dependency, while simultaneously reworking i915 to make
> use of the new driver.

Nice, having it split out makes sense.  And I like the formalized
interface between the driver and the OpRegion features.

Acked-by: Jesse Barnes <jbarnes@virtuousgeek.org>

-- 
Jesse Barnes, Intel Open Source Technology Center
