From: Johan Vromans <jvromans@squirrel.nl>
Subject: Re: Was: Re: UBUNTU - acpi battery on ACER TRAVELMATE 4000 WLMI
Date: Sat, 22 Apr 2006 20:27:29 +0200
Message-ID: <m23bg5ihym.fsf@phoenix.squirrel.nl>
References: <F7DC2337C7631D4386A2DF6E8FB22B3005D98454@hdsmsx401.amr.corp.intel.com>
	<m21wytlwv3.fsf@phoenix.squirrel.nl>
	<4446C84B.7020104@rrz.uni-koeln.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp-vbr6.xs4all.nl ([194.109.24.26]:52489 "EHLO
	smtp-vbr6.xs4all.nl") by vger.kernel.org with ESMTP
	id S1750812AbWDVS1f (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 22 Apr 2006 14:27:35 -0400
In-Reply-To: <4446C84B.7020104@rrz.uni-koeln.de> (Berthold Cogel's message
 of "Thu, 20 Apr 2006 01:31:23 +0200")
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Berthold Cogel <cogel@rrz.uni-koeln.de>
Cc: linux-acpi@vger.kernel.org

Berthold Cogel <cogel@rrz.uni-koeln.de> writes:

> The latest patch from the sbs-linux (Rich Townsend) project works only
> for kernel versions up to 2.6.15.x for my Acer Extensa 3002 WLMi.

I managed to get the latest acpi-sbs (20050120) going on 2.6.16.
I have no idea what the impact of my changes is to the rest of the
kernel, but I got my familiar battery readings back.
Drop me a line if you want to give it a try. At your own risk, of
course...

-- Johan
