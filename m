From: Ferenc Wagner <wferi@niif.hu>
Subject: Re: 2.6.29-rc7 does not power off on halt
Date: Wed, 11 Mar 2009 13:44:43 +0100
Message-ID: <87k56wteis.fsf@tac.ki.iif.hu>
References: <87vdqishgp.fsf@tac.ki.iif.hu> <200903092222.18562.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from tac.ki.iif.hu ([193.6.222.43]:53330 "EHLO tac.ki.iif.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751992AbZCKMov (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 11 Mar 2009 08:44:51 -0400
In-Reply-To: <200903092222.18562.rjw@sisk.pl> (Rafael J. Wysocki's message of
	"Mon, 9 Mar 2009 22:22:18 +0100")
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-acpi@vger.kernel.org

"Rafael J. Wysocki" <rjw@sisk.pl> writes:

> On Monday 09 March 2009, Ferenc Wagner wrote:
> 
>> The current git kernel doesn't switch off power as the last step of
>> system halt (-p) on our Atom systems.  Everything seems to be all
>> right, just the power remains on.  Is this a known issue perhaps?
>
> Not really.  Does it happen with 2.6.28 too?

Yes.  They don't power off under 2.6.24, 2.6.28.7 nor 2.6.29-rc7.
So this isn't a new issue.
-- 
Regards,
Feri.
