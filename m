From: Rob Lee <rob.lee@linaro.org>
Subject: Re: [RFC PATCH v3] ARM: imx: Add basic imx6q thermal management
Date: Wed, 18 Jan 2012 05:40:02 -0600
Message-ID: <CAMXH7KE3CUvoZgW2UQiPLc3-oAHO0gcH4GRHU46ScyK519nvfQ@mail.gmail.com>
References: <1326862087-17816-1-git-send-email-rob.lee@linaro.org>
	<1326862087-17816-2-git-send-email-rob.lee@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-qy0-f174.google.com ([209.85.216.174]:48228 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756659Ab2ARLkD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 18 Jan 2012 06:40:03 -0500
Received: by qcsf13 with SMTP id f13so2662514qcs.19
        for <linux-acpi@vger.kernel.org>; Wed, 18 Jan 2012 03:40:02 -0800 (PST)
In-Reply-To: <1326862087-17816-2-git-send-email-rob.lee@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux@arm.linux.org.uk, s.hauer@pengutronix.de, shawn.guo@freescale.com
Cc: amit.kachhap@linaro.org, amit.kucheria@linaro.org, linux-arm-kernel@lists.infradead.org, patches@linaro.org, linux-acpi@vger.kernel.org, lenb@kernel.org

> + =A0 =A0 =A0 /* In the rarest of cases, order matters here - resume =
goes first */
> + =A0 =A0 =A0 th_zone->therm_dev->device.class->resume =3D imx6q_ther=
mal_resume;
> + =A0 =A0 =A0 th_zone->therm_dev->device.class->suspend =3D imx6q_the=
rmal_suspend;
On second thought, I should have barrier between these two statements
to guarantee order.  I think mb() would be ok.
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
