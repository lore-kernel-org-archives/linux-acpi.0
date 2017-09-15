From: Rob Herring <robh@kernel.org>
Subject: Re: [RFC 0/5] Align and document return values of phandle and
 reference parsing for OF and ACPI
Date: Fri, 15 Sep 2017 14:57:35 -0500
Message-ID: <CAL_JsqKZVN+X0F3Z8s6Qv+ioh8LBDjNe277MAw30T3CXXTUV1Q@mail.gmail.com>
References: <20170914122914.14122-1-sakari.ailus@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:55234 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751584AbdIOT55 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 15 Sep 2017 15:57:57 -0400
In-Reply-To: <20170914122914.14122-1-sakari.ailus@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>, Frank Rowand <frowand.list@gmail.com>

On Thu, Sep 14, 2017 at 7:29 AM, Sakari Ailus
<sakari.ailus@linux.intel.com> wrote:
> Hi everyone,
>
> I recently came across a difference in behaviour of OF phandle parsing and
> ACPI reference parsing, both of which can soon be accessed using
> fwnode_property_get_reference_args.
>
> The main change in this proposal touches OF, and specifically the change
> is about using -ENODATA to tell that the phandle reference list entry that
> was accessed does not exist. -ENOENT was used previously, but the same
> error code was also used to tell that a phandle was empty, making it
> impossible for the caller to figure out which of the two was the case.
>
> I'm sending the set as RFC. In my limited testing I have found no ill
> effects.
>
> These patches are on top of linux-next.
>
> Comments on the approach and the changes themselves would be most welcome.

It's not really valid to both have a variable count (and hence need to
retrieve it) and use blank phandle entries. The whole point of blank
entries is to have a fixed length and know what each index corresponds
too. Do you have an example where we hit this?

Rob
