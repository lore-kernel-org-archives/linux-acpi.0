From: Timur Tabi <timur@codeaurora.org>
Subject: Re: [Linaro-acpi] [PATCH v7 04/17] ARM64 / ACPI: Introduce
 early_param for "acpi" and pass acpi=force to enable ACPI
Date: Wed, 28 Jan 2015 11:58:54 -0600
Message-ID: <CAOZdJXU2bFR1T4ZnGavvnrUXAp5e=vNt9g6WKX46H8qs1wz-TQ@mail.gmail.com>
References: <1421247905-3749-1-git-send-email-hanjun.guo@linaro.org>
 <1421247905-3749-5-git-send-email-hanjun.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1421247905-3749-5-git-send-email-hanjun.guo@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Hanjun Guo <hanjun.guo@linaro.org>
Cc: Mark Rutland <mark.rutland@arm.com>, linaro-acpi@lists.linaro.org, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, wangyijing@huawei.com, Rob Herring <robh@kernel.org>, Timur Tabi <timur@codeaurora.org>, linux-acpi@vger.kernel.org, Grant Likely <grant.likely@linaro.org>, phoenix.liyi@huawei.com, Robert Richter <rric@kernel.org>, Jason Cooper <jason@lakedaemon.net>, Arnd Bergmann <arnd@arndb.de>, Marc Zyngier <marc.zyngier@arm.com>, Jon Masters <jcm@redhat.com>, Mark Brown <broonie@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Randy Dunlap <rdunlap@infradead.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, lkml <linux-kernel@vger.kernel.org>, Olof Johansson <olof@lixom.net>
List-Id: linux-acpi@vger.kernel.org

On Wed, Jan 14, 2015 at 9:04 AM, Hanjun Guo <hanjun.guo@linaro.org> wrote:
> From: Al Stone <al.stone@linaro.org>
>
> Introduce one early parameters "off" and "force" for "acpi", acpi=off
> will be the default behavior for ARM64, so introduce acpi=force to
> enable ACPI on ARM64.
>
> Disable ACPI before early parameters parsed, and enable it to pass
> "acpi=force" if people want use ACPI on ARM64. This ensures DT be
> the prefer one if ACPI table and DT both are provided at this moment.

What is the reason to assume that DT is preferred over ACPI?  I would
have thought that if ACPI is present, then it means we're on an ARM64
server platform, and therefore it should be used.  It seems silly to
require acpi=force on every ARM64 server platform.

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project.
