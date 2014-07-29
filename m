From: Christoffer Dall <christoffer.dall@linaro.org>
Subject: Re: [PATCH 19/19] Documentation: ACPI for ARM64
Date: Tue, 29 Jul 2014 17:01:28 +0200
Message-ID: <CAMJs5B-WKQ2DjWsSzMYNUHanp9jQvzArVvizwZSsO6ScjCpSvQ@mail.gmail.com>
References: <1406206825-15590-1-git-send-email-hanjun.guo@linaro.org>
 <20140729130823.GP2576@leverpostej>
 <CAMJs5B8uk7GDfEOEuY8RWDxzhzTRBGszRDN+JRKwG-D_rgzFrw@mail.gmail.com>
 <2361920.ZXE2KPy98s@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <2361920.ZXE2KPy98s@wuerfel>
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

On 29 July 2014 16:41, Arnd Bergmann <arnd@arndb.de> wrote:
> On Tuesday 29 July 2014 15:31:16 Christoffer Dall wrote:
>> On 29 July 2014 15:08, Mark Rutland <mark.rutland@arm.com> wrote:
>> > On Tue, Jul 29, 2014 at 01:52:40PM +0100, Arnd Bergmann wrote:
>> >> On Tuesday 29 July 2014 14:37:38 Christoffer Dall wrote:
>> >> >
>> >> > For reference, Red Hat's current arguing point for ACPI in VMs is
>> >> > hotplug of things like CPUs and memory for very large VMs, but I
>> >> > haven't thought too carefully about this just yet, as I don't have a
>> >> > 100+ core ARM 64-bit hardware lying around...
>> >>
>> >> I thought you could run guests with more virtual CPUs that you have
>> >> physical CPUs on the host.
>> >>
>> >> Regarding CPU and memory hotplug, don't we already have PSCI and
>> >> xen-balloon/virtio-balloon for that?
>> >
>> > PSCI (0.1) was there for guests from the start, and ACPI doesn't do
>> > anything different w.r.t. PSCI other than requiring PSCI 0.2 (which can
>> > be used by guests supporting only PSCI 0.1). So there's no magic for
>> > CPU hotplug provided by ACPI.
>>
>> With PSCI you can only provide your VM a bunch of CPUs and say that
>> they're all turned off, and then turn some of them on later.  I
>> honestly don't know if you can do proper CPU hotplug with ACPI, but
>> the RH guys seem to argue that you can.  Again, I didn't think too
>> carefully about this.
>
> Xen does this in drivers/xen/cpu_hotplug.c, acpi does it in
> drivers/acpi/acpi_processor.c.
>
>> > Do either of the balloon drivers allow for memory to be hot-added to a
>> > system initially provisioned with less?
>> >
>> No, it's just about reclaiming memory.  Same argument as above.
>
> Again, Xen seems to be able to add more memory:
>
> config XEN_BALLOON_MEMORY_HOTPLUG
>         bool "Memory hotplug support for Xen balloon driver"
>         default n
>         depends on XEN_BALLOON && MEMORY_HOTPLUG
>         help
>           Memory hotplug support for Xen balloon driver allows expanding memory
>           available for the system above limit declared at system startup.
>           It is very useful on critical systems which require long
>           run without rebooting.
>           ...
>
> The same goes for hyperv, s390 and vmware. It should not be hard to add it
> for KVM.
>
Absolutely, and I would prefer doing that over adding ACPI in guests
as things stand right now.  We can have another fun discussion about
this at LCU...

-Christoffer
