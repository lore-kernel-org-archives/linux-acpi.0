From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: Re: [PATCH v5 2/5] ACPI / processor_core: Rework _PDC related stuff
 to make it more arch-independent
Date: Wed, 19 Feb 2014 10:16:16 +0800
Message-ID: <530413F0.4050008@linaro.org>
References: <1392740638-2479-1-git-send-email-hanjun.guo@linaro.org> <1392740638-2479-3-git-send-email-hanjun.guo@linaro.org> <3459962.GkY99aHQbc@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <3459962.GkY99aHQbc@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Lan Tianyu <tianyu.lan@intel.com>, Joe Perches <joe@perches.com>, linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, patches@linaro.org, linux-kernel@vger.kernel.org, linaro-acpi@lists.linaro.org, Graeme Gregory <graeme.gregory@linaro.org>
List-Id: linux-acpi@vger.kernel.org

On 2014=E5=B9=B402=E6=9C=8819=E6=97=A5 08:50, Rafael J. Wysocki wrote:
> On Wednesday, February 19, 2014 12:23:55 AM Hanjun Guo wrote:
>> _PDC related stuff in processor_core.c is little bit X86/IA64 depend=
ent,
>> rework the code to make it more arch-independent, no functional chan=
ge
>> in this patch.
>>
>> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
>> Signed-off-by: Graeme Gregory <graeme.gregory@linaro.org>
> I've queued up patches [1,3-5/5] from this series for 3.15 (modulo ch=
angelog
> modifications), but this one should be CCed to the x86 and ia64 maint=
ainers.

Thanks! I will resend this patch with Tony and Thomas in cc list, so is=
=20
there any chance for this
patch to be merged into 3.15 if I get acked from them?

Best regards
Hanjun
