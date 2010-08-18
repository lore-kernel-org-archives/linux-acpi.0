From: Oliver Neukum <oneukum@suse.de>
Subject: Re: [PATCH 5/8] ideapad: use EC command to control camera
Date: Wed, 18 Aug 2010 10:42:39 +0200
Message-ID: <201008181042.39943.oneukum@suse.de>
References: <1282120564-11324-1-git-send-email-ike.pan@canonical.com> <1282120695-11503-1-git-send-email-ike.pan@canonical.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:44929 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752232Ab0HRImp (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 18 Aug 2010 04:42:45 -0400
In-Reply-To: <1282120695-11503-1-git-send-email-ike.pan@canonical.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ike Panhc <ike.pan@canonical.com>, linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@novell.com>
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Thomas Renninger <trenn@suse.de>, Alan Cox <alan@linux.intel.com>, Andrew Morton <akpm@linux-foundation.org>, Corentin Chary <corentincj@iksaif.net>, David Woodhouse <David.Woodhouse@intel.com>, Randy Dunlap <randy.dunlap@oracle.com>, Len Brown <len.brown@intel.com>, Matthew Garrett <mjg@redhat.com>

Am Mittwoch, 18. August 2010, 10:38:15 schrieb Ike Panhc:
> Signed-off-by: Ike Panhc <ike.pan@canonical.com>
> ---
>  drivers/platform/x86/ideapad_acpi.c |   16 +++++++++++-----
>  1 files changed, 11 insertions(+), 5 deletions(-)

Hi,

wouldn't it be appropriate to integrate such switches into the generic
power framework?

	Regards
		Oliver
