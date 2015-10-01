From: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH] Bluetooth: hci_intel: Cleanup the device probe code
Date: Thu, 01 Oct 2015 09:26:56 +0300
Message-ID: <560CD230.9050008@linux.intel.com>
References: <1443619732-19401-1-git-send-email-jarkko.nikula@linux.intel.com> <9BB7E6C8-A45E-4D88-8B01-D1660370B7FF@holtmann.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <9BB7E6C8-A45E-4D88-8B01-D1660370B7FF-kz+m5ild9QBg9hUCZPvPmw@public.gmane.org>
Sender: linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Marcel Holtmann <marcel-kz+m5ild9QBg9hUCZPvPmw@public.gmane.org>
Cc: linux-bluetooth <linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Gustavo F. Padovan" <gustavo-THi1TnShQwVAfugRpC6u6w@public.gmane.org>, Johan Hedberg <johan.hedberg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Loic Poulain <loic.poulain-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On 09/30/2015 05:52 PM, Marcel Holtmann wrote:
> Hi Jarkko,
>
>> There is some unneeded code in "hci_intel" probing. First
>> acpi_match_device() call is needless as driver/platform/acpi core code has
>> already done the matching before calling the probe and the driver does not
>> use the returned pointer to matching _HID other than checking is it NULL.
>>
>> Then tree wide grep for "hci_intel" doesn't reveal that there is any code
>> registering this platform device so it looks this device is always backed
>> with ACPI companion so also ACPI_HANDLE() test can be removed.
>
> eventually there will be DT platform device. Does that make a difference or is it still valid to remove this probe handling.
>
Also with DT matching the acpi_match_device() is needless. Adding DT 
support here means just adding pointer to OF match table like below and 
core will call the probe if there is a match to "hci_intel" platform 
device, ACPI _HID or OF node.

static struct platform_driver intel_driver = {
	.driver = {
		.name = "hci_intel",
		.acpi_match_table = ACPI_PTR(intel_acpi_match),
		.of_match_table = of_match_ptr(intel_of_match),
	},
};

If there is need to differentiate between these in probe the driver 
could do for instance

if (has_acpi_companion(&pdev->dev)) {
	/* ACPI enumerated */
} else if (pdev->dev.of_node) {
	/* DT enumerated */
} else {
	/* platform device */
}

-- 
Jarkko
