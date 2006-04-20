From: Johan Vromans <jvromans@squirrel.nl>
Subject: Re: Was: Re: UBUNTU - acpi battery on ACER TRAVELMATE 4000 WLMI
Date: Thu, 20 Apr 2006 12:43:16 +0200
Message-ID: <m2vet41q9n.fsf@phoenix.squirrel.nl>
References: <F7DC2337C7631D4386A2DF6E8FB22B3005D98454@hdsmsx401.amr.corp.intel.com>
	<m21wytlwv3.fsf@phoenix.squirrel.nl>
	<4446C84B.7020104@rrz.uni-koeln.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp-vbr7.xs4all.nl ([194.109.24.27]:8971 "EHLO
	smtp-vbr7.xs4all.nl") by vger.kernel.org with ESMTP
	id S1750799AbWDTKnV (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 20 Apr 2006 06:43:21 -0400
In-Reply-To: <4446C84B.7020104@rrz.uni-koeln.de> (Berthold Cogel's message
 of "Thu, 20 Apr 2006 01:31:23 +0200")
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Berthold Cogel <cogel@rrz.uni-koeln.de>
Cc: linux-acpi@vger.kernel.org

Berthold Cogel <cogel@rrz.uni-koeln.de> writes:

> What is the recommended way to solve the problem with the smart
> battery for newer kernels?

The right solution is hal, but I don't know whether it has been picked
up yet.

For the time being, I ported Rich' sbs-cm approach[1] to 2.6.16 and it
seems to work okay.

-- Johan

https://sourceforge.net/project/showfiles.php?group_id=129330
