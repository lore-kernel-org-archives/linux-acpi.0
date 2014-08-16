From: Graeme Gregory <gg@slimlogic.co.uk>
Subject: Re: [PATCH 19/19] Documentation: ACPI for ARM64
Date: Sat, 16 Aug 2014 13:45:33 +0100
Message-ID: <20140816124532.GA25975@xora-haswell.xora.org.uk>
References: <1406206825-15590-1-git-send-email-hanjun.guo@linaro.org>
 <1406206825-15590-20-git-send-email-hanjun.guo@linaro.org>
 <CAJvTdKnTLtozLZnAJcgZODV9-D77u3=hK3d7z-5XCZZTFwhqOg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <CAJvTdKnTLtozLZnAJcgZODV9-D77u3=hK3d7z-5XCZZTFwhqOg@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Len Brown <lenb@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, Mark Brown <broonie@linaro.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Lv Zheng <lv.zheng@intel.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Robert Moore <robert.moore@intel.com>, linux acpi <linux-acpi@vger.kernel.org>, Grant Likely <grant.likely@linaro.org>, Charles.Garcia-Tobin@arm.com, Robert Richter <rric@kernel.org>, Jason Cooper <jason@lakedaemon.net>, Arnd Bergmann <arnd@arndb.de>, Marc Zyngier <marc.zyngier@arm.com>, Liviu Dudau <Liviu.Dudau@arm.com>, linaro-acpi-private@linaro.org, Bjorn Helgaas <bhelgaas@google.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Graeme Gregory <graeme.gregory@linaro.org>, Randy Dunlap <rdunlap@infradead.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger
List-Id: linux-acpi@vger.kernel.org

On Fri, Aug 15, 2014 at 06:43:10PM -0400, Len Brown wrote:
> > Additional driver specific
> > +data should be passed in the appropriate _DSM (ACPI Section 9.14.1) method or
> > +_DSD (ACPI Section 6.2.5).
> 
> Re: _DSD
> 
> Yes.
> 
> Re: _DSM
> 
> No, not if it can be handled by _DSD.
> 
> cheers,
> Len Brown, Intel Open Source Technology Center

Thanks good point, Ill update that paragraph to indicate preference on
_DSD.

Graeme
