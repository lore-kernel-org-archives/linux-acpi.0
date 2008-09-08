From: Alexey Starikovskiy <astarikovskiy@suse.de>
Subject: Re: patch for bugs 9998 and 10724
Date: Mon, 08 Sep 2008 12:25:03 +0400
Message-ID: <48C4E15F.2020701@suse.de>
References: <1219730254.4116.38.camel@yakui_zhao.sh.intel.com>	 <20080904121820.GC18288@one.firstfloor.org> <48BFD5AA.3090006@suse.de>	 <48BFD609.2050604@suse.de> <1220581596.3441.2.camel@rzhang-dt>	 <48C129D3.5000904@suse.de> <1220842582.3441.30.camel@rzhang-dt>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from charybdis-ext.suse.de ([195.135.221.2]:57736 "EHLO
	emea5-mh.id5.novell.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752420AbYIHIZH (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 8 Sep 2008 04:25:07 -0400
In-Reply-To: <1220842582.3441.30.camel@rzhang-dt>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: Andi Kleen <andi@firstfloor.org>, linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>


Zhang Rui wrote:
> On Fri, 2008-09-05 at 16:45 +0400, Alexey Starikovskiy wrote:
>> Zhang Rui wrote:
>>> On Thu, 2008-09-04 at 16:35 +0400, Alexey Starikovskiy wrote:
>>>> Here is the same patch as attachment for your convenience.
>>>> Alexey Starikovskiy wrote:
>>>>> Hi Andy,
>>>>>
>>>>> I just uploaded patch for bugs 9998 and 10724, which solves the p=
roblem=20
>>>>> of interrupt storm more cleanly.
>>>>> Could you please add this patch to testing?
>>>>>
>>>>> Thanks,
>>>>> Alex.
>>>>>
>>>>>
>>> =EF=BB=BF+       ec->t.command =3D 0;
>>> +       if (test_bit(EC_FLAGS_GPE_STORM, &ec->flags)) {
>>> +               /* check if we received SCI during transaction */
>>> +               ec_check_sci(ec, acpi_ec_read_status(ec));
>>> +               /* it is safe to enable GPE outside of transaction =
*/
>>> +               acpi_enable_gpe(NULL, ec->gpe, ACPI_NOT_ISR);
>>> +       } else if (test_bit(EC_FLAGS_GPE_MODE, &ec->flags) &&
>>> +                  atomic_read(&ec->irq_count) >
>>> ACPI_EC_STORM_THRESHOLD)
> +	{
>>> +               pr_debug(PREFIX "GPE storm detected\n");
>>> +               set_bit(EC_FLAGS_GPE_STORM, &ec->flags);
> +	}
Thanks!
>=20
>=20
> thanks,
> rui
>=20
>>> +       return 0;
>>> +}
>>>
>>> you will set the =EF=BB=BFEC_FLAGS_GPE_STORM flag in every ec trans=
action.
>>> I don't think that's what you/we want. :)
>> please elaborate...
>> If EC_FLAGS_GPE_STORM is set once, I will not get there (else).
>=20
>=20

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
