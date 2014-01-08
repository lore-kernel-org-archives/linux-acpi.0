From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH V2 1/6] Documentation: add dts binding for X-Gene reboot
 dts node.
Date: Wed, 08 Jan 2014 11:08:33 +0100
Message-ID: <6073715.cGydpIHKD1@wuerfel>
References: <1389135041-16062-1-git-send-email-fkan@apm.com>
 <1389135041-16062-2-git-send-email-fkan@apm.com>
 <20140108100549.GE6701@e106331-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20140108100549.GE6701@e106331-lin.cambridge.arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org
Cc: Mark Rutland <mark.rutland@arm.com>, Feng Kan <fkan@apm.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Wednesday 08 January 2014 10:05:50 Mark Rutland wrote:
> > +
> > +Example:
> > +
> > +     reboot@0 {
> > +             compatible = "apm,xgene-reboot";
> > +             reg = <0x0 0x17000014 0x0 0x4>;
> > +     };
> 
> Given this seems to be a 64-bit address, the unit address should
> preferably be 0,17000014 rather than just 0.

I also wonder about the size and location of the register.
Are you sure the device is just a single 4-byte register at offset
0x14, rather than a complex device that happens to contain the
reset register?

	Arnd
