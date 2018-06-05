From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v2 3/3] arm64: disable ACPI PPTT support temporarily
Date: Tue, 5 Jun 2018 17:02:19 +0200
Message-ID: <CAJZ5v0hn+sya29bZJzksDEDt2QPZDY36Hwn=ckw3ikTGp7T1Zw@mail.gmail.com>
References: <1528209304-3280-1-git-send-email-sudeep.holla@arm.com> <1528209304-3280-3-git-send-email-sudeep.holla@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1528209304-3280-3-git-send-email-sudeep.holla@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Catalin Marinas <catalin.marinas@arm.com>, Jeremy Linton <jeremy.linton@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Hanjun Guo <hanjun.guo@linaro.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Will Deacon <will.deacon@arm.com>
List-Id: linux-acpi@vger.kernel.org

On Tue, Jun 5, 2018 at 4:35 PM, Sudeep Holla <sudeep.holla@arm.com> wrote:
> Currently, ARM64 doesn't support updating the CPU topology masks on
> CPU hotplug operations. ACPI PPTT support rely on that missing feature
> which is technically not incorrect. Instead of reverting all the PPTT
> support, let's keep it simple and disable ACPI PPTT support on ARM64
> for time-being until the topology updates are added for CPU hotplug
> operations.

When is that going to happen?

Nobody else uses PPTT now.
