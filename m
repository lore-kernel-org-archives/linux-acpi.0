From: "Zhang, Rui" <rui.zhang@intel.com>
Subject: RE: [Patch v2] Implement thermal limiting in the generic thermal class
Date: Wed, 18 Jun 2008 17:28:01 +0800
Message-ID: <823A93EED437D048963A3697DB0E35DE0171191C@pdsmsx414.ccr.corp.intel.com>
References: <20080611100647.GA20013@srcf.ucam.org> <20080616085544.GA17813@srcf.ucam.org> <20080616092648.GA18506@srcf.ucam.org> <20080617185345.GA5847@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:19701 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751702AbYFRJ2G convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 18 Jun 2008 05:28:06 -0400
Content-class: urn:content-classes:message
In-Reply-To: <20080617185345.GA5847@ucw.cz>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Pavel Machek <pavel@suse.cz>, Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, trenn@suse.de

One thing I'm concerning is that if we could enable polling in Linux.
Bug #8842 shows that polling may break some laptops.
And we have known that windows never enable polling.
Although this patch will not break the laptop in #8842, it still may
bring some potential risks if we enable polling in Linux.
IMO, a dmi entry would be much more acceptable...

Thanks,
rui

>-----Original Message-----
>From: Pavel Machek [mailto:pavel@suse.cz]
>Sent: Wednesday, June 18, 2008 2:54 AM
>To: Matthew Garrett
>Cc: Zhang, Rui; linux-acpi@vger.kernel.org;
linux-kernel@vger.kernel.org
>Subject: Re: [Patch v2] Implement thermal limiting in the generic
thermal class
>
>Hi!
>
>> In the absence of an explicitly defined passive cooling zone any
>> machine unable to manage its thermal profile through active cooling
will
>> reach its critical shutdown temperature and power off, resulting in
>> potential data loss. Add support to the generic thermal class for
>> initiating passive cooling at a temperature defaulting to just below
the
>> critical temperature, with this value being overridable by the admin
via
>> sysfs.
>
>This means we get two copies of passive cooling code: one generic, and
>one in acpi. Can we make sure we have just one of them?
>
>--
>(english) http://www.livejournal.com/~pavelmachek
>(cesky, pictures)
>http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
