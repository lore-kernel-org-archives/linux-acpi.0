From: Berthold Cogel <cogel@rrz.uni-koeln.de>
Subject: Re: Was: Re: UBUNTU - acpi battery on ACER TRAVELMATE 4000 WLMI
Date: Fri, 21 Apr 2006 00:45:31 +0200
Message-ID: <44480F0B.5020106@rrz.uni-koeln.de>
References: <F7DC2337C7631D4386A2DF6E8FB22B3005D98454@hdsmsx401.amr.corp.intel.com>	<m21wytlwv3.fsf@phoenix.squirrel.nl>	<4446C84B.7020104@rrz.uni-koeln.de> <m2vet41q9n.fsf@phoenix.squirrel.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp-out.rrz.uni-koeln.de ([134.95.19.53]:23494 "EHLO
	smtp-out.rrz.uni-koeln.de") by vger.kernel.org with ESMTP
	id S932106AbWDTWpk (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 20 Apr 2006 18:45:40 -0400
In-Reply-To: <m2vet41q9n.fsf@phoenix.squirrel.nl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Johan Vromans <jvromans@squirrel.nl>
Cc: linux-acpi@vger.kernel.org

Johan Vromans wrote:
> Berthold Cogel <cogel@rrz.uni-koeln.de> writes:
> 
>> What is the recommended way to solve the problem with the smart
>> battery for newer kernels?
> 
> The right solution is hal, but I don't know whether it has been picked
> up yet.
> 
> For the time being, I ported Rich' sbs-cm approach[1] to 2.6.16 and it
> seems to work okay.
> 
> -- Johan
> 
> https://sourceforge.net/project/showfiles.php?group_id=129330

Thanks! I've overlooked the patches at Sourceforge.
Is there any chance to get the patch into the kernel somehow?

Berthold


