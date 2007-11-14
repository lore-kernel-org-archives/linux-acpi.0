From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Subject: Re: [patch 0/8] ACPI Video various cleanups & fixes
Date: Wed, 14 Nov 2007 10:04:26 -0500
Message-ID: <d120d5000711140704v447b7604xfb2aeada6410bf2a@mail.gmail.com>
References: <20071105164328.982283020@anvil.corenet.prv>
	 <1195024662.1262.41.camel@acpi-hp.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.173]:18122 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752585AbXKNPE3 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 14 Nov 2007 10:04:29 -0500
Received: by ug-out-1314.google.com with SMTP id z38so310306ugc
        for <linux-acpi@vger.kernel.org>; Wed, 14 Nov 2007 07:04:27 -0800 (PST)
In-Reply-To: <1195024662.1262.41.camel@acpi-hp.sh.intel.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>, "Brown, Len" <len.brown@intel.com>
Cc: linux-acpi@vger.kernel.org

On 11/14/07, Zhang Rui <rui.zhang@intel.com> wrote:
> On Tue, 2007-11-06 at 00:43 +0800, Dmitry Torokhov wrote:
> > Hi Len, Rui,
> >
> > Here is a group of cleanups and patches to the acpi video driver.
> > Originally I just wanted to fix sysfs placement of input devices
> > created by the driver, but then I saw some more potential issues.
> >
> > The patches are against Linus's tree, please let me know if you
> > want them redone against something else.
> >
> Hi, Dmitry,
>
> Thanks for your patches and sorry for the delay.
>
> The patches are good and I'm okay with most of them.
> Detailed comments are inline.

Thank you very much for reviewing them.

Len, it would be nice if the very first patch (sysfs one) made in 2.6.24.

Thank you,
Dmitry
