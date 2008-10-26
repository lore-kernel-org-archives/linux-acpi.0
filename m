From: Pavel Machek <pavel@suse.cz>
Subject: Re: [linux-pm] [PATCH 2/4] ACPI hibernate: Add a mechanism to
	save/restore ACPI NVS memory
Date: Sun, 26 Oct 2008 13:08:39 +0100
Message-ID: <20081026120838.GB1607@ucw.cz>
References: <200810222249.20629.rjw@sisk.pl> <200810222252.11625.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:46262 "EHLO UNKNOWN"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752566AbYJZMJL (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 26 Oct 2008 08:09:11 -0400
Content-Disposition: inline
In-Reply-To: <200810222252.11625.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Len Brown <lenb@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Ingo Molnar <mingo@elte.hu>

Hi!

> From: Rafael J. Wysocki <rjw@sisk.pl>
> 
> ACPI hibernate: Add a mechanism to save/restore ACPI NVS memory
> 
> According to the ACPI Specification 3.0b, Section 15.3.2,
> "OSPM will call the _PTS control method some time before entering a
> sleeping state, to allow the platform???s AML code to update this
> memory image before entering the sleeping state. After the system
> awakes from an S4 state, OSPM will restore this memory area and call
> the _WAK control method to enable the BIOS to reclaim its memory
> image."  For this reason, implement a mechanism allowing us to save
> the NVS memory during hibernation and to restore it during the
> subsequent resume.
> 
> Based on a patch by Zhang Rui.
> 
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> Cc: Zhang Rui <rui.zhang@intel.com>
> ---
>  drivers/acpi/sleep/main.c |   50 ++++++++++++++++---
>  include/linux/suspend.h   |   13 ++++
>  kernel/power/swsusp.c     |  121 ++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 177 insertions(+), 7 deletions(-)
> 


> @@ -387,8 +410,21 @@ static int acpi_hibernation_begin_old(vo
>  {
>  	int error = acpi_sleep_prepare(ACPI_STATE_S4);
>  
> +	if (!error) {
> +		error = hibernate_nvs_alloc();
> +		if (!error)
> +			acpi_target_sleep_state = ACPI_STATE_S4;
> +	}
> +	return error;
> +}

You can chain this without nesting...

If sleep_prepare() succeeds but nvs_alloc() fails, you should undo
sleep_prepare here, right?


>  #else /* CONFIG_HIBERNATION */
>  static inline int swsusp_page_is_forbidden(struct page *p) { return 0; }
>  static inline void swsusp_set_page_free(struct page *p) {}
> @@ -241,6 +246,14 @@ static inline void swsusp_unset_page_fre
>  static inline void hibernation_set_ops(struct platform_hibernation_ops *ops) {}
>  static inline int hibernate(void) { return -ENOSYS; }
>  static inline bool system_entering_hibernation(void) { return false; }
> +static inline int hibernate_nvs_register(unsigned long a, unsigned long b)
> +{
> +	return 0;
> +}
> +static inline int hibernate_nvs_alloc(void) { return 0; }
> +static inline void hibernate_nvs_free(void) {}
> +static inline void hibernate_nvs_save(void) {}
> +static inline void hibernate_nvs_restore(void) {}
>  #endif /* CONFIG_HIBERNATION */

Can someone call these for !hibernation case? Should they fake success
if they do call them?


> Index: linux-2.6/kernel/power/swsusp.c
> ===================================================================
> --- linux-2.6.orig/kernel/power/swsusp.c
> +++ linux-2.6/kernel/power/swsusp.c
> @@ -262,3 +262,124 @@ int swsusp_shrink_memory(void)
>  
>  	return 0;
>  }
> +
> +/*
> + * Platforms, like ACPI, may want us to save some memory used by them during
> + * hibernation and to restore the contents of this memory during the subsequent
> + * resume.  The code below implements a mechanism allowing us to do that.
> + */
> +
> +struct nvs_page {
> +	unsigned long phys_start;
> +	unsigned int size;
> +	void *kaddr;
> +	void *data;
> +	struct list_head node;
> +};

Maybe separate nvs.c file would be good? I believe this _is_ acpi
specific, altrough in theory it may not be.
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
