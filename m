From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH] ACPI / video: driver must be registered before checking
 for keypresses
Date: Tue, 5 Jan 2016 12:43:54 +0100
Message-ID: <568BAC7A.5040907@redhat.com>
References: <1451946148-24948-1-git-send-email-adrien+dev@schischi.me>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:38923 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751543AbcAELoD (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 5 Jan 2016 06:44:03 -0500
In-Reply-To: <1451946148-24948-1-git-send-email-adrien+dev@schischi.me>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Adrien Schildknecht <adrien+dev@schischi.me>, rui.zhang@intel.com, rjw@rjwysocki.net, lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali.rohar@gmail.com>, jmmahler@gmail.com, ibm-acpi@hmh.eng.br

Hi,

On 04-01-16 23:22, Adrien Schildknecht wrote:
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

Thanks for the fix, my first instinct was that there should be an easier
fix, but thinking more about it this and how this function is used
in thinkpad_acpi. this is indeed the correct way to fix this:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Rafael, can you please add this fix to acpi-next ?

Regards,

Hans


> ---
>   drivers/acpi/acpi_video.c | 27 ++++++++++++++-------------
>   1 file changed, 14 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/acpi/acpi_video.c b/drivers/acpi/acpi_video.c
> index 80b13d4..06a006f 100644
> --- a/drivers/acpi/acpi_video.c
> +++ b/drivers/acpi/acpi_video.c
> @@ -90,8 +90,8 @@ module_param(device_id_scheme, bool, 0444);
>   static bool only_lcd = false;
>   module_param(only_lcd, bool, 0444);
>
> -static int register_count;
> -static DEFINE_MUTEX(register_count_mutex);
> +static DECLARE_COMPLETION(register_done);
> +static DEFINE_MUTEX(register_done_mutex);
>   static struct mutex video_list_lock;
>   static struct list_head video_bus_head;
>   static int acpi_video_bus_add(struct acpi_device *device);
> @@ -2049,8 +2049,8 @@ int acpi_video_register(void)
>   {
>   	int ret = 0;
>
> -	mutex_lock(&register_count_mutex);
> -	if (register_count) {
> +	mutex_lock(&register_done_mutex);
> +	if (completion_done(&register_done)) {
>   		/*
>   		 * if the function of acpi_video_register is already called,
>   		 * don't register the acpi_vide_bus again and return no error.
> @@ -2071,22 +2071,22 @@ int acpi_video_register(void)
>   	 * When the acpi_video_bus is loaded successfully, increase
>   	 * the counter reference.
>   	 */
> -	register_count = 1;
> +	complete(&register_done);
>
>   leave:
> -	mutex_unlock(&register_count_mutex);
> +	mutex_unlock(&register_done_mutex);
>   	return ret;
>   }
>   EXPORT_SYMBOL(acpi_video_register);
>
>   void acpi_video_unregister(void)
>   {
> -	mutex_lock(&register_count_mutex);
> -	if (register_count) {
> +	mutex_lock(&register_done_mutex);
> +	if (completion_done(&register_done)) {
>   		acpi_bus_unregister_driver(&acpi_video_bus);
> -		register_count = 0;
> +		reinit_completion(&register_done);
>   	}
> -	mutex_unlock(&register_count_mutex);
> +	mutex_unlock(&register_done_mutex);
>   }
>   EXPORT_SYMBOL(acpi_video_unregister);
>
> @@ -2094,20 +2094,21 @@ void acpi_video_unregister_backlight(void)
>   {
>   	struct acpi_video_bus *video;
>
> -	mutex_lock(&register_count_mutex);
> -	if (register_count) {
> +	mutex_lock(&register_done_mutex);
> +	if (completion_done(&register_done)) {
>   		mutex_lock(&video_list_lock);
>   		list_for_each_entry(video, &video_bus_head, entry)
>   			acpi_video_bus_unregister_backlight(video);
>   		mutex_unlock(&video_list_lock);
>   	}
> -	mutex_unlock(&register_count_mutex);
> +	mutex_unlock(&register_done_mutex);
>   }
>
>   bool acpi_video_handles_brightness_key_presses(void)
>   {
>   	bool have_video_busses;
>
> +	wait_for_completion(&register_done);
>   	mutex_lock(&video_list_lock);
>   	have_video_busses = !list_empty(&video_bus_head);
>   	mutex_unlock(&video_list_lock);
>
