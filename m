From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v7 0/3] acpi: apei: Drop panic() on fatal errors policy
Date: Sun, 27 May 2018 11:36:49 +0200
Message-ID: <CAJZ5v0g_wQ0zhjbohQaU1GNxpri_Nkm=bOXyMQ8zi8dOGTxmYA@mail.gmail.com>
References: <20180525155352.22350-1-mr.nuke.me@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180525155352.22350-1-mr.nuke.me@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Alexandru Gagniuc <mr.nuke.me@gmail.com>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, alex_gagniuc@dellteam.com, austin_bolen@dell.com, shyam_iyer@dell.com, Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, the arch/x86 maintainers <x86@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Mauro Carvalho Chehab <mchehab@kernel.org>, Robert Moore <robert.moore@intel.com>, Erik Schmauss <erik.schmauss@intel.com>, Tyler Baicar <tbaicar@codeaurora.org>, Will Deacon <will.deacon@arm.com>, James Morse <james.morse@arm.com>, "Jonathan (Zhixiong) Zhang" <zjzhang@codeaurora.org>, Dongjiu Geng <gengdongjiu@huawei.com>, open list:EDAC-CO
List-Id: linux-acpi@vger.kernel.org

On Fri, May 25, 2018 at 5:53 PM, Alexandru Gagniuc <mr.nuke.me@gmail.com> wrote:
> FFS (firmware-first) handling through APEI seems to have developed a
> policy to panic() on any fatal errors. This policy is completely
> independent of the non-FFS case. It is also inconsistent with how the
> native error handlers, a number of which will recover the system from
> fatal errors.
>
> The purpose of this series is to obsolete this idiotic policy, with
> the motivation to enable identical handling of PCIe errors to native
> reporting.
>
>
> Rafael, this is copypaste from the previous patch series. I suspect
> you might have missed it last time, because you asked questions which
> were answered here. I've included it so you don't have to go digging
> old emails:

I didn't miss it, but I didn't like your answers.

Anyway, as a rule, no GHES/APEI patches are applied without an ACK
from either Boris or Tony, so you need to talk to them about the
patches.

Thanks,
Rafael
