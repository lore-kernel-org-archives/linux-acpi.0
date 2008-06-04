From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] libata: Handle bay devices in dock stations
Date: Wed, 04 Jun 2008 06:29:34 -0400
Message-ID: <48466E8E.9070108@garzik.org>
References: <20080528143857.GB5585@homac.suse.de> <4845886E.2010505@garzik.org> <20080603182759.GB3556@homac>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
In-Reply-To: <20080603182759.GB3556@homac>
Sender: linux-ide-owner@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, linux-kernel@vger.kernel.org, Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org, linux-acpi@vger.kernel.org, Matthew Garrett <mjg59@srcf.ucam.org>
List-Id: linux-acpi@vger.kernel.org

Holger Macht wrote:
> * Differentiate between bay devices in dock stations and others:
> 
>  - When an ACPI_NOTIFY_EJECT_REQUEST appears, just signal uevent to
>    userspace (that is when the optional eject button on a bay device is
>    pressed/pulled) giving the possibility to unmount file systems and to
>    clean up. Also, only send uevent in case we get an EJECT_REQUEST
>    without doing anything else. In other cases, you'll get an add/remove
>    event because libata attaches/detaches the device.
> 
>  - In case of a dock event, which in turn signals an
>    ACPI_NOTIFY_EJECT_REQUEST, immediately detach the device, because it
>    may already have been gone
> 
> * In case of an ACPI_NOTIFY_DEVICE/BUS_CHECK, evaluate _STA to check if
>   the device has been plugged or unplugged. If plugged, hotplug it, if
>   unplugged, just signal event to userspace
>   (initial patch by Matthew Garrett <mjg59@srcf.ucam.org>)
> 
> * Call ACPI _EJ0 for detached devices
> 
> Signed-off-by: Holger Macht <hmacht@suse.de>
> ---
> 
> Previous patch differences:
>  * Remove one call to ata_port_freeze
>  * Add some documentation from Tejun

applied


