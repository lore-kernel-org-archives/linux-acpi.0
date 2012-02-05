From: Colin Cross <ccross@google.com>
Subject: Re: [RFC PATCH v4 1/4] cpuidle: Add time keeping and irq enabling
Date: Sat, 4 Feb 2012 17:36:05 -0800
Message-ID: <CAMbhsRR2Zsv7d+_iganMhz5WxDiUYd-zOCoVehz4yjzyH2q+wA@mail.gmail.com>
References: <1328065215-28108-1-git-send-email-rob.lee@linaro.org>
	<1328065215-28108-2-git-send-email-rob.lee@linaro.org>
	<CAMbhsRQxgvRN0skteFxeDBqmUArTa3wu2uZPqowDnBTSWuqScg@mail.gmail.com>
	<CAJOA=zOhKtt5GohHfYp6=xVTODR2a_RGkDNTwozbusrBSsqE+w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:38249 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753404Ab2BEBgI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 4 Feb 2012 20:36:08 -0500
Received: by iacb35 with SMTP id b35so6682894iac.19
        for <linux-acpi@vger.kernel.org>; Sat, 04 Feb 2012 17:36:08 -0800 (PST)
In-Reply-To: <CAJOA=zOhKtt5GohHfYp6=xVTODR2a_RGkDNTwozbusrBSsqE+w@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Turquette, Mike" <mturquette@ti.com>
Cc: Robert Lee <rob.lee@linaro.org>, nicolas.pitre@linaro.org, linaro-dev@lists.linaro.org, nicolas.ferre@atmel.com, linux@arm.linux.org.uk, khilman@ti.com, kgene.kim@samsung.com, daniel.lezcano@linaro.org, magnus.damm@gmail.com, linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, patches@linaro.org, arnd.bergmann@linaro.org, len.brown@intel.com, linux-pm@vger.kernel.org, nsekhar@ti.com, s.hauer@pengutronix.de, Baohua.Song@csr.com, vincent.guittot@linaro.org, linux@maxim.org.za, shawn.guo@freescale.com, deepthi@linux.vnet.ibm.com, broonie@opensource.wolfsonmicro.com, amit.kucheria@linaro.org, amit.kachhap@linaro.org

On Sat, Feb 4, 2012 at 2:06 PM, Turquette, Mike <mturquette@ti.com> wro=
te:
> On Sat, Feb 4, 2012 at 11:02 AM, Colin Cross <ccross@google.com> wrot=
e:
>> What's the point of the pre_enter call? =A0This seems very similar t=
o
>> the prepare call that was removed in 3.2. =A0Drivers can already dem=
ote
>
> Hi Colin,
>
> I asked Rob to re-introduce the .prepare callback (not .pre_enter).
>
> The short version of why I requested this is so that I can experiment
> with modifying wake-up latency and theshold values dynamically based
> on PM QoS constraints. =A0For an OMAP-specific example, I'd like to s=
ee
> our C-states no longer model both MPU and CORE power domains, and
> instead only model the MPU. =A0Then when entering idle the PM QoS
> constraints against the CORE power domain's wake-up latency can be
> considered in the .prepare callback which will affect the C-state
> parameters as well as program the CORE low power target state.

prepare makes sense to adjust latencies, as long as it is not used for
state demotion as well.

> .pre_enter isn't really right for the above case so I'm happy for it
> to be dropped, but I'll probably re-introduce something like .prepare
> in the future...
>
> Regards,
> Mike
>
>> the target state in their enter call. =A0The only thing you do betwe=
en
>> pre_enter and enter is trace and account for the time. =A0Is there s=
ome
>> long call you don't want included in the idle time? =A0Some
>> documentation would help, and you need to very clearly define the
>> semantics of when post_enter gets called when pre_enter or enter
>> return errors.
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
