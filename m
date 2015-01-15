From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [Linaro-acpi] [RFC] ACPI on arm64 TODO List
Date: Thu, 15 Jan 2015 18:15:46 +0100
Message-ID: <1565137.I9MJ5FjqHu@wuerfel>
References: <548F9668.6080900@linaro.org> <54B5B7B9.6090101@redhat.com> <54B73D11.2020905@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.131]:56149 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753203AbbAORPy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 15 Jan 2015 12:15:54 -0500
In-Reply-To: <54B73D11.2020905@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linaro-acpi@lists.linaro.org
Cc: Hanjun Guo <hanjun.guo@linaro.org>, Al Stone <ahs3@redhat.com>, Grant Likely <grant.likely@linaro.org>, Catalin Marinas <Catalin.Marinas@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, ACPI Devel Mailing List <linux-acpi@vger.kernel.org>, Olof Johansson <olof@lixom.net>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Thursday 15 January 2015 12:07:45 Hanjun Guo wrote:
> On 2015=E5=B9=B401=E6=9C=8814=E6=97=A5 08:26, Al Stone wrote:
> > On 01/13/2015 10:22 AM, Grant Likely wrote:
> >> On Mon, Jan 12, 2015 at 7:40 PM, Arnd Bergmann <arnd@arndb.de> wro=
te:
> >>> On Monday 12 January 2015 12:00:31 Grant Likely wrote:
> >>>> I've trimmed the specific examples here because I think that mis=
ses
> >>>> the point. The point is that regardless of interface (either ACP=
I or
> >>>> DT) there are always going to be cases where the data needs to c=
hange
> >>>> at runtime. Not all platforms will need to change the CPU data, =
but
> >>>> some will (say for a machine that detects a failed CPU and remov=
es
> >>>> it). Some PCI add-in boards will carry along with them additiona=
l data
> >>>> that needs to be inserted into the ACPI namespace or DT. Some
> >>>> platforms will have system level component (ie. non-PCI) that ma=
y not
> >>>> always be accessible.
> >>>
> >>> Just to be sure I get this right: do you mean runtime or boot-tim=
e
> >>> (re-)configuration for those?
> >>
> >> Both are important.

But only one of the is relevant to the debate of what ACPI offers over
DT. By mixing the two, it's no longer clear which of your examples
are the ones that matter for runtime hotplugging.

> >>>> ACPI has an interface baked in already for tying data changes to
> >>>> events. DT currently needs platform specific support (which we c=
an
> >>>> improve on). I'm not even trying to argue for ACPI over DT in th=
is
> >>>> section, but I included it this document because it is one of th=
e
> >>>> reasons often given for choosing ACPI and I felt it required a m=
ore
> >>>> nuanced discussion.
> >>>
> >>> I can definitely see the need for an architected interface for
> >>> dynamic reconfiguration in cases like this, and I think the ACPI
> >>> model actually does this better than the IBM Power hypervisor
> >>> model, I just didn't see the need on servers as opposed to someth=
ing
> >>> like a laptop docking station to give a more obvious example I kn=
ow
> >>> from x86.
> >
> > I know of at least one server product (non-ARM) that uses the
> > hot-plugging of CPUs and memory as a key feature, using the
> > ACPI OSPM model.  Essentially, the customer buys a system with
> > a number of slots and pays for filling one or more of them up
> > front.  As the need for capacity increases, CPUs and/or RAM gets
> > enabled; i.e., you have spare capacity that you buy as you need
> > it.  If you use up all the CPUs and RAM you have, you buy more
> > cards, fill the additional slots, and turn on what you need.  This
> > is very akin to the virtual machine model, but done with real hardw=
are
> > instead.

Yes, this is a good example, normally called Capacity-on-Demand (CoD),
and is a feature typically found in enterprise servers, but not in
commodity x86 machines. It would be helpful to hear from someone who
actually plans to do this on ARM, but I get the idea.

> There is another important user case for RAS, systems running critica=
l
> missions such as bank billing system, system like that need high
> reliability that the machine can't be stopped.
>=20
> So when error happened on hardware including CPU/memory DIMM on such
> machines, we need to replace them at run-time.
>
> > Whether or not this product is still being sold, I do not know.  I
> > have not worked for that company for eight years, and they were jus=
t
> > coming out as I left.  Regardless, this sort of hot-plug does make
> > sense in the server world, and has been used in shipping products.
>=20
> I think it still will be, Linux developers put lots of effort to
> enable memory hotplug and computer node hotplug in the kernel [1], an=
d
> the code already merged into mainline.
>=20
> [1]:
> http://events.linuxfoundation.org/sites/events/files/lcjp13_chen.pdf

The case of memory hotremove is interesting as well, but it has some
very significant limitations, regarding system integrity after
uncorrectable memory errors as well as nonmovable pages.  The cases
I know either only support hot-add for CoD (see above), or they support
hot-replace for mirrored memory only, but that does not require any
interaction with the OS.

Thanks for the examples!

	Arnd
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
