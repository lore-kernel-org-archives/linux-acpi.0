From: Jean Delvare <khali@linux-fr.org>
Subject: Re: [PATCH] ACPI: add "auto" to acpi_enforce_resources
Date: Tue, 24 Mar 2009 14:43:15 +0100
Message-ID: <20090324144315.196273ed@hyperion.delvare>
References: <alpine.LFD.2.00.0902040042570.9833@localhost.localdomain>
	<498953DF.5050306@redhat.com>
	<20090204131708.GA2739@srcf.ucam.org>
	<20090204142606.1823661b@hyperion.delvare>
	<20090204142015.GB3923@srcf.ucam.org>
	<20090210145716.105ab58b@hyperion.delvare>
	<20090210140829.GA25397@srcf.ucam.org>
	<49919E08.5050002@redhat.com>
	<20090210172408.400cacee@hyperion.delvare>
	<20090227132740.GF1482@ucw.cz>
	<68676e00903240539i119b6d26j516ee131d4cd6781@mail.gmail.com>
	<49C8DE51.2010103@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from zone0.gcu-squad.org ([212.85.147.21]:10971 "EHLO
	services.gcu-squad.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752599AbZCXNna (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 24 Mar 2009 09:43:30 -0400
In-Reply-To: <49C8DE51.2010103@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Luca Tettamanti <kronos.it@gmail.com>, linux-kernel@vger.kernel.org, Matthew Garrett <mjg@redhat.com>, Len Brown <lenb@kernel.org>, Thomas Renninger <trenn@suse.de>, linux-acpi@vger.kernel.org, Pavel Machek <pavel@ucw.cz>

Hi Hans, Luca,

On Tue, 24 Mar 2009 14:21:21 +0100, Hans de Goede wrote:
> On 03/24/2009 01:39 PM, Luca Tettamanti wrote:
> > the merge window for .30 is now open, what are we going to do with this issue?
> 
> I think the consensus was to make the default strict and to merge the atk0110
> driver, right?

Yes.

> Note that we've been running this setup in Fedora kernels for quite a while now,
> and have had only one bug report, which was solved by simply explaining why this
> was done.

Maybe the explanation in question could be added somewhere, either in
the help text of CONFIG_HWMON, or somewhere under Documentation/, or on
the lm-sensors.org wiki? I expect the question to be asked more
frequently once the default changes upstream, and I would like avoiding
wasting developer time replying again and again. Having the possibility
to point users to a clear explanation would be very pleasant.

-- 
Jean Delvare
