From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v6 0/3] Preparation for further fwnode property cleanup
Date: Mon, 5 Jun 2017 10:12:24 -0500
Message-ID: <CAL_JsqJtB-UVNLo3SM6apB-MODOSWwZzgeAE+ifsmT7U-5WJmw@mail.gmail.com>
References: <1495637635-26057-1-git-send-email-sakari.ailus@linux.intel.com> <20170531122849.GG1019@valkosipuli.retiisi.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:47526 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751162AbdFEPMv (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 5 Jun 2017 11:12:51 -0400
In-Reply-To: <20170531122849.GG1019@valkosipuli.retiisi.org.uk>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Sakari Ailus <sakari.ailus@iki.fi>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Frank Rowand <frowand.list@gmail.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Sudeep Holla <sudeep.holla@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Mark Brown <broonie@kernel.org>, Al Stone <ahs3@redhat.com>, Kieran Bingham <kieran.bingham@ideasonboard.com>

On Wed, May 31, 2017 at 7:28 AM, Sakari Ailus <sakari.ailus@iki.fi> wrote:
> Hi Rob,
>
> On Wed, May 24, 2017 at 05:53:52PM +0300, Sakari Ailus wrote:
>> Hi Rob, Frank, others,
>>
>> Here's the 6th version of what used to be a single patch to prepare for
>> fwnode property cleanup.
>>
>> Beyond this, I have a couple of other patchsets I'll post in the near
>> future:
>>
>> - fwnode property cleanup (for linux-pm) which moves the property API
>> implementation to FW specific locations; depends on these patches,
>>
>> - V4L2 fwnode patches (for media_tree, no unmerged dependencies, pull
>>   request sent) and
>>
>> - fwnode const patchset which allows making the fwnode argument for the
>>   property API functions const. It depends on both of the previous sets.
>>   Might be for linux-pm.
>
> I figured out that others are starting to have patches that depend on my
> other patchsets getting merged. Those patches are for the fwnode property
> API that most likely should go through the linux-pm tree as well as for the
> media tree.
>
> <URL:http://www.spinics.net/lists/linux-media/msg115893.html>
>
> I have hopes of being able to get the fwnode cleanup patchset (which the
> aforementioned patches depend on) in within this merge window --- assuming I
> could have your ack on the OF portions.
>
> Would it be possible to have an immutable branch for these or would you
> accept a pull request on v4.12-rc1?

I've applied this series. The stable branch is here:

git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git dt/property-move

Rob
