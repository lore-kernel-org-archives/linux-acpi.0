From: Thomas Renninger <trenn@suse.de>
Subject: Re: FAN Processor and Thermap
Date: Thu, 16 Apr 2009 16:06:39 +0200
Message-ID: <200904161606.40096.trenn@suse.de>
References: <335b7d740903190118r32d6f4d4ia9146bf2f0d9f6f@mail.gmail.com> <335b7d740904122031i2d1aa7d8s141e81baf2bfb087@mail.gmail.com> <51f3faa70904122256wadabe78m190970794b3b9815@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:44895 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752873AbZDPOGm (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 16 Apr 2009 10:06:42 -0400
In-Reply-To: <51f3faa70904122256wadabe78m190970794b3b9815@mail.gmail.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Robert Hancock <hancockrwd@gmail.com>
Cc: yakui_zhao <yakui.zhao@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Monday 13 April 2009 07:56:46 Robert Hancock wrote:
> On Sun, Apr 12, 2009 at 9:31 PM, Ken Perl <kenperl@gmail.com> wrote:
> > I have no idea if my board supports ACPI or not, what's the reason to
> > try a older kernel? is it because older kernel supports older board?
> 
> Possibly there's been some regression causing ACPI to not be detected
> on that board. But the board is old enough, I think it's quite likely
> it doesn't support ACPI at all.
Yep, I expect acpi=off is the parameter your searching for.
I wonder whether it could be set automatically, but above parameter
is well known for old machines.

   Thomas
