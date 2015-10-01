From: Marcel Holtmann <marcel-kz+m5ild9QBg9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH 1/5] Bluetooth: hci_bcm: Add missing acpi_dev_free_resource_list()
Date: Thu, 1 Oct 2015 09:13:08 +0200
Message-ID: <FBA45A9C-2E3D-4D13-BEDE-957647DC173F@holtmann.org>
References: <1443619605-19320-1-git-send-email-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2104\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1443619605-19320-1-git-send-email-jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Gustavo F. Padovan" <gustavo-THi1TnShQwVAfugRpC6u6w@public.gmane.org>, Johan Hedberg <johan.hedberg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Frederic Danis <frederic.danis-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi Jarkko,

> Caller of acpi_dev_get_resources() should free the constructed resource
> list by calling the acpi_dev_free_resource_list() in order to avoid memory
> leak.
> 
> Signed-off-by: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> ---
> Call to acpi_dev_get_resources() was introduced by the commit ae056908862b
> ("Bluetooth: hci_bcm: Retrieve UART speed from ACPI") so fix should go to
> v4.3-rc.

if this should go into 4.3 then you need to send it against bluetooth tree actually and not bluetooth-next. And you might want to include patch 2/5 in there as well. Sending them as combined set with bluetooth-next patches is not really helping.

In case this is not an urgent fix that has to make it into 4.3, then I am just applying all 5 to bluetooth-next tree. Your choice.

Regards

Marcel
