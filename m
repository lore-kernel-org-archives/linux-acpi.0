From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 0/6] ACPI / properties: Hierarchical properties support
Date: Fri, 28 Aug 2015 03:34:46 +0200
Message-ID: <CAJZ5v0gijfzF0uzqFrRzspkPqkh=hzEA-J-NutswXdE4k5ZVdg@mail.gmail.com>
References: <1596179.pGEt0Ullqu@vostro.rjw.lan>
	<20150828001048.GA10729@cumulusnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <20150828001048.GA10729@cumulusnetworks.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Dustin Byford <dustin@cumulusnetworks.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Darren Hart <darren.hart@intel.com>, Grant Likely <grant.likely@linaro.org>, Arnd Bergmann <arnd.bergmann@linaro.org>, David Woodhouse <dwmw2@infradead.org>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, linux-gpio@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Hi,

On Fri, Aug 28, 2015 at 2:10 AM, Dustin Byford
<dustin@cumulusnetworks.com> wrote:
> On Thu Aug 27 04:34, Rafael J. Wysocki wrote:
>
> Hi Rafael,
>
>> The issue at hand is that we need to be able to support hierarchical device
>> properties in ACPI, like when the set of properties of an entity called "Fred"
>> may include a subset called "dog" containing the properties of the Fred's dog
>> rather than those of Fred himself.  And it may make sense to have the same
>> property, like "hair color", for both Fred and the dog, but with different
>> values.
>
> OK.  I have a couple of questions.
>
>> We (I, Darren and Dave at least) have explored many possible ways to deal with
>> that in ACPI, but the majority of them turned out to be unattractive for various
>> reasons.  Our first take was to use ACPI device objects to make the "child"
>> property sets available via _DSD, but that approach is generally incompatible
>> with the PnP Manager in Windows following the notion that all device objects
>> in ACPI tables are supposed to represent real devices.  It can still be made
>> work by adding _STA that returns 0 to those "property-only" device objects,
>> but that leads to complications in other places and is error prone (if the _STA
>> is forgotten, for example).  Moreover, it adds quite a bit of overhead even in
>> Linux (an ACPICA representation, struct acpi_device, driver core mechanics etc)
>> for things that are only supposed to represent sets of device properties.  And,
>> in addition to that, we'd need to figure out how to give those things arbitrary
>> names in a consistent way.  All of that caused us to drop the approach based on
>> device objects and look for other options.
>
> What's the overhead/effect on Windows for an ACPI object without a _HID (_ADR
> only)?  That seems like a case where the OS shouldn't be expecting to load
> another driver for the ACPI object and the _ADR gives each node a unique name
> (even if it is an unfriendly integer)

I'm not sure about the driver thing in Windows in the case of _ADR
devices to be honest.  That said, by the spec you're only supposed to
use _ADR with things listed in Table 6-168 (page 278) as of ACPI 6.
So that already is a stretch to use _ADR for something not listed
there.

The fact that this is an integer rather than a name is slightly
problematic too, because it does not fit into some use cases we
already have drivers for.  In some cases the "child" entities are
referred to by names, because things have been developed with DT in
mind.  We generally would like to avoid having to provide a separate
ACPI code path at least in some of those cases if possible.

As for the overhead, if something is a device object, it already has a
scope associated with it in the ACPI namespace which adds complexity.
Further, we create a struct acpi_device for it, which is based on
struct device and registered with the driver core etc.  All of those
things are not small objects so they take up quite a bit of memory.
Not to mention sysfs interfaces created for them and so on.  They also
are taken into account by things like acpi_walk_namespace() and
generally cause those operations to be slightly slower.  The are taken
into account by the system suspend/resume code too.

>> The idea is that _DSD may return a package containing the properties of the
>> device it belongs to along with a directory of objects that need to be evaluated
>> in order to obtain the "child" property sets of it.  That directory needs to be
>> present in a separate section of the _DSD package (after the new UUID defined in
>> the above document) and is a list of two-element sub-packages (entries) where
>> the first element is the name of the entry (the name of the "child" property set
>> represented by it) and the second element is a "pointer" (essentially, a path
>> or "namestring" in the ACPI terminology) to the control method or a static
>> data package that needs to be evaluated to obtain the entry's data.  The data
>> returned by it is then interpreted in the same way as a _DSD return package,
>> so it may also contain properties and a directory of its own "child" property
>> sets.
>
> Do you expect there to be cases where using an ACPI device object is more
> desirable than hierarchical properties?  Or is it just impossible given the PNP
> manager in Windows?
>
> The best example I can think of is perhaps a multi function device where each
> sub-function really does look like a separate device and you probably want to
> reference that sub-device, as a device, in other ASL code.

In those cases you may need to use device objects, but you can still
do that just fine.  It is just more heavy-weight and may be
problematic for other OSes at least in principle, so by doing that you
may end up with Linux-specific firmware.

The new mechanism introduced here is for the situations in which you
don't have to do that and by using it you can avoid having to worry
about things like the Windows PnP manager entirely.

> Stating the above more generally, by taking this approach you loose the ability
> to reference these child nodes as a device object.  In this LED example, I
> think it would be nice to set the "trigger" for the led by adding a reference
> to the LED from another device (such as a NIC).
>
> Device (NIC0)
> {
>     ...
>     Name (_DSD, Package () {
>         ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
>         Package () {
>             Package () {"activity-led", LEDS.LEDM },
>             Package () {"link-led", LEDS.LEDH },
>         },
>     }
> }
>
> I'm not sure that's even supported in devicetree or LEDs are the best example
> of this, but the pattern seems generally useful.

I don't see why you can't do that (except that the paths need to be
represented as strings and they are relative to the current scope by
default, so here they need to be absolute or use the "one level up"
operator).

> Without a device you're also forced to use a "label" property instead of a _STR.

Well, you are.

Why exactly does that matter?

>> As an example, consider the following ASL from an experimental MinnowBoard
>> firmware:
>>
>>         Device (LEDS)
>>         {
>>             Name (_HID, "PRP0001")
>>
>>             Name (_CRS, ResourceTemplate () {
>>                 GpioIo (Exclusive, PullDown, 0, 0, IoRestrictionOutputOnly,
>>                         "\\_SB.PCI0.LPC", 0, ResourceConsumer) {10}
>>                 GpioIo (Exclusive, PullDown, 0, 0, IoRestrictionOutputOnly,
>>                         "\\_SB.PCI0.LPC", 0, ResourceConsumer) {11}
>>             })
>>
>>             Name (_DSD, Package () {
>>                 ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
>>                 Package () {
>>                     Package () {"compatible", Package () {"gpio-leds"}},
>>                 },
>>                 // Data extension
>>                 ToUUID("dbb8e3e6-5886-4ba6-8795-1319f52a966b"),
>>                 Package () {
>>                     Package () {"heartbeat", "LEDH"},
>>                     Package () {"mmc-activity", "LEDM"},
>
> I guess LEDH and LEDM have to be strings here.

Yes, they have to be strings.

We attempted to use references for that, but those are replaced with
the target objects in some cases when the package is being created.

> It would be nice if the compiler could verify the path resolves.

That only is possible at run time when the namespace has been created
(think about stuff coming from different SSDTs, for example).

> I suppose it's more incentive to keep these in the same scope.

That is recommended even. :-)

>>            Name (LEDH, Package () {
>>                ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
>>                Package () {
>>                    Package () {"label", "Heartbeat"},
>>                    Package () {"gpios", Package () {^LEDS, 0, 0, 0}},
>>                    Package () {"linux,default-trigger", "heartbeat"},
>>                    Package () {"linux,default-state", "off"},
>>                    Package () {"linux,retain-state-suspended", 1},
>>                }
>>            })
>>
>>            Name (LEDM, Package () {
>>                ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
>>                Package () {
>>                    Package () {"label", Package () {"MMC0 Activity"}},
>>                    Package () {"gpios", Package () {^LEDS, 1, 0, 0}},
>>                    Package () {"linux,default-trigger", Package () {"mmc0"}},
>>                    Package () {"linux,default-state", "off"},
>>                    Package () {"linux,retain-state-suspended", 1},
>>                }
>>            })
>>        }
>
> I suspect you've thought of all of this.  Thanks in advance for any explanations.

No problem at all.  Please let me know if the above is sufficient.

Thanks,
Rafael
