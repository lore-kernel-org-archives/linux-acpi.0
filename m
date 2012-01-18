From: Rob Lee <rob.lee@linaro.org>
Subject: Re: [RFC PATCH v2] ARM: imx: Add basic imx6q thermal management
Date: Tue, 17 Jan 2012 22:08:57 -0600
Message-ID: <CAMXH7KFpCdLMdgBg9ES-rP+Wf=UaHmM5r09aL3RVv3akre0u7g@mail.gmail.com>
References: <1326775136-32115-1-git-send-email-rob.lee@linaro.org>
	<CAMXH7KEhv9LgvvJ-FnLfaFZNgvJu2gOhFDwpYHDzN9iCDXHjJw@mail.gmail.com>
	<CAMXH7KFdBQmh9eQYXU4Hzg=M9cxyJWzDKouYsGUp+POw0FRXqQ@mail.gmail.com>
	<20120117092324.GV5446@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:63183 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756810Ab2AREI6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 17 Jan 2012 23:08:58 -0500
Received: by qadc10 with SMTP id c10so1267000qad.19
        for <linux-acpi@vger.kernel.org>; Tue, 17 Jan 2012 20:08:57 -0800 (PST)
In-Reply-To: <20120117092324.GV5446@pengutronix.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: linux@arm.linux.org.uk, shawn.guo@freescale.com, amit.kachhap@linaro.org, amit.kucheria@linaro.org, linux-arm-kernel@lists.infradead.org, patches@linaro.org, linux-acpi@vger.kernel.org, lenb@kernel.org

Sascha, one comment below.  Agree with the rest of your comments and a
v3 patch with these fixes will be coming shortly.

>> +static int th_sys_get_temp(struct thermal_zone_device *thermal,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsign=
ed long *temp)
>> +{
>> + =A0 =A0 int tmp =3D 0;
>> +
>> + =A0 =A0 imx6q_get_temp(&tmp);
>> +
>> + =A0 =A0 /*
>> + =A0 =A0 =A0* The thermal framework code stores temperature in unsi=
gned long. Also,
>> + =A0 =A0 =A0* it has references to "millicelcius" which limits the =
lowest
>> + =A0 =A0 =A0* temperature possible (compared to Kelvin).
>> + =A0 =A0 =A0*/
>> + =A0 =A0 if (likely(tmp > 0))
>
> Please no 'likely' in such slow pathes.
>

Why limit 'likely' and 'unlikely' to fast paths?  There usage should
also increase efficiency and thus power usage when used in
periodically/repetitively called code such as this.  In this case, the
increased efficiency will be extremely small but what is the downside
to using it here?
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
