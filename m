From: Alexey Starikovskiy <astarikovskiy@suse.de>
Subject: Re: patch for bugs 9998 and 10724
Date: Fri, 05 Sep 2008 16:45:07 +0400
Message-ID: <48C129D3.5000904@suse.de>
References: <1219730254.4116.38.camel@yakui_zhao.sh.intel.com>	 <20080904121820.GC18288@one.firstfloor.org> <48BFD5AA.3090006@suse.de>	 <48BFD609.2050604@suse.de> <1220581596.3441.2.camel@rzhang-dt>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from charybdis-ext.suse.de ([195.135.221.2]:57811 "EHLO
	emea5-mh.id5.novell.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750739AbYIEMpM (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 5 Sep 2008 08:45:12 -0400
In-Reply-To: <1220581596.3441.2.camel@rzhang-dt>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: Andi Kleen <andi@firstfloor.org>, linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>

Zhang Rui wrote:
> On Thu, 2008-09-04 at 16:35 +0400, Alexey Starikovskiy wrote:
>> Here is the same patch as attachment for your convenience.
>> Alexey Starikovskiy wrote:
>>> Hi Andy,
>>>
>>> I just uploaded patch for bugs 9998 and 10724, which solves the pro=
blem=20
>>> of interrupt storm more cleanly.
>>> Could you please add this patch to testing?
>>>
>>> Thanks,
>>> Alex.
>>>
>>>
> =EF=BB=BF+       ec->t.command =3D 0;
> +       if (test_bit(EC_FLAGS_GPE_STORM, &ec->flags)) {
> +               /* check if we received SCI during transaction */
> +               ec_check_sci(ec, acpi_ec_read_status(ec));
> +               /* it is safe to enable GPE outside of transaction */
> +               acpi_enable_gpe(NULL, ec->gpe, ACPI_NOT_ISR);
> +       } else if (test_bit(EC_FLAGS_GPE_MODE, &ec->flags) &&
> +                  atomic_read(&ec->irq_count) >
> ACPI_EC_STORM_THRESHOLD)
> +               pr_debug(PREFIX "GPE storm detected\n");
> +               set_bit(EC_FLAGS_GPE_STORM, &ec->flags);
> +       return 0;
> +}
>=20
> you will set the =EF=BB=BFEC_FLAGS_GPE_STORM flag in every ec transac=
tion.
> I don't think that's what you/we want. :)
please elaborate...
If EC_FLAGS_GPE_STORM is set once, I will not get there (else).
Do I miss something?
>=20
> thanks,
> rui
>=20

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
