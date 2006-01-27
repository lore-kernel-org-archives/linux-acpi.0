From: Johan Vromans <jvromans@squirrel.nl>
Subject: Re: UBUNTU - acpi battery on ACER TRAVELMATE 4000 WLMI
Date: Fri, 27 Jan 2006 12:43:28 +0100
Message-ID: <m21wytlwv3.fsf@phoenix.squirrel.nl>
References: <F7DC2337C7631D4386A2DF6E8FB22B3005D98454@hdsmsx401.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp-vbr15.xs4all.nl ([194.109.24.35]:45061 "EHLO
	smtp-vbr15.xs4all.nl") by vger.kernel.org with ESMTP
	id S964986AbWA0Lni (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 27 Jan 2006 06:43:38 -0500
In-Reply-To: <F7DC2337C7631D4386A2DF6E8FB22B3005D98454@hdsmsx401.amr.corp.intel.com> (Len
 Brown's message of "Thu, 26 Jan 2006 15:27:00 -0500")
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Brown, Len" <len.brown@intel.com>
Cc: Marco Giumelli <mr.giumo@gmail.com>, linux-acpi@vger.kernel.org

"Brown, Len" <len.brown@intel.com> writes:

> I wish the repository of DSDTs on sourceforge.net would simply GO
> AWAY for this reason. It is a crutch that makes Linux WORSE, NOT
> BETTER.

I too run Linux (Fedora Core) on a TravelMate 4001WLMi[1]. I needed to
change the DSDT since it returned the wrong values for the processor
speeds (!) which, I have been assured, is not an uncommon problem. No
other changes were necessary. In fact, I could have continued using
the unmodified DSDT except for the frequencey scaling.

For the smart battery, I use the original, EC based implementation by
Rich Townsend, and it works like a charm.

Later (AFAIK) Rich went to a DSDT-based approach of the smart battery
problem. I personally prefer the EC based version.

-- Johan

[1] http://www.squirrel.nl/people/jvromans/articles/TM4001WLMi/index.html
