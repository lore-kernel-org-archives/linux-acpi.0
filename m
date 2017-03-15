From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v4 16/16] ACPI / DSD: Document references, ports and endpoints
Date: Wed, 15 Mar 2017 12:28:36 +0100
Message-ID: <1595427.gxrcIpTbyD@aspire.rjw.lan>
References: <1629581.fh46rNHz4U@aspire.rjw.lan> <20170315082351.GA24531@paasikivi.fi.intel.com> <1773cade-654d-f704-0d4a-44a76699ecab@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:60641 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753781AbdCOLeJ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 15 Mar 2017 07:34:09 -0400
In-Reply-To: <1773cade-654d-f704-0d4a-44a76699ecab@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Sudeep Holla <sudeep.holla@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Mark Rutland <mark.rutland@arm.com>, Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, Al Stone <ahs3@redhat.com>

On Wednesday, March 15, 2017 11:33:35 AM Sakari Ailus wrote:
> On 03/15/17 10:23, Sakari Ailus wrote:
> > On Wed, Mar 15, 2017 at 12:13:45AM +0100, Rafael J. Wysocki wrote:
> >> On Tue, Mar 14, 2017 at 11:53 PM, Sakari Ailus
> >> <sakari.ailus@linux.intel.com> wrote:
> >>> Rafael J. Wysocki wrote:
> >>>>
> >>>> On Tue, Mar 14, 2017 at 10:16 PM, Sakari Ailus
> >>>> <sakari.ailus@linux.intel.com> wrote:
> >>>>>
> >>>>> Rafael J. Wysocki wrote:
> >>>>>>
> >>>>>>
> >>>>>> On Tue, Mar 14, 2017 at 6:54 PM, Sakari Ailus
> >>>>>> <sakari.ailus@linux.intel.com> wrote:
> >>>>>>>
> >>>>>>>
> >>>>>>> Hi Rafael,
> >>>>>>>
> >>>>>>> Rafael J. Wysocki wrote:
> >>>>>>>>
> >>>>>>>>
> >>>>>>>>
> >>>>>>>> On Tue, Mar 14, 2017 at 9:09 AM, Sakari Ailus
> >>>>>>>> <sakari.ailus@linux.intel.com> wrote:
> >>>>>>>>>
> >>>>>>>>>
> >>>>>>>>>
> >>>>>>>>> On 03/14/17 10:08, Sakari Ailus wrote:
> >>>>>>>>>>
> >>>>>>>>>>
> >>>>>>>>>>
> >>>>>>>>>> How about this instead:
> >>>>>>>>>>
> >>>>>>>>>> All port nodes are located under the device's "_DSD" node in the
> >>>>>>>>>> hierarchical data extension tree. The property extension related to
> >>>>>>>>>> each port node must contain the key "port" and an integer value
> >>>>>>>>>> which
> >>>>>>>>>> is the number of the port.
> >>>>>>>>>
> >>>>>>>>>
> >>>>>>>>>
> >>>>>>>>>
> >>>>>>>>> So with matching strings instead of indices, this will change, too...
> >>>>>>>>
> >>>>>>>>
> >>>>>>>>
> >>>>>>>>
> >>>>>>>> It doesn't have to AFAICS, but the number is just redundant IMO.  You
> >>>>>>>> only need a boolean property saying "this is a port", so you know that
> >>>>>>>> you should expect a list of endpoints in that object.
> >>>>>>>
> >>>>>>>
> >>>>>>>
> >>>>>>>
> >>>>>>> No, it's not redundant. It's the number of the physical port in the
> >>>>>>> device
> >>>>>>> --- this is how the driver gets to know where the connection has been
> >>>>>>> made.
> >>>>>>
> >>>>>>
> >>>>>>
> >>>>>> OK, but what exactly do you mean by "physical port"?
> >>>>>
> >>>>>
> >>>>>
> >>>>> The device (or an IP block) has physical interfaces to the world outside.
> >>>>> There could be just one, but there may be more. For an ISP, there could
> >>>>> be
> >>>>> e.g. four CSI-2 receivers to each of which you could connect a camera
> >>>>> sensor. So for an ISP device, that number tells which of the receivers a
> >>>>> given sensor is connected to.
> >>>>>
> >>>>> The mapping between this number and what the hardware datasheet refers to
> >>>>> needs to be documented per device.
> >>>>
> >>>>
> >>>> OK, so the number actually is an arbitrary piece of data associated
> >>>> with the key "port" and the interpretation of that piece of data
> >>>> depends on whoever asks for that value.
> >>>>
> >>>> IOW, the core doesn't care.
> >>>>
> >>>> With all due respect to whoever invented this on the DT side, this is
> >>>> just bad design to me, because it causes the "port" property to serve
> >>>> two different purposes at the same time.  First, it tells the core
> >>>> that this object is a port.  Second, it is expected to provide a piece
> >>>> of data of unspecified interpretation to somebody.  Which means that
> >>>> the "port" property is both general and device-specific at the same
> >>>> time and the sanity of that is quite questionable IMO.
> >>>
> >>>
> >>> DT uses a node called either "port" or "ports" to store the port nodes. The
> >>> reg property tells the number of the port (see
> >>> Documentation/devicetree/bindings/graph.txt). I'm no DT expert, but my
> >>> understanding is that the node namespace is different from the property
> >>> namespace.
> >>
> >> So on the DT side it actually looks OK to me.
> >>
> >> And the <reg> value is referred to as the port-endpoint identifier, so
> >> I guess this is used for referring to the port/endpoint instead of an
> >> index or the key value somewhere?
> > 
> > The remote-endpoint uses phandles; they're a mechanism in DT to refer to
> > different nodes in the tree (DT does not differentiate between devices and
> > non-device nodes). There's a relatively good example here:
> > 
> > 	arch/arm/boot/dts/omap3-n9.dts

Yes, I figured that out. :-)

Still, the <rev> property value is used for something somewhere in the code I gather.

> >>
> >>> If you're concerned of possible double meanings, it's entirely possible to
> >>> put the port nodes under hierarchical data extension named e.g. "ports", and
> >>> document that this is what the node must be called (single port node could
> >>> be just called "port"). This way, it should be much more difficult to
> >>> interpret a non-port node as a port node --- roughly equivalent of the DT
> >>> ports node.
> >>>
> >>> The drawback with this change is that the size of the data structure in ASL
> >>> (and AML) will grow.
> >>
> >> The "ports" thing would only be useful if we had the other properties
> >> to put in there.
> >>
> >> So I guess we can specify that the "port" property value is the
> >> identifier of the port and then we will use this in the
> >> "remote-endpoint" property on the other end instead of an index.
> > 
> > Makes sense.
> > 
> >>
> >> And analogously for the "enpoint" property value.
> > 
> > The endpoint hierarchical data extension node name? There is no endpoint
> > property being used by this version of the set anymore; I removed it as it
> > was redundant. However a human readable endpoint node name can be chosen
> > which that'd be quite practical to identify the endpoint.
> > 
> > Then the remote-endpoint properties would be:
> > 
> > 	Package () { device, port (integer), endpoint-node-name (string) }
> > 
> 
> Oh, well... the device is present there already, so the endpoint
> reference would well use an index pretty much equally well. Most of the
> time it'll be zero anyway. I.e.
> 
> 	Package() { device, port number (integer), endpoint id (integer }

Yes, I would do that, and actually not using the index for the endpoint too.

Let ports and endpoints be symmetrical in that respect, that is a port is
required to have a { "port", id } property and an endpoind is required to
have a { "endpoint", id } property and let the ids be used in
"remote-endpoint" properties as per the above.

Then, in each case, the id would be whatever the value of the <rev> property
on the DT side would be.

> But switching from the port index to the port number is a tangible
> improvement.

Well, to me, using indices should not even be taken into consideration as
a viable approach in similar cases.

I know that using indices is a common practice in the ACPI land, but IMO that's
not a good one.

Thanks,
Rafael

