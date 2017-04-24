From: "Zheng, Lv" <lv.zheng@intel.com>
Subject: RE: [PATCH] ACPI / EC: handle ECDT EC and DSDT EC simultaneously
Date: Mon, 24 Apr 2017 04:43:18 +0000
Message-ID: <1AE640813FDE7649BE1B193DEA596E886CE96843@SHSMSX101.ccr.corp.intel.com>
References: <20170420201219.21568-1-drake@endlessm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:47426 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1164667AbdDXEnW (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 24 Apr 2017 00:43:22 -0400
In-Reply-To: <20170420201219.21568-1-drake@endlessm.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Daniel Drake <drake@endlessm.com>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "lenb@kernel.org" <lenb@kernel.org>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "chiu@endlessm.com" <chiu@endlessm.com>, "linux@endlessm.com" <linux@endlessm.com>

Hi,

> From: Daniel Drake [mailto:drake@endlessm.com]
> Sent: Friday, April 21, 2017 4:12 AM
> To: rjw@rjwysocki.net; lenb@kernel.org
> Cc: linux-acpi@vger.kernel.org; Zheng, Lv <lv.zheng@intel.com>; chiu@endlessm.com; linux@endlessm.com
> Subject: [PATCH] ACPI / EC: handle ECDT EC and DSDT EC simultaneously
> 
> The Asus laptops X550VXK/FX502VD/FX502VE have a BIOS bug where the
> ECDT (correctly) states that EC events trigger GPE 0x23, but the
> DSDT _GPE method (incorrectly) says GPE 0x33.
> 
> A cursory glance of the code suggests that this should work regardless
> (because it looks like Linux would treat the ECDT and DSDT as two separate
> ECs supported simultaneously), but in practice it is not working since the
> ECDT is ultimately ignored in favour of the DSDT EC.

IMO, your observation is wrong.

Linux never thought there should be 2 ACPI ECs provided by BIOS :). How
would it be useful to put 2 ECs in your platforms and export both of them
as ACPI EmbeddedControl operation region? EC operation region itself by
design is not able to allow OS to detect which EC opregion belongs to which
EC device as we did see some platforms defined EC opregion under root but
EC device under some bus nodes.

ACPI spec thinks ECDT EC is meant to be provided to work since early stages
where the ACPI namespace hasn't been prepared.

See spec 6.5.4 _REG (Region).
You can find exceptions of _REG execution mentioned for
SystemMemory/SystemIo/PCI_Config and ECDT EC. So they are served for the
same purpose:
 Before executing any control method (aka., preparing the ACPI namespace,
 some hardware components that have already been driven by the BIOS should
 be allowed to be accessed during the namespace preparation.

And hence all DSDT PNP0C09 ECs (actually should only be 1) should always
work, in most of the cases, ECDT EC may just be used as a quirk to make
some EC opregion accesses working during that special stage - the
namespace preparation. For such kind of use case (early stage, loading
ACPI namespace), obviously no EC event should be handled, so making ECDT
GPE setting correct sounds meaningless to BIOS if the same EC settings can
also be provided via DSDT.

Thus Linux is always trying to override ECDT EC with DSDT settings and
convert the final boot EC to the PNP0C09 driver driven ones. Some code is
there not deleted just due to some historical reasons.

As such, GPE setting in DSDT should always be correct.

There are 2 possibilities for some gray areas:
1. If a BIOS has a wrong EC GPE setting in DSDT, but the OS correctly
   implemented IRQ polling to handle it, you still couldn't see any
   problems (you cannot know whether IRQ is handled via interrupt or via
   polling from user space).
2. If ECDT EC contains a namespace path differing from the DSDT one, the
   OS may choose to keep both. Or if ECDT EC contains IO addresses
   differing from the DSDT one, the OS may choose to keep both.
I don't have knowledge to know how Windows implement things in the above
gray areas. They just sound like some happen-to-work consequences of the
unspecified Windows implementation.

For gray area 1, your report just means to me that some platforms do have
correct ECDT GPE setting but incorrect DSDT GPE setting; and since Linux
doesn't implement EC event polling for some stages, for now Linux may need
a quirk to favor "correct GPE setting". 

However for gray area 2, I don't think it means Linux should keep both ECs.
I cannot see reasons in this case to support to do so unless seeing your
acpidump. Are you able to see 2 ECs in your Windows device tree on these
platforms? So could you paste your acpidump here so that we can check if
they are different ACPI ECs and make a decision closer to the Windows
behavior and tell me your Windows device tree result (you can obtain this
using a tool provided in <<Microsoft Windows Internals>>).

Maybe for your case, DSDT EC is just invalid and we should ignore it, then
if we can find a correct way to ignore the DSDT EC, we needn't change a
single line EC driver code.

> The sequence of
> events is:
> 
> 1. acpi_ec_ecdt_probe() is called in early boot, and calls
>    acpi_config_boot_ec(is_ecdt=true) for the ECDT EC.
> 
> acpi_config_boot_ec() sets boot_ec to this new EC, and
> boot_ec_is_ecdt = true.
> 
> 2. Later, acpi_ec_dsdt_probe() is called and creates a new ec to represent
>    the DSDT EC. Then:
>     /*
>      * When the DSDT EC is available, always re-configure boot EC to
>      * have _REG evaluated. _REG can only be evaluated after the
>      * namespace initialization.
>      * At this point, the GPE is not fully initialized, so do not to
>      * handle the events.
>      */
>     ret = acpi_config_boot_ec(ec, ec->handle, false, false);
> 
> So the DSDT EC is passed to acpi_config_boot_ec() which does:
>     /* Unset old boot EC */
>     if (boot_ec != ec)
>         acpi_ec_free(boot_ec);
> 
> acpi_ec_free() sets boot_ec to NULL.
> Further down in acpi_config_boot_ec() we reach:
> 
>     /* Set new boot EC */
>     if (!boot_ec) {
>         boot_ec = ec;
>         boot_ec_is_ecdt = is_ecdt;
>     }
> 
> So now boot_ec points to the DSDT EC and boot_ec_is_ecdt is false.

Correct, now boot EC is overridden by the DSDT settings.
And the ECDT EC is in fact abandoned.

You seem to just need a possibility here to allow OS to abandon the
wrong settings and keep the correct settings.
However it's hard for OS to determine which settings are correct:
ECDT one or DSDT one?
No one can answer this, even ACPI spec cannot.

So you might need a quirk mechanism here before root causing. As this
looks more like a BIOS issue - BIOS developer might have different
understanding than the spec and their code happened to work on Windows
due to different reasons.

> 
> 3. Later, ecpi_ec_ecdt_start() is called and this looks like it would
>    enable GPEs on our ECDT, but it bails out because of:
> 
>     if (!boot_ec_is_ecdt)
>         return -ENODEV;
> 
> 
> The comment I pasted above from acpi_ec_dsdt_probe() says that it is going
> to reconfigure the boot EC, but it instead calls acpi_config_boot_ec() on
> the newly probed DSDT EC. It seems like the code is not following the
> comment here.

No, all above means:
If the boot EC is now overridden by DSDT EC, no need to enable GPE at this
stage. As further PNP0C09 driver probe will do this.

You problem is just PNP0C09 GPE setting is wrong and the code here dropped
possibly correct setting in ECDT.

IMO,
1. We can drop if PNP0C09 GPE driver implements GPE polling for all use
   cases. But now it doesn't implement that.
2. If we cannot drop wrong GPE setting, we may consider a mechanism here
   to allow platform quirks to choose the correct one for Linux.

> 
> Adjusting that code to work with boot_ec adjusts the sequence of events so
> that both boot EC and DSDT are treated independently and as a result, we
> get EC interrupts firing correctly.
> 
> This fixes media keys on the mentioned laptop models.
> Thanks to Chris Chiu for diagnosis.
> 
> Signed-off-by: Daniel Drake <drake@endlessm.com>
> ---
>  drivers/acpi/ec.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
> index c24235d8fb52..78395395e3d9 100644
> --- a/drivers/acpi/ec.c
> +++ b/drivers/acpi/ec.c
> @@ -1691,7 +1691,7 @@ int __init acpi_ec_dsdt_probe(void)
>  	 * At this point, the GPE is not fully initialized, so do not to
>  	 * handle the events.
>  	 */
> -	ret = acpi_config_boot_ec(ec, ec->handle, false, false);
> +	ret = acpi_config_boot_ec(boot_ec, boot_ec->handle, false, false);

This is a hackish, "ec" created above these lines will never be actually
used then.

The entire problem looks to me is:
When GPE setting differs between ECDT and DSDT, which one should be
trusted by OS?

The current code chose to always trust DSDT GPE settings as in theory it
doesn't make sense to trust the ECDT GPE setting in most of the cases,
ECDT GPE is not meant to be used during runtime. So why don't we just add
a quirk to favor GPE setting from ECDT rather than the GPE setting from
DSDT for these platforms?

Thanks
Lv

>  error:
>  	if (ret)
>  		acpi_ec_free(ec);
> --
> 2.11.0

