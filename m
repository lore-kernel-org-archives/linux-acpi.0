From: Marcel Holtmann <marcel-kz+m5ild9QBg9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] Bluetooth: hci_intel: Cleanup the device probe code
Date: Wed, 30 Sep 2015 16:52:03 +0200
Message-ID: <9BB7E6C8-A45E-4D88-8B01-D1660370B7FF@holtmann.org>
References: <1443619732-19401-1-git-send-email-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2104\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1443619732-19401-1-git-send-email-jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: linux-bluetooth <linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Gustavo F. Padovan" <gustavo-THi1TnShQwVAfugRpC6u6w@public.gmane.org>, Johan Hedberg <johan.hedberg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Loic Poulain <loic.poulain-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi Jarkko,

> There is some unneeded code in "hci_intel" probing. First
> acpi_match_device() call is needless as driver/platform/acpi core code has
> already done the matching before calling the probe and the driver does not
> use the returned pointer to matching _HID other than checking is it NULL.
> 
> Then tree wide grep for "hci_intel" doesn't reveal that there is any code
> registering this platform device so it looks this device is always backed
> with ACPI companion so also ACPI_HANDLE() test can be removed.

eventually there will be DT platform device. Does that make a difference or is it still valid to remove this probe handling.

Regards

Marcel
