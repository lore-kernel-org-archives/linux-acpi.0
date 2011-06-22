From: Anton Vorontsov <cbouatmailru@gmail.com>
Subject: Re: Exporting struct power_supply.use_for_apm
Date: Wed, 22 Jun 2011 19:38:07 +0400
Message-ID: <20110622153807.GA17144@oksana.dev.rtsoft.ru>
References: <BANLkTimy_b1qva63DumxU=SBLHXMaPS2cg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <BANLkTimy_b1qva63DumxU=SBLHXMaPS2cg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Richard Hughes <hughsient@gmail.com>
Cc: linux-acpi <linux-acpi@vger.kernel.org>, spyro@f2s.com, Bastien Nocera <hadess@hadess.net>, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Hello,

On Wed, Jun 22, 2011 at 03:25:03PM +0100, Richard Hughes wrote:
> Hi, if this isn't the correct mailing list please yell. I'm the author
> of upower which is a userspace service that presents the power devices
> in the system as a DBus interface for the session to use.
> 
> In struct power_supply there is a boolean use_for_apm which seems to
> be 1 for devices actually powering the system, and 0 for devices
> attached to the machine. Would this be sane to export into sysfs as
> something sane?

Nope, use_for_apm is a legacy stuff. It just says which battery should
be reported via /proc/apm interface (if arch supports it).

It should be removed completely someday.

> The reason I ask, is that upower has to decide if the system as a
> whole has several high level states, e.g. "low-power" or
> "critically-low-power" and for that it needs to decide if the battery
> backing the power supply device is critical to the system power state.
> This would mean that a ACPI battery or UPS running low would mean the
> system is low, but a USB mouse or a wacom tablet would not prompt the
> low power warning.
> 
> This email has been triggered by a bug report :
> https://bugs.freedesktop.org/show_bug.cgi?id=38569 in which the kernel
> patch http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=59d2334ac9f4255f5f8f3e4e1bf41653e0bba99e;hp=4da361b69102cdffe73006771eae7504d2cb8736
> added the power_supply device which confuses upower.
> 
> The alternative is to change the wacom power_supply code from
> type=POWER_SUPPLY_TYPE_BATTERY to something else, e.g.
> POWER_SUPPLY_TYPE_ACCESSORY which upower can easily key from. I really
> don't want to blacklist "battery_wacom" as that seems like such a
> hack.

Yeah, that seems sane. But I'm not sure if that should be a type thing.

Instead, we might want to introduce additional
'struct device **supplied_to_devs' field in the 'struct power_supply'
(we have supplied_to field, but it won't work as it holds only device
names).

So, the logic should be:

bool power_supply_is_system_supply(device)
{
	for_each_supplied_to(device, supplied_to) {
		if (!is_power_supply(supplied_to)
			return false;
		return power_supply_is_system_supply(supplied_to)
	}
	return true;
}

And the kernel might export 'system_supply' property for each
battery.

Wacom driver will need just a small modification: it should fill
supplied_to_devs with its struct device.

Plus, someday we might want to expose 'supplied_to' via sysfs
directory.

E.g., if supplied_to_devs == NULL, then /sys/power_supply/BAT/supplied_to/
symlinks to /sys/devices. I.e. it's a system battery/mains.

If psy->supplied_to_devs == { dev1, dev2 }, then supplied_to/ contains
symlinks to only these devices.

Typical system with a removable battery (both AC0 and BAT0 power the
whole system):

AC0/supplied_to -> /sys/devices
BAT0/supplied_to -> /sys/devices
battery_wacom/supplied_to -> /sys/devices/pci0000\:00/0000\:00\:1c.0/wacom_input_device

Typical system with a electrically non-removable battery, i.e. AC0 only
powers BAT0, which powers a system:

AC0/supplied_to -> /sys/devices/platform/BAT0
BAT0/supplied_to -> /sys/devices
battery_wacom/supplied_to -> /sys/devices/pci0000\:00/0000\:00\:1c.0/wacom_input_device

-- 
Anton Vorontsov
Email: cbouatmailru@gmail.com
