From: Berthold Cogel <cogel@rrz.uni-koeln.de>
Subject: Re: Acer smart battery: acpi_sbs and linux-2.6.17
Date: Wed, 28 Jun 2006 00:20:48 +0200
Message-ID: <44A1AF40.3020701@rrz.uni-koeln.de>
References: <449F18D9.7060507@rrz.uni-koeln.de>	<m2zmfyykrz.fsf@phoenix.squirrel.nl> <m2veqmy6eb.fsf@phoenix.squirrel.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp-out.rrz.uni-koeln.de ([134.95.19.53]:33498 "EHLO
	smtp-out.rrz.uni-koeln.de") by vger.kernel.org with ESMTP
	id S1422676AbWF0WUr (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 27 Jun 2006 18:20:47 -0400
In-Reply-To: <m2veqmy6eb.fsf@phoenix.squirrel.nl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Johan Vromans <jvromans@squirrel.nl>
Cc: linux-acpi@vger.kernel.org

Johan Vromans wrote:
> Johan Vromans <jvromans@squirrel.nl> writes:
> 
>> Hmm. I've yet to see this problem, but I'll be careful (and save
>> often) for a while.
> 

It's not that dangerous. The modules 'simply' stop working.... No crash
or lost data. Until now ...

> But I seem to have lost the ability to hibernate/resume. I consistently
> get "swsusp: not enough free memory". Does 2.6.17 take so much more
> memory than 2.6.16?
> 

For my System it's only about 1 MB difference in runlevel 1 with
2.6.17.1 compared with 2.6.16.20. But I'm using suspend to disk with
suspend2.


Berthold
