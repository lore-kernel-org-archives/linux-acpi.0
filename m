From: Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: Re: [RFC 00/15] ACPI graph support
Date: Fri, 7 Oct 2016 00:10:54 +0300
Message-ID: <57F6BDDE.1010904@linux.intel.com>
References: <1475621148-21427-1-git-send-email-sakari.ailus@linux.intel.com>
 <20161005092215.GA20248@red-moon>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:23163 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933299AbcJFVK7 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 6 Oct 2016 17:10:59 -0400
In-Reply-To: <20161005092215.GA20248@red-moon>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: linux-acpi@vger.kernel.org, mika.westerberg@linux.intel.com, rafael@kernel.org, mark.rutland@arm.com, broonie@kernel.org, robh@kernel.org, ahs3@redhat.com

Hi Lorenzo,

On 10/05/16 12:22, Lorenzo Pieralisi wrote:
> [ +MarkR, MarkB, Rob, Al - I suspect they may want to have a say]
>
> On Wed, Oct 05, 2016 at 01:45:33AM +0300, Sakari Ailus wrote:
>> Hello everyone,
>>
>> I've been working awhile with my collegue Mika Westerberg to bring
>> firmware graph support to ACPI based systems. In practice the
>> functionality achieved by these patches is very similar to what the Device
>> tree provides: the port and the endpoint concept are being employed. The
>> patches make use of the _DSD property and data extensions to achieve this.
>> The fwnode interface is extended by graph functionality; this way graph
>> information originating from both OF and ACPI may be accessed using the
>> same interface.
>
> There is an ongoing effort to avoid wholesale import of DT bindings
> into ACPI, I am not a V4L2 expert but it seems to me that with patches
> like the one you have submitted we are getting closer and closer to
> achieving it instead of avoiding it.
>
> For your information, Al is working on a process to submit _DSD
> bindings and this patchset should at least be vetted within that
> context.
>
> It is an RFC and my comment is that I do not like the direction
> this ACPI->_DSD->DT is taking, I would like to understand where
> this is intended to stop because I am getting worried.

Thank you for your feedback.

The ACPI standard defines the syntax for _DSD property and data
extensions but it does not provide a solution for documenting these
properties. In other words, it does provide a mechanism but it does not
tell how and for which specific purposes that mechanism should or may be
used. The _DSD property extension specification strongly discourages the
use of _DSD for purposes that already are within the scope of the ACPI
standard. In this respect, the use of _DSD in this RFC patchset does
conform to the ACPI standard specifications.

That said, I do recognise that --- as we do have a single interface to
access the properties in drivers --- there must be uniform use of these
properties by firmware implementations or there will be problems. This
holds true independently of the firmware implementation, be it Device
tree, ACPI or both.

The Device tree binding documentation is part of the kernel and that's
what the FDT binaries are expected to use, too. The bindings are Linux
specific and, as far as I understand, cannot be expected to be used by
other operating systems even on same hardware.

ACPI should be more generic than that. Already, you can find ACPI BIOS
options for choosing the operating system you're running on. This is
hardly ideal.

AFAIU, the _DSD property database is intended for documenting the 
properties drivers use, and as long as the DT properties in the Linux 
kernel and in the _DSD property database match, a driver should be 
safely able to use those properties independently of the firmware 
implementation.

I do not agree with the proposition of making concepts and
implementation different on ACPI for the sake of it being ACPI. With
_DSD, the ACPI does support the same tree structure of nodes and 
properties as DT; I see no reason why "ACPI native" support for this 
class of constructs could not (or yet, even should not) use the same 
mechanisms as the Device tree does. There's simply no need to reinvent 
the wheel.

The patchset makes use of not only _DSD properties but also the _DSD
data extension. In order for that not to remain Linux specific, the next
logical step would be to extend the scope of the _DSD property database 
to include _DSD data extension in this respect and document the following:

1) how _DSD data extension graph nodes are referenced,

2) port and endpoint concepts and how they are to be used,

3) generic properties defined in
Documentation/devicetree/bindings/media/video-interfaces.txt to the _DSD 
database and

4) driver specific properties.

The ports and endpoints are not part (or have not been a part) of Device 
tree itself, but they are the established practice on Linux and they 
have worked well. Yet they do not have anything Linux specific as such: 
they simply are a mechanism to describe the hardware.

-- 
Kind regards,

Sakari Ailus
sakari.ailus@linux.intel.com
