From: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH] nfit: add a module parameter to ignore ars errors
Date: Wed, 6 Jan 2016 21:34:49 -0800
Message-ID: <CAPcyv4i3NoioXFRGjyVA=jMOnUw1sx4p7U0_tniRBpo4TJYJiA@mail.gmail.com>
References: <1451946883-28092-1-git-send-email-vishal.l.verma@intel.com>
	<568D4AE6.5020601@hpe.com>
	<1452135717.23678.2.camel@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-yk0-f179.google.com ([209.85.160.179]:36551 "EHLO
	mail-yk0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750732AbcAGFeu (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 7 Jan 2016 00:34:50 -0500
Received: by mail-yk0-f179.google.com with SMTP id v14so235876670ykd.3
        for <linux-acpi@vger.kernel.org>; Wed, 06 Jan 2016 21:34:49 -0800 (PST)
In-Reply-To: <1452135717.23678.2.camel@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Vishal Verma <vishal@kernel.org>
Cc: Linda Knippers <linda.knippers@hpe.com>, Vishal Verma <vishal.l.verma@intel.com>, "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, Linux ACPI <linux-acpi@vger.kernel.org>

On Wed, Jan 6, 2016 at 7:01 PM, Vishal Verma <vishal@kernel.org> wrote:
> On Wed, 2016-01-06 at 12:12 -0500, Linda Knippers wrote:
>> On 1/4/2016 5:34 PM, Vishal Verma wrote:
>> > Normally, if a platform does not advertise support for Address
>> > Range
>> > Scrub (ARS), we skip it. But if ARS is advertised, it is expected
>> > to
>> > always succeed. If it fails, we normally fail initialization at
>> > that
>> > point.
>> >
>> > Add a module parameter to nfit that lets it ignore ARS failures and
>> > continue with initialization for debugging.
>>
>> Could ARS be so broken that you might want to just ignore it
>> altogether
>> and not even make the requests?
>>
>
> That is a possibility, and I considered it, but I thought it might be
> better to see how it fails and then just ignore the errors..
> It boils down to how much we trust the firmware, and hopefully if it
> advertises ARS as implemented, it should not be completely broken..
>
> Dan, thoughts?
>

Hmm, once we add plumbing for bad block clearing / setting we'll have
the tools to workaround firmware with untrusted ars results.  i.e.
just manually correct false positive / negative entries.
