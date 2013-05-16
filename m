From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: ACPI fan driver: uninitialized variable when CONFIG_PM is not
 set
Date: Thu, 16 May 2013 09:07:23 +0800
Message-ID: <1368666443.2063.22.camel@rzhang1-mobl4>
References: <CANN689GoQm8dGEN6L1xuuc_aZ_65G3N7tBPbEXHjAfebB7xrLw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CANN689GoQm8dGEN6L1xuuc_aZ_65G3N7tBPbEXHjAfebB7xrLw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Michel Lespinasse <walken@google.com>
Cc: linux-acpi@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>
List-Id: linux-acpi@vger.kernel.org

Hi, Michel,

On Mon, 2013-04-29 at 05:32 -0700, Michel Lespinasse wrote:
> In the following code:
> 
> static int fan_get_cur_state(struct thermal_cooling_device *cdev, unsigned long
>                              *state)
> {
>         struct acpi_device *device = cdev->devdata;
>         int result;
>         int acpi_state;
> 
>         if (!device)
>                 return -EINVAL;
> 
>         result = acpi_bus_update_power(device->handle, &acpi_state);
>         if (result)
>                 return result;
> 
>         *state = (acpi_state == ACPI_STATE_D3 ? 0 :
>                  (acpi_state == ACPI_STATE_D0 ? 1 : -1));
>         return 0;
> }
> 
> With CONFIG_PM not set, acpi_bus_update_power() returns 0 and does not
> initialize acpi_state. This results in acpi_state being used before
> initialization.
> 
> (I found out by random chance, as I suppose people don't normally
> build without CONFIG_PM anymore ?)
> 
> I'm not sure what a proper fix would be, so I'll just report this here
> and enable CONFIG_PM locally :)
> 
thanks for your report.
please check if the following patch helps or not.
https://patchwork.kernel.org/patch/2574691/

thanks,
rui
