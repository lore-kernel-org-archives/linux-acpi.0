From: Frans Pop <elendil@planet.nl>
Subject: Re: [patch 08/12] thermal: add sanity check for the passive attribute
Date: Wed, 18 Nov 2009 00:07:14 +0100
Message-ID: <200911180007.16167.elendil@planet.nl>
References: <200911172227.nAHMRZX8023365@imap1.linux-foundation.org> <200911172342.58802.elendil@planet.nl> <20091117225204.GB24273@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cpsmtpm-eml110.kpnxchange.com ([195.121.3.14]:64114 "EHLO
	CPSMTPM-EML110.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756410AbZKQXHL (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 17 Nov 2009 18:07:11 -0500
In-Reply-To: <20091117225204.GB24273@srcf.ucam.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: akpm@linux-foundation.org, lenb@kernel.org, linux-acpi@vger.kernel.org, rui.zhang@intel.com

On Tuesday 17 November 2009, Matthew Garrett wrote:
> On Tue, Nov 17, 2009 at 11:42:55PM +0100, Frans Pop wrote:
> > On Tuesday 17 November 2009, Matthew Garrett wrote:
> > > As noted before, I'm not a fan of this approach - I can't think of
> > > many reasons why it'd be necessary to use temperatures below 1
> > > degree C, but this constraint isn't present anywhere else in the
> > > thermal code and, really, there's plenty of things that people can
> > > break if they just echo incorrect values into /sys.
> >
> > Personally I'd be in favor of adding more sanity checks rather than
> > removing them. The cost of the check is virtually zero.
>
> It makes something that's potentially useful to someone impossible, for
> the benefit of people who can crash their system in half a dozen other
> ways by writing inappropriate values into other files.

If you can give me one valid use case for someone running a system with a 
thermal zone check below 1C I'll agree with you.

Cheers,
FJP
