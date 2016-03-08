From: "Zheng, Lv" <lv.zheng@intel.com>
Subject: RE: [PATCH] ACPICA: Events: Execute some _REG methods in early boot
Date: Tue, 8 Mar 2016 00:54:51 +0000
Message-ID: <1AE640813FDE7649BE1B193DEA596E883BB60AB0@SHSMSX101.ccr.corp.intel.com>
References: <20160227190828.GA4751@localhost>
 <1457190715-5851-1-git-send-email-chris.bainbridge@gmail.com>
 <1AE640813FDE7649BE1B193DEA596E883BB608C0@SHSMSX101.ccr.corp.intel.com>
 <20160307101904.GA4417@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:18328 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932114AbcCHAy4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 7 Mar 2016 19:54:56 -0500
In-Reply-To: <20160307101904.GA4417@localhost>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Chris Bainbridge <chris.bainbridge@gmail.com>
Cc: "Moore, Robert" <robert.moore@intel.com>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Hi, Chris

> From: linux-acpi-owner@vger.kernel.org [mailto:linux-acpi-
> Subject: Re: [PATCH] ACPICA: Events: Execute some _REG methods in early
> boot
> 
> On Mon, Mar 07, 2016 at 06:36:05AM +0000, Zheng, Lv wrote:
> > Hi,
> >
> > First of all, why don't you respond on the kernel bugzilla?
> > Posting a fix here directly without communication doesn't look like a
> constructive help but more like a destructive attack to me.
> 
> Sorry if it appears to be an attack. It wasn't meant that way. I was
> under the impression that email is the preferred means of communication
> for kernel development. I'm not sure whether other developers actively
> monitor bugzilla reports (some do, but bug trackers are often graveyards
> for bug reports and it's easy for communications to be missed).
> 
[Lv Zheng] 
Apologies. It's my fault.
I didn't see your last reply.

> > As I said in the previous reply, this is the known issue and can be fixed by
> applying the whole series.
> > Especially this commit:
> > https://patchwork.kernel.org/patch/8241421/
> > That's why I asked you to test again by applying the whole series.
> > And that's why after having not seen your response for so long time, we
> prepared a test branch and was waiting for your response.
> 
> I already replied 9 days ago: https://lkml.org/lkml/2016/2/27/164
> The suggested patch did not fix the issue and the patch series did not
> apply cleanly.
> 
> (btw I'm not paid for this work so I tend to handle it in batches when I
> have spare time, which is why you may see replies delayed to weekends etc.)
> 
[Lv Zheng] 
The problem is the reply didn't arrive the proper mailbox here.

> > You need to post acpidump there to have the issue root caused so that more
> accurate fix can be generated.
> 
> I already sent an acpidump for this system to you and Robert (email 3rd Feb).
> 
> > The above fix looks hackish to me.
> > IMO, if you want to stop regressions that are triggered by this commit.
> > A simpler and proper way would be to move acpi_gbl_reg_method_enabled =
> TRUE to the end of acpi_load_tables().
> > So that when the order of table loading and ECDT probing is corrected, the
> correct logic can still apply.
> >
> > I don't have ECDT platforms in hand to confirm.
> > Can you help to just give it a try?
> 
> Yes the fix may be hackish, but it served the purpose of correctly
> identifying the bug. Your suggestion works fine, for reference the
> tested patch was:
> 
> 
> diff --git a/drivers/acpi/acpica/tbxfload.c b/drivers/acpi/acpica/tbxfload.c
> index 278666e39563..9136d7250022 100644
> --- a/drivers/acpi/acpica/tbxfload.c
> +++ b/drivers/acpi/acpica/tbxfload.c
> @@ -83,6 +83,7 @@ acpi_status __init acpi_load_tables(void)
>  				"While loading namespace from ACPI tables"));
>  	}
> 
> +	acpi_gbl_reg_methods_enabled = TRUE;
>  	return_ACPI_STATUS(status);
>  }
> 
> diff --git a/drivers/acpi/acpica/utxfinit.c b/drivers/acpi/acpica/utxfinit.c
> index 721b87cce908..2c0491038068 100644
> --- a/drivers/acpi/acpica/utxfinit.c
> +++ b/drivers/acpi/acpica/utxfinit.c
> @@ -267,7 +267,6 @@ acpi_status __init acpi_initialize_objects(u32 flags)
>  	 * initialized, even if they contain executable AML (see the call to
>  	 * acpi_ns_initialize_objects below).
>  	 */
> -	acpi_gbl_reg_methods_enabled = TRUE;
>  	if (!(flags & ACPI_NO_ADDRESS_SPACE_INIT)) {
>  		ACPI_DEBUG_PRINT((ACPI_DB_EXEC,
>  				  "[Init] Executing _REG OpRegion
> methods\n"));
> 
> 
> With this patch applied the ODEBUG errors do not occur.
[Lv Zheng] 
Great!
This line doesn't differ too much in ACPICA upstream, while it matters much in Linux code base.

I should rebase the other patches along with this on top of ACPICA Feb release.
But as I don't have real ECDT platforms, I can just test the fixes by faking ECDT using initrd table override mechanism.
I think it's better to have you confirm the whole series again.
I saw you started to reply on the Bugzilla entry, I'll ping you there after rebasing the patchset.
> 
> Thanks.
[Lv Zheng] 
Thanks and best regards
-Lv
