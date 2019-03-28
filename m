From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v2] ACPI / PM: Propagate KEY_POWER to user space when
 resume
Date: Thu, 28 Mar 2019 14:31:49 +0100
Message-ID: <1ad154aa-4d92-395d-890c-fe81b0bf21b5@redhat.com>
References: <CAJZ5v0g3+S0vkW0XTzMKA8rYCtgy7yJ+UDc5xG4rRcdTbcJ=Lg@mail.gmail.com>
 <20190328103448.20335-1-hu1.chen@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190328103448.20335-1-hu1.chen@intel.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "Chen, Hu" <hu1.chen@intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>
List-Id: linux-acpi@vger.kernel.org

Hi,

On 28-03-19 11:34, Chen, Hu wrote:
> I run Android on x86 PC (it's a NUC). Everytime I press the power button
> to wake the system, it suspends right away. After some debug, I find
> that Android wants to see KEY_POWER at resume. Otherwise, its
> opportunistic suspend will kick in shortly.
> 
> However, other OS such as Ubuntu doesn't like KEY_POWER at resume. So
> add a knob "/sys/module/button/parameters/key_power_at_resume" for users
> to select.

We've had a similar discussion about the power-button on Bay Trail tablets,
which often is connected to a GPIO driver.

There we had the opposite problem, that regular desktop environments
like GNOME (and the related daemons) will immediately re-suspend again
on resume because of a KEY_POWER press event at resume. I submitted patches
to make the gpio-keys code not send a keypress on resume (configurable
per button) but that got nacked by Dmitry, the input subsystem maintainer.

It seems that this mostly is an evdev/input policy decision so that
this patch is going to need an ack from Dmitry, I've added Dmitry
to the Cc.

Note that after my kernel level fix for the Bay Trail devices got
nacked, I worked-around this in userspace:

https://gitlab.gnome.org/GNOME/gnome-settings-daemon/commit/f2ae8a3b9905cde7a9c12f78cb84689e97203380

But for GNOME only, e.g. KDE will likely still have a problem with
a KEY_POWER event being reported after suspend.

It seems the problem is that we have 2 different userspaces here
which have exact opposite expectations wrt KEY_POWER reporting
after a wakeup from suspend with the power-button. Android expects
it to be reported, which is why gpio-keys is reporting it since it
is mostly used with Android, where as classic Linux desktop-environments
expect it to NOT be reported, which is why the acpi-button.c code
so far has not reported it :|

I believe that unconditionally sending KEY_POWER after resume
will indeed causes issues for standard Linux distros, so I believe
that your solution with a parameter for people who want to run
android on plain x86 hardware is the best we can do now, but
I really wish we would remedy this situation one way or the other.

I wanted to give everyone involved the whole story, hence the
long mail :)

Regards,

Hans






> 
> Signed-off-by: Chen, Hu <hu1.chen@intel.com>
> ---
> 
>   drivers/acpi/button.c | 6 +++++-
>   drivers/acpi/sleep.c  | 8 ++++++++
>   2 files changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/button.c b/drivers/acpi/button.c
> index a19ff3977ac4..f98e6d85dd2b 100644
> --- a/drivers/acpi/button.c
> +++ b/drivers/acpi/button.c
> @@ -129,6 +129,10 @@ struct acpi_button {
>   	bool suspended;
>   };
>   
> +/* does userspace want to see KEY_POWER at resume? */
> +static bool key_power_at_resume __read_mostly;
> +module_param(key_power_at_resume, bool, 0644);
> +
>   static BLOCKING_NOTIFIER_HEAD(acpi_lid_notifier);
>   static struct acpi_device *lid_device;
>   static u8 lid_init_state = ACPI_BUTTON_LID_INIT_METHOD;
> @@ -417,7 +421,7 @@ static void acpi_button_notify(struct acpi_device *device, u32 event)
>   			int keycode;
>   
>   			acpi_pm_wakeup_event(&device->dev);
> -			if (button->suspended)
> +			if (button->suspended && !key_power_at_resume)
>   				break;
>   
>   			keycode = test_bit(KEY_SLEEP, input->keybit) ?
> diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
> index 403c4ff15349..c5dcee9f5872 100644
> --- a/drivers/acpi/sleep.c
> +++ b/drivers/acpi/sleep.c
> @@ -462,6 +462,13 @@ static int find_powerf_dev(struct device *dev, void *data)
>   	return !strcmp(hid, ACPI_BUTTON_HID_POWERF);
>   }
>   
> +static void pwr_btn_notify(struct device *dev)
> +{
> +	struct acpi_device *device = to_acpi_device(dev);
> +
> +	device->driver->ops.notify(device, ACPI_FIXED_HARDWARE_EVENT);
> +}
> +
>   /**
>    *	acpi_pm_finish - Instruct the platform to leave a sleep state.
>    *
> @@ -505,6 +512,7 @@ static void acpi_pm_finish(void)
>   				      find_powerf_dev);
>   	if (pwr_btn_dev) {
>   		pm_wakeup_event(pwr_btn_dev, 0);
> +		pwr_btn_notify(pwr_btn_dev);
>   		put_device(pwr_btn_dev);
>   	}
>   }
> 
