From: Lukas Wunner <lukas@wunner.de>
Subject: Re: ACPICA regression for empty ResourceTemplates
Date: Wed, 28 Jun 2017 10:59:13 +0200
Message-ID: <20170628085913.qq3vzqrb6mvwiirg@wunner.de>
References: <20170627185917.GA14927@innovation.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mailout1.hostsharing.net ([83.223.95.204]:39351 "EHLO
        mailout1.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751533AbdF1I7Q (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 28 Jun 2017 04:59:16 -0400
Content-Disposition: inline
In-Reply-To: <20170627185917.GA14927@innovation.ch>
 <CAJZ5v0iXWdz2TfHdfCZ-gyi9G=CTKc+cnFCY9bzUJFAGkoLHHQ@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>, "Life is hard, and then you die" <ronald@innovation.ch>
Cc: "Moore, Robert" <robert.moore@intel.com>, "Zheng, Lv" <lv.zheng@intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>

On Tue, Jun 27, 2017 at 11:59:17AM -0700, Life is hard, and then you die wrote:
> On Tue, Jun 27, 2017 at 11:24:25AM +0200, Lukas Wunner wrote:
> > On Tue, Jun 27, 2017 at 01:19:31AM +0000, Zheng, Lv wrote:
> > > > On Mon, Jun 26, 2017 at 10:38 AM, Lukas Wunner <lukas@wunner.de> wrote:
> > > > > ACPICA commit c8eac101 (= Linux commit a83019eb9f1f, "ACPICA: Update
> > > > > resource descriptor handling") is causing a regression when parsing
> > > > > an empty ResourceTemplate:
> > > 
> > > Can it be fixed by using this logic:
> > > if (AmlLength < sizeof (AML_RESOURCE_END_TAG) && AmlLength)
> > > Instead of the logic introduced in commit a83019eb9f1f?
> > > if (AmlLength < sizeof (AML_RESOURCE_END_TAG))
> > 
> > Unfortunately not, AmlLength is not 0 but 2 in this case
> > (= sizeof(struct aml_resource_end_tag)).
> 
> Actually, that will work here (the use of '<' ensures that).

Ugh, right, I had missed that the = was gone in Lv's suggestion, sorry.


On Tue, Jun 27, 2017 at 05:31:52PM +0200, Rafael J. Wysocki wrote:
> So I will drop this commit for now and I will add it again along with
> the next release material to avoid triggering regressions in the
> meantime.

Okay, thanks for the speedy response Rafael and Robert!

Lukas
