From: dienet <dienet@poczta.fm>
Subject: Re: Resuming from hibernation on T61 with nvidia
Date: Wed, 16 Nov 2011 20:43:27 +0100
Message-ID: <op.v4102pcrwcw97g@localhost>
References: <op.v4z4ihs2wcw97g@localhost>
	<4EC2BED2.3000707@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtpo.poczta.interia.pl ([217.74.65.206]:45599 "EHLO
	smtpo.poczta.interia.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751383Ab1KPTnM (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 16 Nov 2011 14:43:12 -0500
In-Reply-To: <4EC2BED2.3000707@linux.vnet.ibm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Cc: linux-acpi@vger.kernel.org, Linux PM mailing list <linux-pm@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>

On Tue, 15 Nov 2011 20:34:42 +0100, Srivatsa S. Bhat  
<srivatsa.bhat@linux.vnet.ibm.com> wrote:

> You can try using the pm_test framework for debugging this, to a certain
> extent. See Documentation/power/basic-pm-debugging.txt for details on how
> to use it.

So I run some test:

Using platform in state file:

1. echo freezer > pm_test - no problems.
2. echo devices > pm_test - problems: no picture (LCD is up and shining,  
but there is only black picture [even after 60 seconds]). I can use power  
button to shut down the system. Other keyboard keys are not working (I was  
trying to type reboot with no luck).
3. echo processors > pm_test - the same as above
4. echo core > pm_test - the same as above
5. I turn off the X11 (telinit 2), but the nvidia module is still loaded -  
no problems.
6. I left X11 working on f7 (7th tty) and switch to f1 (1st tty) - echo  
core > pm_test works OK, but switching back to X11 (alt+f7) will give me  
the same as in 2. I can change the brightness of black screen, but I can  
not go back to tty1 (ctrl+alt+f1).

Is there more I can do?

-- 
pozdr0
dienet

"Old C programmers never die. They're just cast into void."

----------------------------------------------------------------
Mamy mieszkanie wlasnie dla Ciebie! 
Sprawdz >>
http://linkint.pl/f2a80
