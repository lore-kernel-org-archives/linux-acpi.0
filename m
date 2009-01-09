From: Len Brown <lenb@kernel.org>
Subject: Re: [patch 6/6] acpi dock: terminate eject request is the dock is not
 present
Date: Fri, 09 Jan 2009 16:09:49 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0901091607200.16697@localhost.localdomain>
References: <200901092017.n09KHEqd015005@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173005pub.verizon.net ([206.46.173.5]:40043 "EHLO
	vms173005pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754302AbZAIVKH (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 9 Jan 2009 16:10:07 -0500
Received: from localhost.localdomain ([96.237.168.40])
 by vms173005.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0KD8007OU2SHMMO0@vms173005.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 09 Jan 2009 15:09:54 -0600 (CST)
In-reply-to: <200901092017.n09KHEqd015005@imap1.linux-foundation.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: akpm@linux-foundation.org
Cc: linux-acpi@vger.kernel.org, marvin@mydatex.cz, hmacht@suse.de, rui.zhang@intel.com, shaohua.li@intel.com, stable@kernel.org

The bug report suggest that this patch is not a complete fix for the 
issue, so I'd prefer we get a resolution, or at least a better
understanding of the failure, before sending patches upstream
for this issue.

thanks
Len Brown, Intel Open Source Technology Center

On Fri, 9 Jan 2009, akpm@linux-foundation.org wrote:

> From: Daniel Smolik <marvin@mydatex.cz>
> 
> Taken from http://bugzilla.kernel.org/show_bug.cgi?id=12360
> 
> nfi if it's right - I merged it so it wouldn't get lost.
> 
> Cc: Zhang Rui <rui.zhang@intel.com>
> Cc: Len Brown <lenb@kernel.org>
> Cc: "Li, Shaohua" <shaohua.li@intel.com>
> Cc: <hmacht@suse.de>
> Cc: <stable@kernel.org>		[2.6.26.x, 2.6.27.x, 2.6.28.x]
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
> 
>  drivers/acpi/dock.c |    3 +++
>  1 file changed, 3 insertions(+)
> 
> diff -puN drivers/acpi/dock.c~acpi-dock-terminate-eject-request-is-the-dock-is-not-present drivers/acpi/dock.c
> --- a/drivers/acpi/dock.c~acpi-dock-terminate-eject-request-is-the-dock-is-not-present
> +++ a/drivers/acpi/dock.c
> @@ -668,6 +668,9 @@ EXPORT_SYMBOL_GPL(unregister_hotplug_doc
>   */
>  static int handle_eject_request(struct dock_station *ds, u32 event)
>  {
> +	if (!dock_present(ds))
> +		return -ENODEV;
> +
>  	if (dock_in_progress(ds))
>  		return -EBUSY;
>  
> _
> 
