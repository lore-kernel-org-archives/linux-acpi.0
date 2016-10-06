From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [RFC 00/15] ACPI graph support
Date: Thu, 6 Oct 2016 16:57:26 +0100
Message-ID: <9b114e93-81d5-9e62-874a-8b598e9c5bda@arm.com>
References: <20161005092215.GA20248@red-moon>
 <20161005114129.GI1765@lahna.fi.intel.com> <20161005150641.GA22282@red-moon>
 <20161005153229.GO1765@lahna.fi.intel.com> <20161005161800.GA22433@red-moon>
 <CAJZ5v0jNSEQ6Uk4T-19jA=RV9pmRzojB4FBd=SFAo6VOj-SLLg@mail.gmail.com>
 <20161006085703.GA22776@red-moon> <20161006091133.GF30800@lahna.fi.intel.com>
 <20161006104058.uqdkv3pfihicxyfv@sirena.org.uk>
 <CAJZ5v0htdbUpqZNPi00ieNJ5WWiAczK+LbKLYobNGAr3Sr+HWw@mail.gmail.com>
 <20161006152307.pqmmkazctqwlxsmy@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:60512 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S942091AbcJFP5b (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 6 Oct 2016 11:57:31 -0400
In-Reply-To: <20161006152307.pqmmkazctqwlxsmy@sirena.org.uk>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Sakari Ailus <sakari.ailus@linux.intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh@kernel.org>, Al Stone <ahs3@redhat.com>



On 06/10/16 16:23, Mark Brown wrote:
> On Thu, Oct 06, 2016 at 03:15:36PM +0200, Rafael J. Wysocki wrote:
>> On Thu, Oct 6, 2016 at 12:40 PM, Mark Brown <broonie@kernel.org> wrote:
>


[...]

>> The point here is that some things just don't conflict with
>> ACPI-defined HW control even potentially and they can be handled with
>> the help of _DSD properties just fine.  Thus, there are no technical
>> obstacles to do that, at least not in principle.
>
> It feels like we should be aiming for a higher bar with defining things
> like this than simple technical possibility - my fear is that we end up
> with a mess down the line with people being far too gung ho about
> defining new bindings without trying to work on standards.  Perhaps I'm
> just worrying too much here but I'm not sure there's enough
> communication going on.  The private nature of ACPI standardization
> discussion doesn't help here of course.
>

+1

I too expressed similar concern, as you say may be that's just too much
over thinking. Or not, because every-time we think ARM vendors should
not do something stupid like this, they end up doing exactly same thing
in no time :))

-- 
Regards,
Sudeep
