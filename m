From: Jeremiah Mahler <jmmahler@gmail.com>
Subject: Re: [PATCH] ACPI / video: driver must be registered before checking
 for keypresses
Date: Wed, 6 Jan 2016 09:38:11 -0800
Message-ID: <20160106173811.GA4561@hudson.localdomain>
References: <1451946148-24948-1-git-send-email-adrien+dev@schischi.me>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pa0-f45.google.com ([209.85.220.45]:34064 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752032AbcAFRiM (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 6 Jan 2016 12:38:12 -0500
Content-Disposition: inline
In-Reply-To: <1451946148-24948-1-git-send-email-adrien+dev@schischi.me>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Adrien Schildknecht <adrien+dev@schischi.me>
Cc: rui.zhang@intel.com, rjw@rjwysocki.net, lenb@kernel.org, hdegoede@redhat.com, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

all,

On Mon, Jan 04, 2016 at 11:22:28PM +0100, Adrien Schildknecht wrote:
> acpi_video_handles_brightness_key_presses() may use an uninitialized mutex.
> The error has been reported by lockdep: DEBUG_LOCKS_WARN_ON(l->magic != l).
> The function assumes that the video driver has been registered before being
> called. As explained in the comment of acpi_video_init(), the registration
> of the video class may be defered and thus may not take place in the init
> function of the module.
> 
> Use completion mechanisms to make sure that
> acpi_video_handles_brightness_key_presses() wait for the completion of
> acpi_video_register() before using the mutex.
> Also get rid of register_count since task completion can replace it.
> 
> Signed-off-by: Adrien Schildknecht <adrien+dev@schischi.me>
> ---
>  drivers/acpi/acpi_video.c | 27 ++++++++++++++-------------
>  1 file changed, 14 insertions(+), 13 deletions(-)
> 
[...]

This patch does fix the problem I was having [1].  Thanks for the fix.

  [1]: https://lkml.org/lkml/2016/1/4/791

Tested-by: Jeremiah Mahler <jmmahler@gmail.com>

-- 
- Jeremiah Mahler
