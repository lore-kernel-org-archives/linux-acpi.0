From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH v9 6/7] arm64: add support for ACPI Low Power Idle(LPI)
Date: Tue, 12 Jul 2016 16:22:55 +0100
Message-ID: <20160712152255.GF22183@e104818-lin.cambridge.arm.com>
References: <1467997678-7107-1-git-send-email-sudeep.holla@arm.com>
 <1467997678-7107-7-git-send-email-sudeep.holla@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1467997678-7107-7-git-send-email-sudeep.holla@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: ACPI List <linux-acpi@vger.kernel.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Mark Rutland <mark.rutland@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Prashanth Prakash <pprakash@codeaurora.org>, Al Stone <al.stone@linaro.org>, Vikas Sajjan <vikas.cha.sajjan@hpe.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Will Deacon <will.deacon@arm.com>, LKML <linux-kernel@vger.kernel.org>, Ashwin Chaugule <ashwin.chaugule@linaro.org>, ALKML <linux-arm-kernel@lists.infradead.org>, Sunil <sunil.vl@hpe.com>
List-Id: linux-acpi@vger.kernel.org

On Fri, Jul 08, 2016 at 06:07:57PM +0100, Sudeep Holla wrote:
> This patch adds appropriate callbacks to support ACPI Low Power Idle
> (LPI) on ARM64.
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Acked-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>

(in case Rafael needs it)
