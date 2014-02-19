From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v5 2/5] ACPI / processor_core: Rework _PDC related stuff to make it more arch-independent
Date: Wed, 19 Feb 2014 17:52:53 +0100
Message-ID: <1643739.gIWxXCQHpB@vostro.rjw.lan>
References: <1392740638-2479-1-git-send-email-hanjun.guo@linaro.org> <3459962.GkY99aHQbc@vostro.rjw.lan> <530413F0.4050008@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:56620 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754089AbaBSQiC convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 19 Feb 2014 11:38:02 -0500
In-Reply-To: <530413F0.4050008@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Hanjun Guo <hanjun.guo@linaro.org>
Cc: Lan Tianyu <tianyu.lan@intel.com>, Joe Perches <joe@perches.com>, linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, patches@linaro.org, linux-kernel@vger.kernel.org, linaro-acpi@lists.linaro.org, Graeme Gregory <graeme.gregory@linaro.org>

On Wednesday, February 19, 2014 10:16:16 AM Hanjun Guo wrote:
> On 2014=E5=B9=B402=E6=9C=8819=E6=97=A5 08:50, Rafael J. Wysocki wrote=
:
> > On Wednesday, February 19, 2014 12:23:55 AM Hanjun Guo wrote:
> >> _PDC related stuff in processor_core.c is little bit X86/IA64 depe=
ndent,
> >> rework the code to make it more arch-independent, no functional ch=
ange
> >> in this patch.
> >>
> >> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
> >> Signed-off-by: Graeme Gregory <graeme.gregory@linaro.org>
> > I've queued up patches [1,3-5/5] from this series for 3.15 (modulo =
changelog
> > modifications), but this one should be CCed to the x86 and ia64 mai=
ntainers.
>=20
> Thanks! I will resend this patch with Tony and Thomas in cc list, so =
is=20
> there any chance for this
> patch to be merged into 3.15 if I get acked from them?

If they ack it, then yes, it can.

Thanks!

--=20
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
