From: Todd Pytel <tppytel@sophrosune.org>
Subject: Re: Hang on S3 resume with Acer TravelMate 222X
Date: Tue, 05 Sep 2006 01:41:06 -0500
Message-ID: <1157438466.19942.35.camel@timaeus.sophrosune.org>
References: <1157066944.1826.62.camel@timaeus.sophrosune.org>
	 <1157424745.19942.2.camel@timaeus.sophrosune.org>
	 <20060905061608.GA16903@cactii.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from aristotle.sophrosune.org ([66.167.100.107]:565 "EHLO
	aristotle.sophrosune.org") by vger.kernel.org with ESMTP
	id S1750708AbWIEGkS (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 5 Sep 2006 02:40:18 -0400
In-Reply-To: <20060905061608.GA16903@cactii.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ben B <kernel@bb.cactii.net>
Cc: linux-acpi@vger.kernel.org

Ben,

On Tue, 2006-09-05 at 08:16 +0200, Ben B wrote:
> Try unloading various modules before suspend. On many machines, at least
> the usb host drivers need to be unloaded.

OK, I'll give that a try. I don't have the machine with me to check at
the moment.

> Video's another possibility. Look at vbetool, it might be able to
> restore video and get things on track again.

Hmm... I read about vbetool in video.txt, but maybe I was
misunderstanding. From what I read, vbetool's restore function only
works after the resume gets back to userland. Since my machine is
hard-locking after the resume, I was assuming that vbetool would never
even get a chance to do its thing. Is it possible for the machine to get
back to running user processes and *then* hard lock?

> Also, do your suspend from a shell script, and have this script log
> debugging info after resume (remembering to sync in case you have to
> hard boot).

Similar questions as those about vbetool. But I'll give it a shot. 

Thanks for the suggestions.

--Todd

