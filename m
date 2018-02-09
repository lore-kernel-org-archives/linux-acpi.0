From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v1 2/2] acpi/dock: document sysfs interface
Date: Fri, 9 Feb 2018 11:26:07 +0100
Message-ID: <CAJZ5v0iEp6XkOQtKN8pQBnoOShrinwkZ5wdFUutLFFtPQUT=vA@mail.gmail.com>
References: <cover.1518009225.git.aishpant@gmail.com> <9dff9dee68daf82305de32c45604757eca93afaf.1518009225.git.aishpant@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <9dff9dee68daf82305de32c45604757eca93afaf.1518009225.git.aishpant@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Aishwarya Pant <aishpant@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, Greg KH <gregkh@linuxfoundation.org>, Julia Lawall <julia.lawall@lip6.fr>
List-Id: linux-acpi@vger.kernel.org

On Wed, Feb 7, 2018 at 2:18 PM, Aishwarya Pant <aishpant@gmail.com> wrote:
> Description has been collected from git commit history and reading
> through code.
>
> Signed-off-by: Aishwarya Pant <aishpant@gmail.com>
> ---
>  .../ABI/testing/sysfs-devices-platform-dock        | 38 ++++++++++++++++++++++
>  1 file changed, 38 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-devices-platform-dock
>
> diff --git a/Documentation/ABI/testing/sysfs-devices-platform-dock b/Documentation/ABI/testing/sysfs-devices-platform-dock
> new file mode 100644
> index 000000000000..0bb0d42e9126
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-devices-platform-dock
> @@ -0,0 +1,38 @@
> +sysfs interface for ACPI dock station driver
> +--------------------------------------------
> +
> +What:          /sys/devices/platform/dock.N/docked
> +What:          /sys/devices/platform/dock.N/undock
> +Date:          Dec, 2006
> +KernelVersion: 2.6.19
> +Contact:       linux-acpi@vger.kernel.org
> +Description:
> +               docked: (RO) Value 1 or 0 indicates whether the software
> +               believes the laptop is docked in a docking station.
> +
> +               undock: (WO) Writing to this file causes the software to
> +               initiate an undock request to the firmware.

Please split the above into two entries.

Apart from that it looks OK to me.
