From: Mattia Dongili <malattia@linux.it>
Subject: Re: sony-laptop on AR series
Date: Sun, 27 Jan 2008 22:45:16 +0900
Message-ID: <20080127134516.GA3333@inferi.kami.home>
References: <17b35fe50801230233jda8e183qf380ec153c26020c@mail.gmail.com> <20080126035059.GA24583@inferi.kami.home> <17b35fe50801260746g3d593651h50a273913dcd1642@mail.gmail.com> <20080127125001.GA335@inferi.kami.home> <17b35fe50801270516x41b287f2p150dcaf41130c8e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mtoichi14.ns.itscom.net ([219.110.2.184]:64197 "EHLO
	mtoichi14.ns.itscom.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753258AbYA0Npe (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 27 Jan 2008 08:45:34 -0500
Content-Disposition: inline
In-Reply-To: <17b35fe50801270516x41b287f2p150dcaf41130c8e@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: eaglex <eaglex@gmail.com>
Cc: linux-acpi@vger.kernel.org

On Sun, Jan 27, 2008 at 03:16:27PM +0200, eaglex wrote:
...
> > For now all sony-laptop can do is enable the Fn keys, I'll add your
> > model to the DMI list asap.
> 
> Any chances of getting the rest of the controls working? (like turning
> on bluetooth and so on)

well, not until somebody is able to trace which SNC device methods (if
any at all) are called to control the extra features.
Unfortunately there are no specs available for it.

ciao
-- 
mattia
:wq!
