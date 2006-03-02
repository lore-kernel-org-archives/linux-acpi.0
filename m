From: Andi Kleen <ak@suse.de>
Subject: Re: 2.6.16rc5 'found' an extra CPU.
Date: Thu, 2 Mar 2006 13:14:04 +0100
Message-ID: <200603021314.04601.ak@suse.de>
References: <F7DC2337C7631D4386A2DF6E8FB22B30063BFB95@hdsmsx401.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.suse.de ([195.135.220.2]:11220 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751164AbWCBMMJ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 2 Mar 2006 07:12:09 -0500
In-Reply-To: <F7DC2337C7631D4386A2DF6E8FB22B30063BFB95@hdsmsx401.amr.corp.intel.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Brown, Len" <len.brown@intel.com>
Cc: Dave Jones <davej@redhat.com>, "Raj, Ashok" <ashok.raj@intel.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

On Thursday 02 March 2006 06:49, Brown, Len wrote:

> I'm afraid that even after we get this stuff out of /proc
> and into sysfs where it belongs, we'll have to leave /proc/acpi around
> for a while b/c unfortunately people are under the impression
> that the path names there actually mean something and
> they can actually count on them -- which they can't.

But they should. Once you provide an interface here you 
have to provide it essentially forever. Or at least if you really
change it use a very long deprecation period, but even that 
is a bad thing to do to users.

-Andi
