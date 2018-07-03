From: Ian Campbell <ijc@debian.org>
Subject: Re: [RFC/RFT PATCH 0/2] disable_hest quirk on HP m400 with bad UEFI
 firmwware
Date: Tue, 03 Jul 2018 18:16:12 +0100
Message-ID: <1530638172.31922.25.camel@debian.org>
References: <20180628100656.10692-1-james.morse@arm.com>
 <CAKv+Gu9ZHAGzcfgHShM1qvZ3qf4gb1pD_XfoceJu9Qy+5_pEsg@mail.gmail.com>
 <1530607466.9841.124.camel@debian.org>
 <CAKv+Gu8VYZ1dCggPjakcvqOxfUCeCAABEADmF2Bm-q3=y3J4ng@mail.gmail.com>
 <1530632871.9841.139.camel@debian.org> <20180703171251.GC11614@red-moon>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180703171251.GC11614@red-moon>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>, Geoff Levand <geoff@infradead.org>, Riku Voipio <riku.voipio@linaro.org>, Mark Salter <msalter@redhat.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, James Morse <james.morse@arm.com>, Hanjun Guo <hanjun.guo@linaro.org>, Sudeep Holla <sudeep.holla@arm.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-Id: linux-acpi@vger.kernel.org

On Tue, 2018-07-03 at 18:12 +0100, Lorenzo Pieralisi wrote:
> I do not think anybody is preventing that, it is just that we do not
> see the reason for adding a DMI quirk to the mainline kernel to enable
> a platform with broken firmware that cripples one of the main feature
> it is supposed to implement, we can go on forever about this but that's
> the gist.

The quirk turns off a broken feature on the platform where it is
broken, not everywhere, there's no "crippling" of the feature.

Or are you suggesting that you have in mind a way to fix this which
makes HEST work even on m400 and renders the quirk unnecessary?

Ian.
