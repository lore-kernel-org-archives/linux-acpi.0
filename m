From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: [PATCH 1/1] ACPI: pci_irq, add PRT_ quirk for IBM Bartolo
Date: Tue, 7 Sep 2010 08:40:18 -0600
Message-ID: <AANLkTi=bnr-tnTkCWuSqYhLkfnXhJQjSyLDTt_5RyiAN@mail.gmail.com>
References: <1277673679-21458-1-git-send-email-jslaby@suse.cz>
	<4C27E965.80508@gmail.com>
	<4C283D84.6080504@suse.cz>
	<20100628171410.GA27367@srcf.ucam.org>
	<4C290245.2040001@suse.cz>
	<20100628204820.GA32503@srcf.ucam.org>
	<AANLkTil-sdbojCXBp6sR_4xL3JIe6ZENqXuueB61VJ8c@mail.gmail.com>
	<4C2A3E27.4060407@suse.cz>
	<AANLkTimkElR1u-iRyFfCEQR5VTZvcyEIGQodfmFNtbC_@mail.gmail.com>
	<4C2B0C73.9050200@suse.cz>
	<4C3278C8.60503@gmail.com>
	<4C447D6D.5060801@suse.cz>
	<AANLkTin9_yEyMZImRbtKTvTeokks8dz0htQCu0B3RqXH@mail.gmail.com>
	<4C456C69.60606@suse.cz>
	<4C737E9F.7060107@gmail.com>
	<AANLkTin7eUS7_y9J8iY1XFi2bRnpm+WqFNT_tBopwyCK@mail.gmail.com>
	<4C7B5F64.30205@suse.cz>
	<4C861BB9.2000707@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4C861BB9.2000707@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Slaby <jirislaby@gmail.com>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, lenb@kernel.org, linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Jesse Barnes <jbarnes@virtuousgeek.org>
List-Id: linux-acpi@vger.kernel.org

On Tue, Sep 7, 2010 at 5:02 AM, Jiri Slaby <jirislaby@gmail.com> wrote:
> On 08/30/2010 09:36 AM, Jiri Slaby wrote:
>> On 08/25/2010 01:25 AM, Robert Hancock wrote:
>>> On Tue, Aug 24, 2010 at 2:11 AM, Jiri Slaby <jirislaby@gmail.com> wrote:
>>>> So, to sum up:
>>>> 1) acpi routing enabled (no kernel parameter) => ports 4+5 defunct.
>>>> ports 4+5+6+7 are all on irq 11
>>>>
>>>> 2) acpi routing disabled (acpi=noirq) => all ports working, 4+5 on irq
>>>> 10, 6+7 on irq 11
>>>>
>>>> 3) with the quirk [1] and acpi routing enabled => all ports working,
>>>> ports 4+5 on irq 10, 6+7 on irq 11
>>>>
>>>> 4) in windows => 4+5+6+7 are all on irq 9 and the ports are all working.
>>>>
>>>> Any ideas what this means? Especially point 4)?
>>>>
>>>> [1] http://lkml.org/lkml/2010/6/27/85
>>>
>>> I think that's the key question. Is Windows actually using ACPI on
>>> that machine at all? (Check the computer type in Device Manager and
>>> see if it mentions ACPI.)
>>
>> Yes, there is Computer->ACPI PC.
>
> Any ideas here, please? Is there anything what I might try?

I'd suggest opening a report on kernel.org bugzilla under ACPI and
attach the acpidump output..
