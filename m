From: Frans Pop <elendil@planet.nl>
Subject: Re: [patch 08/12] thermal: add sanity check for the passive attribute
Date: Wed, 18 Nov 2009 00:12:21 +0100
Message-ID: <200911180012.23229.elendil@planet.nl>
References: <200911172227.nAHMRZX8023365@imap1.linux-foundation.org> <20091117225204.GB24273@srcf.ucam.org> <200911180007.16167.elendil@planet.nl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from Cpsmtpm-eml109.kpnxchange.com ([195.121.3.13]:56375 "EHLO
	CPSMTPM-EML109.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751198AbZKQXMS (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 17 Nov 2009 18:12:18 -0500
In-Reply-To: <200911180007.16167.elendil@planet.nl>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: akpm@linux-foundation.org, lenb@kernel.org, linux-acpi@vger.kernel.org, rui.zhang@intel.com

On Wednesday 18 November 2009, Frans Pop wrote:
> On Tuesday 17 November 2009, Matthew Garrett wrote:
> > On Tue, Nov 17, 2009 at 11:42:55PM +0100, Frans Pop wrote:
> > > On Tuesday 17 November 2009, Matthew Garrett wrote:
> > > > As noted before, I'm not a fan of this approach - I can't think of
> > > > many reasons why it'd be necessary to use temperatures below 1
> > > > degree C, but this constraint isn't present anywhere else in the
> > > > thermal code and, really, there's plenty of things that people can
> > > > break if they just echo incorrect values into /sys.
> > >
> > > Personally I'd be in favor of adding more sanity checks rather than
> > > removing them. The cost of the check is virtually zero.
> >
> > It makes something that's potentially useful to someone impossible,
> > for the benefit of people who can crash their system in half a dozen
> > other ways by writing inappropriate values into other files.
>
> If you can give me one valid use case for someone running a system with
> a thermal zone check below 1C I'll agree with you.

And to make it really realistic, it should be a use case which needs a 
value between 0 and 1 C and where a value of 1 doesn't work.
