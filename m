From: Christoffer Dall <christoffer.dall@linaro.org>
Subject: Re: [PATCH 19/19] Documentation: ACPI for ARM64
Date: Tue, 29 Jul 2014 15:33:10 +0200
Message-ID: <CAMJs5B9NePv=txgYY8mdMtiCO_LXVg6s6=OY3w-YBkOJpHSROw@mail.gmail.com>
References: <1406206825-15590-1-git-send-email-hanjun.guo@linaro.org>
 <20140729112824.GM2576@leverpostej>
 <CAMJs5B_Ye1eXsvJAKWnHRxC4jnpcXMcqHE+GgOGO7MHtPcsSQA@mail.gmail.com>
 <351673188.FxXsM7MvdA@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <351673188.FxXsM7MvdA@wuerfel>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Mark Rutland <mark.rutland@arm.com>, Mark Brown <broonie@linaro.org>, Catalin Marinas <Catalin.Marinas@arm.com>, Will Deacon <Will.Deacon@arm.com>, Lv Zheng <lv.zheng@intel.com>, "rob.herring@linaro.org" <rob.herring@linaro.org>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Robert Moore <robert.moore@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "grant.likely@linaro.org" <grant.likely@linaro.org>, Charles Garcia-Tobin <Charles.Garcia-Tobin@arm.com>, Robert Richter <rric@kernel.org>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <Marc.Zyngier@arm.com>, Liviu Dudau <Liviu.Dudau@arm.com>, Bjorn Helgaas <bhelgaas@google.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "graeme.gregory@linaro.org" <graeme.gregory@linaro.org>, Randy Dunlap <rdunlap@infradead.org>R
List-Id: linux-acpi@vger.kernel.org

On 29 July 2014 14:52, Arnd Bergmann <arnd@arndb.de> wrote:
> On Tuesday 29 July 2014 14:37:38 Christoffer Dall wrote:
>>
>> For reference, Red Hat's current arguing point for ACPI in VMs is
>> hotplug of things like CPUs and memory for very large VMs, but I
>> haven't thought too carefully about this just yet, as I don't have a
>> 100+ core ARM 64-bit hardware lying around...
>
> I thought you could run guests with more virtual CPUs that you have
> physical CPUs on the host.
>

you can, my sentence was meant to be a bit tongue-in-cheek, running
100 VCPUs on the Foundation Model (which is the only thing I have on
my desk as of now) is not very useful, so I just don't care at this
point.  Let me see or give me access to something with at least 8
physical cores before I start caring (with my community hat on, as a
Linaro employee I may be told to care).

> Regarding CPU and memory hotplug, don't we already have PSCI and
> xen-balloon/virtio-balloon for that?
>
Virtio-balloon don't do anything for you wrt. CPUs, wrt. memory you
have to provision it beforehand.

-Christoffer
