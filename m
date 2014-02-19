From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH V2] Change ACPI IPMI support to "default y"
Date: Wed, 19 Feb 2014 01:45:58 +0100
Message-ID: <2013495.SnSbjHoB2r@vostro.rjw.lan>
References: <1392740909-2079-1-git-send-email-matthew.garrett@nebula.com> <1920764.8Poj9R8nZQ@vostro.rjw.lan> <1392765901.3488.4.camel@x230.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:52504 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752355AbaBSAbI (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 18 Feb 2014 19:31:08 -0500
In-Reply-To: <1392765901.3488.4.camel@x230.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <matthew.garrett@nebula.com>
Cc: "lenb@kernel.org" <lenb@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "minyard@acm.org" <minyard@acm.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Tuesday, February 18, 2014 11:25:02 PM Matthew Garrett wrote:
> On Wed, 2014-02-19 at 00:35 +0100, Rafael J. Wysocki wrote:
> > On Tuesday, February 18, 2014 11:15:08 PM Matthew Garrett wrote:
> > > For example, if you load the ACPI power meter driver before you've
> > > installed the ACPI IPMI driver you'll typically get failures (most
> > > vendors implement it via IPMI).
> > 
> > Well, any specific machine from any specific vendor?
> 
> The Dell R720 and HP DL385 both seem to have this configuration. I
> believe some Ciscos do, too.

I've queued this up for 3.15 (with the above info added to the changelog).

Thanks!

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
