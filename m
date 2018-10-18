From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] ACPICA: AML interpreter: add region addresses in global
 list during initialization
Date: Thu, 18 Oct 2018 07:05:51 +0200
Message-ID: <20181018050551.GA25258@kroah.com>
References: <20181017210935.3754-1-erik.schmauss@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181017210935.3754-1-erik.schmauss@intel.com>
Sender: stable-owner@vger.kernel.org
To: Erik Schmauss <erik.schmauss@intel.com>
Cc: linux-acpi@vger.kernel.org, rjw@rjwysocki.net, stable@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Wed, Oct 17, 2018 at 02:09:35PM -0700, Erik Schmauss wrote:
> The table load process omitted adding the operation region address
> range to the global list. This omission is problematic because the OS
> queries the global list to check for address range conflicts before
> deciding which drivers to load. This commit may result in warning
> messages that look like the following:
> 
> [    7.871761] ACPI Warning: system_IO range 0x00000428-0x0000042F conflicts with op_region 0x00000400-0x0000047F (\PMIO) (20180531/utaddress-213)
> [    7.871769] ACPI: If an ACPI driver is available for this device, you should use it instead of the native driver
> 
> However, these messages do not signify regressions. It is a result of
> properly adding address ranges within the global address list.
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=200011
> Tested-by: Jean-Marc Lenoir <archlinux@jihemel.com>
> Signed-off-by: Erik Schmauss <erik.schmauss@intel.com>
> ---

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>
