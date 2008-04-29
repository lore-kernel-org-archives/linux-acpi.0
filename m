From: Mattia Dongili <malattia@linux.it>
Subject: Re: [PATCH 1/3] Correctly detect Sony TX770P PIC device type
Date: Tue, 29 Apr 2008 20:45:42 +0900
Message-ID: <20080429114542.GA7468@inferi.kami.home>
References: <1208558495-22792-1-git-send-email-ynvich@gmail.com> <20080427061521.GB9533@inferi.kami.home> <4816E1B5.4030304@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from static-220-247-10-204.b-man.svips.gol.ne.jp ([220.247.10.204]:50853
	"EHLO tadamune.kami.home" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751216AbYD2Lpp (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 29 Apr 2008 07:45:45 -0400
Content-Disposition: inline
In-Reply-To: <4816E1B5.4030304@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Sergey Yanovich <ynvich@gmail.com>
Cc: linux-acpi@vger.kernel.org

On Tue, Apr 29, 2008 at 11:52:05AM +0300, Sergey Yanovich wrote:
> Mattia Dongili wrote:
>> What I'm going to do is remove the Type3/Type4 distinction, this should
>> be enough.
>
> Great to hear, that the problem is being addressed. It'll be nice to  
> have all keys working with a stock kernel.
>
> Any comments about wifi power and state sync patches?

Yes, they are missing your sign off ;)

The wifi power patch seems ok.
The state sync patch instead I'd like to rework things a little but it
definitely makes sense.

Oh, last but not least, give your patches a go through
scripts/checkpatch.pl

Thanks
-- 
mattia
:wq!
