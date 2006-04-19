From: Berthold Cogel <cogel@rrz.uni-koeln.de>
Subject: Was: Re: UBUNTU - acpi battery on ACER TRAVELMATE 4000 WLMI
Date: Thu, 20 Apr 2006 01:31:23 +0200
Message-ID: <4446C84B.7020104@rrz.uni-koeln.de>
References: <F7DC2337C7631D4386A2DF6E8FB22B3005D98454@hdsmsx401.amr.corp.intel.com> <m21wytlwv3.fsf@phoenix.squirrel.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp-out.rrz.uni-koeln.de ([134.95.19.53]:14259 "EHLO
	smtp-out.rrz.uni-koeln.de") by vger.kernel.org with ESMTP
	id S1751317AbWDSXb2 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 19 Apr 2006 19:31:28 -0400
Received: from smtp-auth.rrz.uni-koeln.de (smtp-auth.rrz.uni-koeln.de [134.95.19.93])
	by smtp-out.rrz.uni-koeln.de (8.13.6/8.13.5) with ESMTP id k3JNVQsg013398
	for <linux-acpi@vger.kernel.org>; Thu, 20 Apr 2006 01:31:26 +0200
Received: from [192.168.2.4] (p5087F3AC.dip.t-dialin.net [80.135.243.172])
	(authenticated as user a0537 using CRAM-MD5 bits=0)
	by smtp-auth.uni-koeln.de (8.13.6/8.13.5) with ESMTP id k3JNVHuS013376
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-acpi@vger.kernel.org>; Thu, 20 Apr 2006 01:31:26 +0200
In-Reply-To: <m21wytlwv3.fsf@phoenix.squirrel.nl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Johan Vromans wrote:

> I too run Linux (Fedora Core) on a TravelMate 4001WLMi[1]. I needed to
> change the DSDT since it returned the wrong values for the processor
> speeds (!) which, I have been assured, is not an uncommon problem. No
> other changes were necessary. In fact, I could have continued using
> the unmodified DSDT except for the frequencey scaling.
> 
> For the smart battery, I use the original, EC based implementation by
> Rich Townsend, and it works like a charm.
> 
> Later (AFAIK) Rich went to a DSDT-based approach of the smart battery
> problem. I personally prefer the EC based version.
> 

Hello!

The latest patch from the sbs-linux (Rich Townsend) project works only
for kernel versions up to 2.6.15.x for my Acer Extensa 3002 WLMi.

What is the recommended way to solve the problem with the smart battery
for newer kernels?

Regards
Berthold
