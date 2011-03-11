From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 1/4] X86: Revamp reboot behaviour to match Windows more closely
Date: Fri, 11 Mar 2011 23:08:18 +0100
Message-ID: <201103112308.18221.rjw@sisk.pl>
References: <1299877940-6870-1-git-send-email-mjg@redhat.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:52485 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755479Ab1CKWIb (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 11 Mar 2011 17:08:31 -0500
In-Reply-To: <1299877940-6870-1-git-send-email-mjg@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg@redhat.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org

On Friday, March 11, 2011, Matthew Garrett wrote:
> Windows reboots by hitting the ACPI reboot vector (if available), trying
> the keyboard controller, hitting the ACPI reboot vector again and then
> giving the keyboard controller one last go. Rework our reboot process a
> little to default to matching this behaviour, although we'll fall through
> to attempting a triple fault if nothing else works.

Does this fix a particular problem observed in practice?

Rafael


> Signed-off-by: Matthew Garrett <mjg@redhat.com>
> ---
>  arch/x86/kernel/reboot.c |   23 ++++++++++++++++++++++-
>  1 files changed, 22 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/x86/kernel/reboot.c b/arch/x86/kernel/reboot.c
> index 715037c..2b8d03c 100644
> --- a/arch/x86/kernel/reboot.c
> +++ b/arch/x86/kernel/reboot.c
> @@ -35,7 +35,7 @@ EXPORT_SYMBOL(pm_power_off);
>  
>  static const struct desc_ptr no_idt = {};
>  static int reboot_mode;
> -enum reboot_type reboot_type = BOOT_KBD;
> +enum reboot_type reboot_type = BOOT_ACPI;
>  int reboot_force;
>  
>  #if defined(CONFIG_X86_32) && defined(CONFIG_SMP)
> @@ -547,9 +547,23 @@ void __attribute__((weak)) mach_reboot_fixups(void)
>  {
>  }
>  
> +/*
> + * Windows does the following on reboot:
> + * 1) If the FADT has the ACPI reboot register flag set, try it
> + * 2) If still alive, write to the keyboard controller
> + * 3) If still alive, write to the ACPI reboot register again
> + * 4) If still alive, write to the keyboard controller again
> + *
> + * If the machine is still alive at this stage, it gives up. We default to
> + * following the same pattern, except that if we're still alive after (4) we'll
> + * try to force a triple fault and then cycle between hitting the keyboard
> + * controller and doing that
> + */
>  static void native_machine_emergency_restart(void)
>  {
>  	int i;
> +	int attempt = 0;
> +	int orig_reboot_type = reboot_type;
>  
>  	if (reboot_emergency)
>  		emergency_vmx_disable_all();
> @@ -571,6 +585,13 @@ static void native_machine_emergency_restart(void)
>  				outb(0xfe, 0x64); /* pulse reset low */
>  				udelay(50);
>  			}
> +			if (attempt == 0 && orig_reboot_type == BOOT_ACPI) {
> +				attempt = 1;
> +				reboot_type = BOOT_ACPI;
> +			} else {
> +				reboot_type = BOOT_TRIPLE;
> +			}
> +			break;
>  
>  		case BOOT_TRIPLE:
>  			load_idt(&no_idt);
> 

