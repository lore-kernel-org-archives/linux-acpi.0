From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 2/2] dell-laptop: Update rfkill state on kill switch
Date: Wed, 9 Dec 2009 12:07:45 -0800
Message-ID: <20091209200745.GB10138@core.coreip.homeip.net>
References: <1260383609-7681-1-git-send-email-mjg@redhat.com> <1260383609-7681-2-git-send-email-mjg@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pw0-f42.google.com ([209.85.160.42]:48872 "EHLO
	mail-pw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757620AbZLIUHn (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 9 Dec 2009 15:07:43 -0500
Content-Disposition: inline
In-Reply-To: <1260383609-7681-2-git-send-email-mjg@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg@redhat.com>
Cc: linux-input@vger.kernel.org, linux-acpi@vger.kernel.org, lenb@kernel.org

On Wed, Dec 09, 2009 at 01:33:29PM -0500, Matthew Garrett wrote:
> The rfkill interface on Dells only sends a notification that the switch
> has been changed via the keyboard controller. Add a filter so we can
> pick these notifications up and update the rfkill state appropriately.
> 

This needs Kconfig love for the case i8042=m dell-laptop=y

-- 
Dmitry
