From: Rob Lee <rob.lee@linaro.org>
Subject: Re: [RFC] ARM: imx: Add imx6q thermal
Date: Thu, 12 Jan 2012 14:47:27 -0600
Message-ID: <CAMXH7KH=37bCvfytO0gpy4qFvMzwZmMfQ0ZOsao6Qf5w9qSHOw@mail.gmail.com>
References: <1326266285-11656-1-git-send-email-rob.lee@linaro.org>
	<4F0E887D.2090009@de.bosch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-qy0-f174.google.com ([209.85.216.174]:36103 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755378Ab2ALUr2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 12 Jan 2012 15:47:28 -0500
Received: by qcsg13 with SMTP id g13so1284711qcs.19
        for <linux-acpi@vger.kernel.org>; Thu, 12 Jan 2012 12:47:28 -0800 (PST)
In-Reply-To: <4F0E887D.2090009@de.bosch.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dirk Behme <dirk.behme@de.bosch.com>
Cc: "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "shawn.guo@freescale.com" <shawn.guo@freescale.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "lenb@kernel.org" <lenb@kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "amit.kucheria@linaro.org" <amit.kucheria@linaro.org>, "patches@linaro.org" <patches@linaro.org>, Eric Miao <eric.miao@linaro.org>

Hello Dirk, thanks for the review.  Comments below.

On Thu, Jan 12, 2012 at 1:15 AM, Dirk Behme <dirk.behme@de.bosch.com> w=
rote:
> Hi Rob,
>
>
> On 11.01.2012 08:18, Robert Lee wrote:
>>
>> Add thermal support for i.MX6Q. =A0Uses recently submitted common
>> cpu_cooling functionality shown here:
>>
>> http://www.spinics.net/lists/linux-pm/msg26500.html
>>
>> Have some todo items but basic implementation is done and I'd like t=
o
>> get any helpful feedback on it.
>>
>> Todo:
>> - Add sensor calibration.

I should have added: "(coming in version 2 of this patch)".  The
reading of the fuse value and the calibration will be in the next
version of this patch.

>> - Re-organize code/files if deemed necessary by community.
>
>
> Just fyi, I had a short discussion with Eric Miao about this. The con=
clusion
> was:
>
> The patch itself is OK. It's just lacking some features, but these ca=
n be
> added later. The driver supports thermal reading only, but not accura=
te as
> the thermal calibration data is burned into the FUSE, and differ from=
 chip
> to chip. At the moment only incorrect thermal information will be exp=
osed to
> user space. The patch is lacking connections to cpufreq and cpu hotpl=
ug, but
> those could be added later, too.
>

This patch connects to cpufreq using cpu_cooling functionality
recently submitted in Amit Katchhap's patch linked above.  This
registration is done here:

+
+       th_zone->cool_dev =3D cpufreq_cooling_register(
+               (struct freq_pctg_table *)th_zone->thermal_data->freq_t=
ab,
+               IMX6Q_THERMAL_ACT_TRP_PTS, cpumask_of(0));
+

I tested it successfully with CPUFREQ during development, but I did
not re-test in this final patch and noticed a couple of bugs I
introduced later that will prevent it from working properly.  v2 will
resolve these issues.

> Best regards
>
> Dirk
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
