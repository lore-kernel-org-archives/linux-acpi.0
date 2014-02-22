From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH v5 2/5] ACPI / processor_core: Rework _PDC related stuff
 to make it more arch-independent
Date: Sat, 22 Feb 2014 10:33:25 +0000
Message-ID: <F980FA86-6705-4A71-956C-EA2DBD787199@arm.com>
References: <1392740638-2479-1-git-send-email-hanjun.guo@linaro.org>
 <3459962.GkY99aHQbc@vostro.rjw.lan> <20140221182424.GA5751@arm.com>
 <1408521.4TEdKhuRp5@vostro.rjw.lan>
Mime-Version: 1.0 (Mac OS X Mail 7.1 \(1827\))
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1408521.4TEdKhuRp5@vostro.rjw.lan>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Lan Tianyu <tianyu.lan@intel.com>, "graeme.gregory@linaro.org" <graeme.gregory@linaro.org>, "linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>, "patches@linaro.org" <patches@linaro.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Hanjun Guo <hanjun.guo@linaro.org>, Joe Perches <joe@perches.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-acpi@vger.kernel.org

On 21 Feb 2014, at 23:35, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> On Friday, February 21, 2014 06:24:24 PM Catalin Marinas wrote:
>> On Wed, Feb 19, 2014 at 01:50:22AM +0100, Rafael J. Wysocki wrote:
>>> On Wednesday, February 19, 2014 12:23:55 AM Hanjun Guo wrote:
>>>> _PDC related stuff in processor_core.c is little bit X86/IA64 dependen=
t,
>>>> rework the code to make it more arch-independent, no functional change
>>>> in this patch.
>>>> =

>>>> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
>>>> Signed-off-by: Graeme Gregory <graeme.gregory@linaro.org>
>>> =

>>> I've queued up patches [1,3-5/5] from this series for 3.15 (modulo chan=
gelog
>>> modifications), but this one should be CCed to the x86 and ia64 maintai=
ners.
>> =

>> Thanks for taking these patches. I would however hold onto patch 3/5 as
>> this is still under discussion. Basically for patches specific to ARM
>> ACPI I would really like to see more acks before being merged as that's
>> a new thing for us.
> =

> OK, I'll drop [3/5] for now, then.

Thanks (it=92s only temporary ;)).

> I'm wondering, though, whose ACKs I should be waiting for before applying=
 those
> patches?

Good question ;). In this particular case, there is an ongoing
discussion between Hanjun and Sudeep. While there isn=92t anything
major, I would like to see some agreement and potentially an Ack from
the other party involved in the discussion (Sudeep).

There are other patches that are not specific to ARM, so it=92s
really your decision. As for the general ARM(64) ACPI case, I don=92t
think we have anyone in charge with deciding what=92s correct or not
(BTW, who are the people active both in the _ARM_ Linux kernel community
and the ACPI standardisation forum?).

In the mean-time, I would like to see at least an ack from the arm-soc
team (Arnd and Olof) or them collecting those ARM-specific patches and
sending pull request to you. My biggest worry is how the ACPI standard
is interpreted by vendors and how (non-standard) features get into the =

Linux kernel.

Anyway, I=92ll meet the Linaro guys in a week time and we=92ll agree on
a way forward.

Thanks,

Catalin
