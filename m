From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [Linaro-acpi] [PATCH v7 04/17] ARM64 / ACPI: Introduce
 early_param for "acpi" and pass acpi=force to enable ACPI
Date: Wed, 28 Jan 2015 18:08:16 +0000
Message-ID: <20150128180816.GF31752@e104818-lin.cambridge.arm.com>
References: <1421247905-3749-1-git-send-email-hanjun.guo@linaro.org>
 <1421247905-3749-5-git-send-email-hanjun.guo@linaro.org>
 <CAOZdJXU2bFR1T4ZnGavvnrUXAp5e=vNt9g6WKX46H8qs1wz-TQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <CAOZdJXU2bFR1T4ZnGavvnrUXAp5e=vNt9g6WKX46H8qs1wz-TQ@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Timur Tabi <timur@codeaurora.org>
Cc: Mark Rutland <Mark.Rutland@arm.com>, Rob Herring <robh@kernel.org>, "phoenix.liyi@huawei.com" <phoenix.liyi@huawei.com>, Robert Richter <rric@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, "linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>, Marc Zyngier <Marc.Zyngier@arm.com>, Will Deacon <Will.Deacon@arm.com>, Randy Dunlap <rdunlap@infradead.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, lkml <linux-kernel@vger.kernel.org>, "grant.likely@linaro.org" <grant.likely@linaro.org>, "wangyijing@huawei.com" <wangyijing@huawei.com>, Mark Brown <broonie@kernel.org>, "hanjun.guo@linaro.org" <hanjun.guo@linaro.org>, "jcm@redhat.com" <jcm@redhat.com>, Olof Johansson <olof@lixom.net>, Bjorn Helgaas <bhelgaas@google.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Jason Cooper <ja>
List-Id: linux-acpi@vger.kernel.org

On Wed, Jan 28, 2015 at 05:58:54PM +0000, Timur Tabi wrote:
> On Wed, Jan 14, 2015 at 9:04 AM, Hanjun Guo <hanjun.guo@linaro.org> wrote:
> > From: Al Stone <al.stone@linaro.org>
> >
> > Introduce one early parameters "off" and "force" for "acpi", acpi=off
> > will be the default behavior for ARM64, so introduce acpi=force to
> > enable ACPI on ARM64.
> >
> > Disable ACPI before early parameters parsed, and enable it to pass
> > "acpi=force" if people want use ACPI on ARM64. This ensures DT be
> > the prefer one if ACPI table and DT both are provided at this moment.
> 
> What is the reason to assume that DT is preferred over ACPI?  I would
> have thought that if ACPI is present, then it means we're on an ARM64
> server platform, and therefore it should be used.  It seems silly to
> require acpi=force on every ARM64 server platform.

I'm against requiring acpi=force when *only* ACPI tables are present (I
don't like a command line argument to become firmware-kernel ABI), but
otherwise DT takes precedence (it was the first supported booting method
on arm64 and currently it is more mature and feature-rich than ACPI on
arm64).

-- 
Catalin
