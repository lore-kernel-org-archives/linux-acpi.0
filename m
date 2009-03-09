From: Ferenc Wagner <wferi@niif.hu>
Subject: Re: 2.6.29-rc7 does not power off on halt
Date: Mon, 09 Mar 2009 23:48:16 +0100
Message-ID: <87sklme2j3.fsf@tac.ki.iif.hu>
References: <87vdqishgp.fsf@tac.ki.iif.hu> <200903092222.18562.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from tac.ki.iif.hu ([193.6.222.43]:45010 "EHLO tac.ki.iif.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755994AbZCIWsU (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 9 Mar 2009 18:48:20 -0400
Received: from wferi by tac.ki.iif.hu with local (Exim 4.69)
	(envelope-from <wferi@niif.hu>)
	id 1LgoGe-0008F3-Ja
	for linux-acpi@vger.kernel.org; Mon, 09 Mar 2009 23:48:16 +0100
In-Reply-To: <200903092222.18562.rjw@sisk.pl> (Rafael J. Wysocki's message of
	"Mon, 9 Mar 2009 22:22:18 +0100")
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

"Rafael J. Wysocki" <rjw@sisk.pl> writes:

> On Monday 09 March 2009, Ferenc Wagner wrote:
> 
>> The current git kernel doesn't switch off power as the last step of
>> system halt (-p) on our Atom systems.  Everything seems to be all
>> right, just the power remains on.  Is this a known issue perhaps?
>
> Not really.  Does it happen with 2.6.28 too?

I didn't test 2.6.28, but 2.6.24 exhibits the same issue.  I can try
2.6.28.7 (or any other version) if you deem it useful.  I started
compiling, but probably won't have a chance to test until tomorrow.
-- 
Thanks,
Feri.
